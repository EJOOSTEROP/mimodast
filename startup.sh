#!/bin/bash

#In VS Code on Win needs LF as linebreaks

meltano invoke airflow scheduler &
meltano invoke airflow webserver &
#wait
meltano invoke superset:ui &
meltano ui &

meltano invoke dbt-duckdb:docs-generate
meltano invoke dbt-duckdb:docs-serve --port 8089

# To prevent the container from exiting immediately.
#tail -f /dev/null