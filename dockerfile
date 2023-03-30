ARG BASE_CONTAINER=meltano/meltano:v2.10.0-python3.9
# TODO: consider meltano/meltano:v2-python3.9
# metano tap-rest-api-msdk requires python ~3.9

FROM $BASE_CONTAINER as basepython

LABEL org.opencontainers.image.version="0.2.0"
LABEL org.opencontainers.image.authors="Erik Oosterop"
LABEL org.opencontainers.image.source=https://github.com/ejoosterop/mimodast
LABEL org.opencontainers.image.title="Mimodast"
LABEL org.opencontainers.image.description="Mimodast. A minimal modern data stack with working data pipelines in a single Docker container."
LABEL org.opencontainers.image.licenses=MIT

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

COPY meltano.yml ./meltano.yml
ENV MELTANO_LOAD_SCHEMA=main
RUN meltano install \
&& meltano upgrade files \
&& meltano invoke airflow users create --username admin --firstname admin --lastname mimodast --role Admin --password admin --email a@example.com \
&& meltano invoke superset:create-admin --username admin --firstname admin --lastname mimodast --password admin --email a@example.com \
&& meltano invoke dbt-duckdb:initialize

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
&& /${MELTANO_PROJ_ROOT}/${DUCKDB_CLI_FOLDER}/duckdb /${MELTANO_PROJ_ROOT}/data/dev/data.duckdb "select * from pg_tables;" 
###\
###&& /${MELTANO_PROJ_ROOT}/${DUCKDB_CLI_FOLDER}/duckdb /${MELTANO_PROJ_ROOT}/data/test/data.duckdb "select * from pg_tables;" \
###&& /${MELTANO_PROJ_ROOT}/${DUCKDB_CLI_FOLDER}/duckdb /${MELTANO_PROJ_ROOT}/data/prod/data.duckdb "select * from pg_tables;"

RUN meltano invoke airflow dags pause stage_gie_dag \
&& meltano invoke airflow dags pause stage_gie_backfill_dag

COPY ./standup/. .
RUN meltano invoke airflow variables import airflowvariables.json \
&& meltano invoke superset import-dashboards -p dashboards.zip
### \
### && meltano invoke superset import_datasources -p database.zip

COPY ./meltano_transform/. /${MELTANO_PROJ_ROOT}/${PROJECT}/transform/

HEALTHCHECK --interval=5m --timeout=3s --start-period=5m \
    CMD curl -f 0.0.0.0:8080 || exit 1

#meltano, airflow, superset, dbt docs, extra, extra
EXPOSE 5000 8080 8088 8089 8090 8091

#ENTRYPOINT ["tail", "-f", "/dev/null"]
COPY startup.sh ./startup.sh
ENTRYPOINT ["bash", "startup.sh"]

