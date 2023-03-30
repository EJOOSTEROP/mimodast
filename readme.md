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

Mimodast can be used to explore the functionality of the tools by using the examples as-is; and to modify and expand on the exmples for further exploration.

It is a starting point for exploration. The project is not a showcase of all or even the best functionality that each tool has to offer. The tools have more functionality than is accounted for in Mimodast.

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
2. Invoke the following commands to build the Docker container:
    ```docker
    docker build --no-cache -t mimodast -f dockerfile . 
    ```
    ```docker 
    docker create -p5005:5000 -p8093:8088 -p8085:8080 -p8094:8089 -p8095:8090 -p8096:8091 --name mimodast mimodast
    ```
2. Optionally copy a `.env` file containing the  <a href="#api-key">API key</a> as explained below:
    ```docker
    docker cp .env mimodast:/project/mimodast/.env
    ```
3. Start the container.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### API key <a name="api-key"></a>

The image contains ELT pipelines for two data sets. The [USGS Earthquake][USGSEarthquakeAPI-url] dataset can be used right out of the box. 

For the [GIE Gas Inventory][GIEAPI-url] dataset an API key is required. Create a free [GIE account][GIEAccount-url] to obtain the key. 

This key needs to be available as an environment variable (ENV_GIE_XKEY) in the Docker container (it is referenced in the `meltano.yml` configuration file). One way to accomplish this is by creating a `.env` file in the `/projet/mimodast/` folder containing:
>`ENV_GIE_XKEY="YOUR-API-KEY"`


<!--
1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/EJOOSTEROP/mimodast.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```
-->
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

The pipelines include the injection of data from source into a database, transformation, data testing, documentation and reporting. Various tools are leveraged.

This section highlights some of the key items for the tools being used. For full documentation refer to the respective websites of each tool.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Meltano

Meltano's functionality is largely driven by the meltano.yml file. It is used to install most of the other tools contained in the image, to define the ELT pipeline and to schedule the [USGS Earthquake][USGSEarthquakeAPI-url] pipeline. The file can be found at: `/project/mimodast/meltano.yml`.

This file can for example be edited to change the period or minimum earthquake magnitude selected when getting data from USGS. Search the file for `name: stg_usgs` and review the fews lines following, especially the settings for `starttime` and `minmagnitude`.

Meltano can be used to invoke many of the tools. For example the following command preforms the tests defined in dbt: `meltano invoke dbt-duckdb:test`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Airflow

Airflow is used to trigger the ELT pipelines based on a schedule. The Airflow UI can be access from `localhost:8085`, with `admin/admin` as user/password. There are three pipelines: one for USGS and two for GIE.

The USGS pipeline and schedule are fully managed by meltano.yml. Note that one may need to wait (up to a minute) for changes in meltano.yml to be recognized by Airflow.

The GIE pipeline and schedule are defined as DAGs in a python file located at `/project/mimodast/orchestrate/dags/gie_dag.py`. The GIE pipelines are initially paused as they will not function without the <a href="#api-key">API key</a> referenced above. Once the API key has been provided the GIE pipelines can be activated using the Airflow UI.

The GIE backfill pipeline uses Airflow variables to select the period for which to capture historic data. These variables can be changed using the Airflow UI. Again one may need to wait (up to a minute) for any changes to be recognized by Airflow. Note that this is not a [best practice][AirflowBestPractices-url] design but is used for simplicity.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Superset

Superset is used to visualize/dashboard the data. The Superset UI can be accessed from `localhost:8093`, with `admin/admin` as user/password. Two dashboards exist.

At the start the database in mimodast is empty so make sure to run the datapipeline(s) before reviewing the dashboards.

Due to an incorrect setup in mimodast individual charts in a dashboard frequently do not show. For now:

- Refresh each chart by selecting this option in the right top corner of each chart. 
- Possibly wait for other processes accessing the database (say the data pipelines) to complete.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### DuckDB

The data for the pipelines is captured in a DuckDB database. The database is located at `/project/data/dev/data.duckdb`. 

The image contains the DuckDB command line interface which can be used to query the database. The command `/project/duckdb_cli/duckdb /project/data/dev/data.duckdb` will start the CLI and open the database (the CLI has a help function and is documented online).

Note that the database maybe unavailable if another process (pipeline, reporting) is already accessing it.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### dbt
dbt defines data transformations. Mimodast contains transformations from staged data to data used for reporting. dbt is configured by using the files in `/project/mimodast/transformers/`.

New transformations can be triggered by running the pipelines in Airflow; or manually triggered using `meltano invoke dbt-duckdb:run` from within the `/project/mimodast/` folder.

Data tests and documentation have also been setup in mimodast.

The documentation can be viewed at `localhost:8094`. The tests can be triggered by invoking `meltano invoked dbt-duckdb:test` from within the `/project/mimodast/` folder.



<p align="right">(<a href="#readme-top">back to top</a>)</p>





<!-- ROADMAP -->
## Roadmap

- [ ] Include [Great Expectations][GreatExpectations-url] for data quality purposes.
- [ ] Add a dbt model using [PRQL][PRQL-url] language instead of SQL.

<!--
- [ ] Feature 3
    - [ ] Nested Feature
-->

See the [open issues](https://github.com/EJOOSTEROP/mimodast/issues) for a full list of proposed features (and known issues).




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

[DockerDesktop-url]: https://www.docker.com/products/docker-desktop/
[USGSEarthquakeAPI-url]: https://earthquake.usgs.gov/fdsnws/event/1/
[GIEAPI-url]: https://agsi.gie.eu/
[GIEAccount-url]: https://agsi.gie.eu/account