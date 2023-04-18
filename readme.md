<!-- Template from https://github.com/othneildrew/Best-README-Template/blob/master/BLANK_README.md
-->

<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
Thanks for checking out the Best-README-Template 
*** If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/EJOOSTEROP/mimodast">
    <img src="assets/hatchful/logo_transparent.png" alt="Logo" width="180" height="180">
  </a>

<h3 align="center">Mimodast</h3>

  <p align="center">
    A minimal modern data stack with working data pipelines in a single Docker container.
    <br />
    <a href="https://github.com/EJOOSTEROP/mimodast"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <!--
    <a href="https://github.com/EJOOSTEROP/mimodast">View Demo</a>
    ·
    -->
    <a href="https://github.com/EJOOSTEROP/mimodast/issues">Report Bug</a>
    ·
    <a href="https://github.com/EJOOSTEROP/mimodast/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <!--<ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>-->
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <!-- <li><a href="#acknowledgments">Acknowledgments</a></li> -->
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->
A minimal modern data stack with working data pipelines in a single Docker container. Useful for an exploration of the tools involved:

- [Meltano][Meltano-url] - ELT+ data engineering workflow tool
- [Airflow][Airflow-url] - workflow platform, including scheduling
- [dbt][dbt-url] - data transformation tool
- [DuckDB][DuckDB-url] - local SQL OLAP database managment system
- [Superset][Superset-url] - data visualization and exploration platform
- Sample data pipelines with [USGS Earthquake][USGSEarthquakeAPI-url] data and [European Gas Inventory][GIEAPI-url] levels.

Explore the functionality of the tools by using the examples as-is; and to modify and expand on the exmples for further exploration.

This is a convenient starting point for exploration. The project is not a showcase of all or even the best functionality that each tool has to offer.

<!--
Here's a blank template to get started: To avoid retyping too much info. Do a search and replace with your text editor for the following: `EJOOSTEROP`, `mimodast`, `twitter_handle`, `linkedin_username`, `email_client`, `email`, `Mimodast`, `project_description`
-->

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!--
### Built With

