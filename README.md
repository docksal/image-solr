# Apache Solr Docker Container Image

## Docker Images

* All images are based on Alpine Linux
* Base image: [openjdk](https://hub.docker.com/r/_/openjdk/)

Supported tags and respective `Dockerfile` links:

* `7.5`, `7`, `latest` [_(Dockerfile)_](https://github.com/sergey-zabolotny/service-solr/blob/master/7.x/Dockerfile)
* `6.6`, `6` [_(Dockerfile)_](https://github.com/sergey-zabolotny/service-solr/blob/master/6.x/Dockerfile)
* `5.5`, `5` [_(Dockerfile)_](https://github.com/sergey-zabolotny/service-solr/blob/master/5.x/Dockerfile)
* `4.4`, `4` [_(Dockerfile)_](https://github.com/sergey-zabolotny/service-solr/blob/master/4.x/Dockerfile)
* `3.6`, `3` [_(Dockerfile)_](https://github.com/sergey-zabolotny/service-solr/blob/master/3.x/Dockerfile)

## Environment Variables

| Variable                  | Default Value | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `SOLR_HEAP`               | `1024m `      |                                 |
| `SOLR_DEFAULT_CONFIG_SET` |               | See [config sets](#config-sets) |

## Config sets

### Drupal Search API Solr

Apart from the default config set, this image contains predefined config sets for Drupal from [Search API Solr](https://www.drupal.org/project/search_api_solr) module. To set one of the following config sets as a default for new cores, add environment variable `$SOLR_DEFAULT_CONFIG_SET` with the value `search_api_solr_[VERSION]` with `[VERSION]` replaced to one of the listed below, e.g. `search_api_solr_8.x-2.1`.

Matrix of Search API Solr x Solr version support.

| Version  | Solr 7.x | Solr 6.x | Solr 5.x | Solr 4.x | Solr 3.x |
| -------- | -------- | -------- | -------- | -------- | -------- |
| 8.x-2.0  | ✓        | ✓        |          |          |          |
| 8.x-1.2  |          | ✓        | ✓        | ✓        |          |
| 8.x-1.1  |          | ✓        | ✓        | ✓        |          |
| 8.x-1.0  |          | ✓        | ✓        | ✓        |          |
| 7.x-1.12 |          | ✓        | ✓        | ✓        | ✓        |
| 7.x-1.11 |          |          | ✓        | ✓        | ✓        |
| 7.x-1.10 |          |          | ✓        | ✓        | ✓        |
| 7.x-1.9  |          |          | ✓        | ✓        | ✓        |
| 7.x-1.8  |          |          | ✓        | ✓        | ✓        |

### Drupal Apache Solr

Apart from the default config set, this image contains predefined config sets for Drupal from [Apache Solr](https://www.drupal.org/project/apachesolr) module. To set one of the following config sets as a default for new cores, add environment variable `$SOLR_DEFAULT_CONFIG_SET` with the value `apachesolr_[VERSION]` with `[VERSION]` replaced to one of the listed below, e.g. `apachesolr_7.x-1.11`.

Matrix of Apache Solr x Solr version support.

| Version  | Solr 7.x | Solr 6.x | Solr 5.x | Solr 4.x | Solr 3.x |
| -------- | -------- | -------- | -------- | -------- | -------- |
| 7.x-1.11 |          |          | ✓        | ✓        | ✓        |
| 7.x-1.10 |          |          | ✓        | ✓        | ✓        |
| 7.x-1.9  |          |          | ✓        | ✓        | ✓        |
| 7.x-1.8  |          |          |          | ✓        | ✓        |

