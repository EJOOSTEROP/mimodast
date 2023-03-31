from airflow.decorators import dag
from airflow.models import Variable
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago

from datetime import date, datetime, timedelta
import os

PROJECT_ROOT = os.getenv("MELTANO_PROJECT_ROOT", os.getcwd())
MELTANO_BIN = ".meltano/run/bin"
RUN_ARGS = 'tap-rest-api-gie target-duckdb'

def daterange(start_date, end_date):
    '''Helper function to create sequence of dates
    '''
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)

@dag(
    default_args={
        'owner': 'airflow',
        'depends_on_past': False,
        #'start_date': datetime(2023, 2, 28),
        'start_date': days_ago(1),
        'catchup': False,
        'email_on_failure': False,
        'email_on_retry': False,
        'retries': 1,
        'retry_delay': timedelta(minutes=2),
        #'my_date': '-'
    },
    #schedule_interval=timedelta(hours=2),
    schedule_interval='5 */1 * * *', #cron expression: https://en.wikipedia.org/wiki/Cron#CRON_expression
    tags = ['mimodast', 'tap-rest-api-gie', 'target-duckdb'],
    description="""Loads European Gas Inventory data from rest api
         into local DuckDB database. Current day if no date is specified; 
         otherwise specify "yyyy-mm-dd" in AirFlow config."""
)
def stage_gie_dag(my_date : str = '-'):
    # NOTE: my_date cannot be used as a regular Python string I believe (it is an Airflow object)
    # NOTE: f-string does not work in AirFlow/ninja template when using {{ dag_run ...}}

    run_this = BashOperator(
        task_id='Stage_from_source',
        
        # This .get is essential to be able to run without specifying any config variables in Airflow
        #bash_command = "cd /project/mimodast; ENV_DATE_GIE={{ dag_run.conf.get('my_date', '-') if dag_run else '-' }} .meltano/run/bin run tap-rest-api-gie target-duckdb",
        bash_command = "cd " + PROJECT_ROOT + "; ENV_DATE_GIE={{ dag_run.conf.get('my_date', '-') if dag_run else '-' }} " + MELTANO_BIN + " run " + RUN_ARGS,
    
        # TODO: Use env kwargs from here: https://airflow.apache.org/docs/apache-airflow/stable/howto/operator/bash.html
        # But I could not get this to work cleanly using: env={"ENV_DATE_GIE": '{{ dag_run.conf.get("my_date", "-") if dag_run else "-"}}'},
    )
    
    run_this

    run_this_2nd = BashOperator(
        task_id='Update_reporting_table',
        
        bash_command = "cd " + PROJECT_ROOT + "; ENV_DATE_GIE={{ dag_run.conf.get('my_date', '-') if dag_run else '-' }} " + MELTANO_BIN + " invoke " + "dbt-duckdb:build --select tag:gie",
    )
    
    run_this_2nd
    run_this>>run_this_2nd


@dag(
    default_args={
        'owner': 'airflow',
        'depends_on_past': False,
        #'start_date': datetime(2023, 2, 28),
        'start_date': days_ago(1),
        'catchup': False,
        'email_on_failure': False,
        'email_on_retry': False,
        'retries': 1,
        'retry_delay': timedelta(minutes=2)
    },
    #schedule_interval=timedelta(hours=1),
    schedule_interval=None,
    #schedule=None,
    tags = ['mimodast', 'tap-rest-api-gie', 'target-duckdb'],
    description='Backfills European Gas Inventory data from rest api into local DuckDB database. Desired dates need to be modified using Airflow variables (as shown in UI).'
)
def stage_gie_backfill_dag():
    start_date = datetime.strptime(Variable.get("gie_backfill_start", default_var = '2022-11-28'), "%Y-%m-%d").date()
    end_date = datetime.strptime(Variable.get("gie_backfill_end", default_var = '2022-12-01'), "%Y-%m-%d").date()
    
    # TODO: Consider whether using AirFlow variable is acceptable. It is discouraged by AirFlow: https://airflow.apache.org/docs/apache-airflow/stable/best-practices.html#top-level-python-code
    # as it takes too many database reads.
    # This links to some considerations and alternatives: https://medium.com/@jw_ng/6-ways-to-write-a-dynamic-airflow-dag-fa3aa14c2161
    #start_date = date(2022, 11, 1)
    #end_date = date(2022, 12, 1)

    daily_runs=[]
    
    run_this_2nd = BashOperator(
        task_id='Update_reporting_table',
        
        bash_command = "cd " + PROJECT_ROOT + "; " + MELTANO_BIN + " invoke " + "dbt-duckdb:build --select tag:gie",
    )
    
    run_this_2nd
    for my_date in daterange(start_date, end_date):
        #print(single_date.strftime("%Y-%m-%d"))
        my_date = my_date.strftime("%Y-%m-%d")
        run_this = BashOperator(
            task_id='Stage_from_source_'+str(my_date),
            bash_command=f'cd {PROJECT_ROOT}; ENV_DATE_GIE={my_date} {MELTANO_BIN} run {RUN_ARGS}', # this also seems to work
        )
        run_this
        daily_runs.append(run_this)
    
    daily_runs>>run_this_2nd


dag2 = stage_gie_dag()
dag3 = stage_gie_backfill_dag()