* [![Next][Next.js]][Next-url]
* [![React][React.js]][React-url]
* [![Vue][Vue.js]][Vue-url]
* [![Angular][Angular.io]][Angular-url]
* [![Svelte][Svelte.dev]][Svelte-url]
* [![Laravel][Laravel.com]][Laravel-url]
* [![Bootstrap][Bootstrap.com]][Bootstrap-url]
* [![JQuery][JQuery.com]][JQuery-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->


<!-- GETTING STARTED -->
## Getting Started

<!--To get a local copy up and running follow these simple example steps.
-->

### Prerequisites

Have [Docker Desktop][DockerDesktop-url] installed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Installation

In order to create the docker container you can do the following:

1. Clone this GIT repo:
   ```sh
   git clone https://github.com/EJOOSTEROP/mimodast.git
   ```
2. Invoke the following commands to create the Docker container:
    ```sh
    docker build --no-cache -t mimodast -f dockerfile . 
    ```
    ```docker 
    docker create -p5005:5000 -p8093:8088 -p8085:8080 -p8094:8089 -p8095:8090 -p8096:8091 --name mimodast mimodast
    ```
2. Optionally (required for the [European Gas Inventory][GIEAPI-url] dataset) copy a `.env` file containing the  <a href="#api-key">API key</a> as explained below:
    ```docker
    docker cp .env mimodast:/project/mimodast/.env
    ```
2. Start the container.
2. For starters:
    - Open the docker container terminal and peruse the meltano.yml file and other files/folders at `project\mimodast\`.
    - Navigate to localhost:8085 to see the Airflow orhestrator (incl scheduler) interface. Use admin/admin as username/password.
    - Navigate to localhost:8093 to see the Superset dashboard. Use admin/admin as username/password.
  - NOTE: allow for some time (~1 minute) for the container to start up all processes. On first startup wait for the completion of the  first run of the USGS pipeline before reviewing Superset.


<p align="right">(<a href="#readme-top">back to top</a>)</p>


### API key <a name="api-key"></a>

The image contains ELT pipelines for two data sets. The [USGS Earthquake][USGSEarthquakeAPI-url] dataset can be used right out of the box. This dataset is a good enough dataset to explore the core functionalities.

For the [GIE Gas Inventory][GIEAPI-url] dataset an API key is required. Create a free and immediate [GIE account][GIEAccount-url] to obtain the key.

This key needs to be available as an environment variable (ENV_GIE_XKEY) in the Docker container (it is referenced in the `meltano.yml` configuration file). One way to accomplish this is by creating a `.env` file in the `/projet/mimodast/` folder containing:
>`ENV_GIE_XKEY="YOUR-API-KEY"`

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

Two basic examples are used to illustrate an extensive date pipeline encompassing the following components:

- <a href="#obtaining-the-data-from-source">obtaining the data from source</a>
- <a href="#capturing-data-in-a-database">capturing the data in a database</a>
- <a href="#transformation">transformation</a>
- <a href="#scheduling">scheduling</a>
- <a href="#testing">testing of data</a>
- <a href="#reporting">reporting</a>
- <a href="#documentation">integrated documentation of the process</a>

The two pipelines involve [USGS Earthquake][USGSEarthquakeAPI-url] data and [European Gas Inventory][GIEAPI-url] data.

Below we highlight the core configuration for these components. For (much) more additional information refer to the respective documentation of the tools.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Definition and Configuration

The data pipelines are fully defined in a set of files. This includes the source definitions, schedules, dependencies, transformation logic, tests and documentation. (The reporting/dashboards in Superset are defined within Superset, but can be exported from there.)

These files are all found in the `/project/mimodast/` folder in the Docker container. It is best practice to capture this folder in a version control tool. Git is included in the Docker image.

Some of the core files include:

- `/project/mimodast/meltano.yml` - this contains items like the source specification, destination database and schedule.
- `/project/mimodast/orhestration/dags/gie_dag.py` - python code defining how to orchestrate a data pipeline in Airflow. Note that the GIE data uses this manually created file, whereas the USGS data orhestration relies purely on logic defined in `meltano.yml`.
- `/project/mimodast/tranformation/` - this folder contains transformation logic (under `models/`) and also tests and documentation.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### USGS Earthquake Data Pipeline

#### Obtaining the data from source

The `meltano.yml` file specifies how to obtain the data from source. Specifically, configuring the connection to the data source is centered around this `tap` section in `meltano.yml` (To be found at `/project/mimodast/meltano.yml` in the Docker container.):

```yaml
  - name: stg_usgs
    inherit_from: tap-rest-api-msdk
    config:
      api_url: https://earthquake.usgs.gov/fdsnws
```

In the example, this tap is inherited from a publicly available tap for a REST API:

```yaml
plugins:
  extractors:
  - name: tap-rest-api-msdk
    variant: widen
    pip_url: tap-rest-api-msdk
 ```

`pip_url` specifies the location of the source code for the tap plug-in. In this case the actual location is derived by Meltano based on the tap name. Note that the tap for the other data pipeline (Gas Inventory data) also inherits from the same tap, but is clearly configured differently.

`meltano.yml` contains the ful configuration of the tap. For example the following element specifies to select only earthquakes with a minimum magnitute:

```yaml
          minmagnitude: 6
```

Many more items are configured for this tap.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Capturing data in a database

The following section in `meltano.yml` configures the database where the data will be stored:

```yaml
  - name: target-duckdb
    pip_url: target-duckdb~=0.4
    config:
      add_metadata_columns: true
      default_target_schema: main
      filepath: $DB_LOCATION
      data_flattening_max_level: 10
```

A [duckdb][DuckDB-url] database is used in this example. This database contains the data captured from source and is accessed for reporting. The database file is located at `/project/data/dev/data.duckdb`. This database location is specified in `meltano.yml`.

The image contains the DuckDB command line interface. Use the command:

```sh
/project/duckdb_cli/duckdb /project/data/dev/data.duckdb
```

to start the CLI and browse the database using SQL (the CLI has a help function and is documented online).

Note that the database maybe unavailable if another process (pipeline, reporting) is already accessing it, resulting in an error message.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Transformation

Transformation is performed by [dbt][dbt-url] and specified by a set of `SQL` files. In the container these are located at: `/project/mimodast/transform/models/usgs_rpt/`.

For this example pipeline the transformation is fully captured in `rpt_usgs_events.sql`. In this case the 'transformation' simply copies some source attributes into a reporting table.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Scheduling

The following section of `meltano.yml` configures the pipeline's run schedule:

```yaml
schedules:
- name: USGS-Earthquake
  interval: 35 */1 * * *
  job: usgs-to-duckdb-rpt
  start_date: 2023-01-01 15:40:21.295936
```

The scheduling `interval` uses the [Cron job][Cron-url] format. In this case the pipeline is schedulted to run 35 minutes after every hour.

This section refers to a `job`, wich is configured in the same file. This job consists of a `tap` to obtain data from source, a loader specifying where the data needs to be stored and a transformation component:

```yaml
jobs:
- name: usgs-to-duckdb-rpt
  tasks:
  - stg_usgs target-duckdb-usgs dbt-duckdb:usgs
```

In this docker container [Airflow][Airflow-url] is used as the scheduler/orchestrator. Meltano ensures that the specified schedule is set in Airflow. Note that the schedule can also be set directly in Airflow, as is the case for our [GIE Gas Inventory][GIEAPI-url] pipeline.

To monitor job progress access the Airflow UI from `localhost:8085`, with `admin/admin` as user/password. There are three pipelines: one for USGS and two for GIE.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Testing

Data tests are specified in two locations:

- SQL files in the `/project/mimodast/transform/models/tests/` folder. (In this specific case just a basic test that the magnitude of an earthquake is not unrealistically high.) Tests are performed by dbt.
- yml files in the `/project/mimodast/transform/models/usgs_rpt/` folder. For example the following tests that the `id` field is not null:

```yaml
      - name: id
        description: Unique ID of earthquake or related event assigned by USGS.
        tests:
          - not_null
```

Tests can be initiated manually from the command line in the Docker container:
```sh
cd /project/mimodast/
meltano invoke dbt-duckdb:test
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Reporting

[Superset][Superset-url] is used to visualize/dashboard the data. The Superset UI can be accessed from `localhost:8093`, with `admin/admin` as user/password.

Initially the database in mimodast is empty so make sure to run the datapipeline(s) before reviewing the dashboards.

Due to an outstanding issue in mimodast, individual charts in a dashboard frequently do not show. For now:

- Refresh each chart by selecting this option in the right top corner of each chart.
- Possibly wait for other processes accessing the database (say the data pipelines) to complete

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Documentation

dbt is used for documentation of data and processes. Documentation is maitained in .yml files and `overview.md` in the `/project/mimodast/transform/models/` folder.

This documentation can be consulted at `localhost:8094`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Gas Inventory Pipeline

The [Gas][GIEAPI-url] pipeline is setup in a similar way as the USGS earthquake pipeline.

The following differences are noteworthy:

1. The pipeline requires an account to be setup. This is free, quick and avaiable to everyone. Refer <a href="#api-key">here</a> for instructions.
    - Note that for this reasong the jobs/DAGs for this pipeline are initially paused in Airflow. Once the API key is obtained an setup in the docker container use the Airflow UI to unpause the jobs.
2. The `meltano.yml` file is configured to obtain this key from an environment variable as follows:

```yaml
      headers:
        x-key: $ENV_GIE_XKEY
```

3. Schedule/orhestration is not configured using `meltano.yml` but instead with two manually coded Airflow DAGs. The Python file containing the code for these can be found at `/project/mimodast/orchestrate/dags/gie_dag.py`.
    - The backfill dag captures historic data from source. To specify the date range, two Airflow variables are used. These values can be changed using the Airflow UI.
    - It takes some time (<1 minute) for the new date range to be reflected in the DAG.
    - Note that using Airflow variables in a DAG in this way is not a [best practice][AirflowBestPractices-url] design but is used for simplicity.
4. Meltano's inline data mapping functionality is used to create hashed ID fields when obtaining data from source using the following configuration in `meltano.yml`:

```yaml
      stream_maps:
        stg_gie_storage:
          key_hash: md5(config['hash_seed'] + (gasDayStart + code))
```
5. Additional test types are included. As for example (from `rpt_gie_storage.yml`):
```yaml
    tests:
      - dbt_utils.unique_combination_of_columns:
          combination_of_columns:
            - sso_eic
            - gasdaystart 
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
## Roadmap

- [ ] Include [Great Expectations][GreatExpectations-url] for data quality purposes.
- [ ] Add a dbt model using [PRQL][PRQL-url] language instead of SQL.
- [ ] Add a metadata framework like Amundsen, OpenLineage or similar.

<!--
- [ ] Feature 3
    - [ ] Nested Feature
-->

See the [open issues](https://github.com/EJOOSTEROP/mimodast/issues) for a full list of proposed features (and known issues).

Observed issues:
[ ] Clashing DuckDB database access when viewing data in Superset while ELT pipeline is running (or vice versa). Workaround: wait for ELT to complete. This should be a fixable issue (though I don't know how at the moment.)
[ ] Superset dashboard cannot currently refresh all elements in a dashboard at once (an error shows for the unsuccessful grahps). Workaround: manually refresh each graph using Superset UI. This should be fixable in the same way as the prior issue.
[ ] Logging into Superset and Airflow simutaneously seems to encounter problems. Workaround: close the browser tab with the 'other' app, open a new clean tab to log into the desired app.



<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

<!-- Contributions are what make the open source community such an amazing place to learn, inspire, and create. -->
Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. <!-- See `LICENSE.txt` for more information.--> The tools and the sample data are subject to their own respective licenses.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

<!--
Your Name - [@twitter_handle](https://twitter.com/twitter_handle) - email@email_client.com
-->

Project Link: [https://github.com/EJOOSTEROP/mimodast](https://github.com/EJOOSTEROP/mimodast)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
<!--
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>

-->


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/EJOOSTEROP/mimodast.svg?style=for-the-badge
[contributors-url]: https://github.com/EJOOSTEROP/mimodast/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/EJOOSTEROP/mimodast.svg?style=for-the-badge
[forks-url]: https://github.com/EJOOSTEROP/mimodast/network/members
[stars-shield]: https://img.shields.io/github/stars/EJOOSTEROP/mimodast.svg?style=for-the-badge
[stars-url]: https://github.com/EJOOSTEROP/mimodast/stargazers
[issues-shield]: https://img.shields.io/github/issues/EJOOSTEROP/mimodast.svg?style=for-the-badge
[issues-url]: https://github.com/EJOOSTEROP/mimodast/issues
[license-shield]: https://img.shields.io/github/license/EJOOSTEROP/mimodast.svg?style=for-the-badge
[license-url]: https://github.com/EJOOSTEROP/mimodast/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/erik-oosterop-9505a21
[product-screenshot]: assets/hatchful/logo_transparent.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 

[Airflow-url]: https://airflow.apache.org
[AirflowBestPractices-url]: https://airflow.apache.org/docs/apache-airflow/stable/best-practices.html#top-level-python-code
[dbt-url]: https://www.getdbt.com
[DuckDB-url]: https://duckdb.org
[Meltano-url]: https://meltano.com
[Superset-url]: https://superset.apache.org
[GreatExpectations-url]: https://greatexpectations.io/
[PRQL-url]: https://prql-lang.org/

[Cron-url]: https://en.wikipedia.org/wiki/Cron
[DockerDesktop-url]: https://www.docker.com/products/docker-desktop/
[USGSEarthquakeAPI-url]: https://earthquake.usgs.gov/fdsnws/event/1/
[GIEAPI-url]: https://agsi.gie.eu/
[GIEAccount-url]: https://agsi.gie.eu/account