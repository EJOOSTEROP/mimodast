ARG BASE_CONTAINER=meltano/meltano:v2.10.0-python3.9
# TODO: consider meltano/meltano:v2-python3.9
# metano tap-rest-api-msdk requires python ~3.9

FROM $BASE_CONTAINER as basepython

LABEL version="0.2"
LABEL "com.example.vendor"="Tern Analytics Inc"
LABEL description="Complete Minimal Modern Data Stack in one image. Extract, Load, Transform, scheduler, BI."
LABEL org.opencontainers.image.authors="Erik O"

COPY requirements.txt .
RUN pip install -r requirements.txt
#duckdb --> numpy-1.23.4

# For the healthcheck
RUN apt update \
&& apt install -y \
    curl \
&& rm -rf /var/lib/apt/lists/*

ARG PROJECT=mimodast
ARG MELTANO_PROJ_ROOT=project
RUN meltano init ${PROJECT}

WORKDIR /${MELTANO_PROJ_ROOT}/${PROJECT}

# ####################
#### RUN meltano add extractor tap-rest-api-msdk \
#### && meltano add loader target-duckdb \
#### && meltano add transformer dbt-duckdb \
#### && meltano add orchestrator airflow \
#### && meltano invoke airflow users create --username admin --firstname admin --lastname mimodast --role Admin --password admin --email a@example.com \
#### && meltano add utility superset \
#### && meltano invoke superset:create-admin --username admin --firstname admin --lastname mimodast --password admin --email a@example.com

# as opposed to copying the yml, create it afterwards through UI commands! For a schedule, not sure whether to create it before or after invoking airflow
#### COPY meltano.yml ./meltano.yml

# TODO: consider 'meltano install' - https://github.com/meltano/demo-project/blob/main/Dockerfile & https://docs.meltano.com/guide/plugin-management#discoverable-plugins 
# (last sentence in the section refers to meltano insall vs meltano add)
# (there is also a 'meltano update'). This could replace the meltano add above.

#### ENV MELTANO_LOAD_SCHEMA=main

# Installs based on info from copied meltano.yml above
#### RUN meltano install utility superset
# ####################

# ######################
# ######################
COPY meltano.yml ./meltano.yml
ENV MELTANO_LOAD_SCHEMA=main
RUN meltano install \
&& meltano upgrade files \
&& meltano invoke airflow users create --username admin --firstname admin --lastname mimodast --role Admin --password admin --email a@example.com \
&& meltano invoke superset:create-admin --username admin --firstname admin --lastname mimodast --password admin --email a@example.com \
&& meltano invoke dbt-duckdb:initialize

# ######################
# ######################

# Airflow DAGs
COPY ./dags/. /${MELTANO_PROJ_ROOT}/${PROJECT}/orchestrate/dags/

# TODO: Consider using ADD from Githhub; and untar https://docs.docker.com/engine/reference/builder/#add
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#add-or-copy
ARG DUCKDB_CLI_FOLDER=duckdb_cli
COPY ./DuckDB_CLI/duckdb_cli-linux-amd64 /${MELTANO_PROJ_ROOT}/${DUCKDB_CLI_FOLDER}

# TODO: put into a Docker volume? Just database or complete ${MELTANO_PROJ_ROOT} folder?
# https://docs.docker.com/engine/reference/builder/#volume
RUN mkdir -p /${MELTANO_PROJ_ROOT}/data/dev/ \
&& mkdir -p /${MELTANO_PROJ_ROOT}/data/test/ \
&& mkdir -p /${MELTANO_PROJ_ROOT}/data/prod/ \
&& /${MELTANO_PROJ_ROOT}/${DUCKDB_CLI_FOLDER}/duckdb /${MELTANO_PROJ_ROOT}/data/dev/data.duckdb "select * from pg_tables;" \
&& /${MELTANO_PROJ_ROOT}/${DUCKDB_CLI_FOLDER}/duckdb /${MELTANO_PROJ_ROOT}/data/test/data.duckdb "select * from pg_tables;" \
&& /${MELTANO_PROJ_ROOT}/${DUCKDB_CLI_FOLDER}/duckdb /${MELTANO_PROJ_ROOT}/data/prod/data.duckdb "select * from pg_tables;"

RUN meltano invoke airflow dags pause stage_gie_dag \
&& meltano invoke airflow dags pause stage_gie_backfill_dag

COPY ./standup/. .
RUN meltano invoke airflow variables import airflowvariables.json \
&& meltano invoke superset import-dashboards -p dashboards.zip
### \
### && meltano invoke superset import_datasources -p database.zip
### && meltano invoke superset import_datasources -p datasources.yml

COPY ./meltano_transform/. /${MELTANO_PROJ_ROOT}/${PROJECT}/transform/

HEALTHCHECK --interval=5m --timeout=3s --start-period=5m \
    CMD curl -f 0.0.0.0:8080 || exit 1

#meltano, airflow, superset, dbt docs, extra, extra
EXPOSE 5000 8080 8088 8089 8090 8091

#ENTRYPOINT ["tail", "-f", "/dev/null"]
COPY startup.sh ./startup.sh
ENTRYPOINT ["bash", "startup.sh"]
#ENTRYPOINT ["bash"]

# run the following: 
# meltano invoke airflow scheduler -D
# meltano invoke airflow webserver -D
# meltano invoke superset:ui #creates all sorts of warnings; not sure to what degree they matter
# meltano ui