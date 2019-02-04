# Apache Solr Docker Container Image

## Docker Images

* All images are based on Alpine Linux
* Base image: [solr](https://hub.docker.com/_/solr/)

Supported tags and respective `Dockerfile` links:

* `7.5`, `7`, `latest`
* `6.6`, `6`
* `5.5`, `5`

## Environment Variables

| Variable                  | Default Value | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `SOLR_HEAP`               | `1024m `      |                                 |
| `SOLR_DEFAULT_CONFIG_SET` |               | See [config sets](#config-sets) |

## Config sets

### Drupal Search API Solr

Apart from the default config set, this image contains predefined config sets for Drupal from [Search API Solr](https://www.drupal.org/project/search_api_solr) module. To set one of the following config sets as a default for new cores, add environment variable `$SOLR_DEFAULT_CONFIG_SET` with the value `search_api_solr_[VERSION]` with `[VERSION]` replaced to one of the listed below, e.g. `search_api_solr_8.x-2.1`.

Matrix of Search API Solr x Solr version support.

| Version  | Solr 7.x | Solr 6.x | Solr 5.x |
| -------- | -------- | -------- | -------- |
| 8.x-2.5  | ✓        | ✓        |          |
| 8.x-2.4  | ✓        | ✓        |          |
| 8.x-2.3  | ✓        | ✓        |          |
| 8.x-2.2  | ✓        | ✓        |          |
| 8.x-2.1  | ✓        | ✓        |          |
| 8.x-2.0  | ✓        | ✓        |          |
| 8.x-1.2  |          | ✓        | ✓        |
| 8.x-1.1  |          | ✓        | ✓        |
| 8.x-1.0  |          | ✓        | ✓        |
| 7.x-1.14 | ✓        | ✓        | ✓        |
| 7.x-1.13 | ✓        | ✓        | ✓        |
| 7.x-1.12 |          | ✓        | ✓        |
| 7.x-1.11 |          |          | ✓        |
| 7.x-1.10 |          |          | ✓        |
| 7.x-1.9  |          |          | ✓        |
| 7.x-1.8  |          |          | ✓        |
| 7.x-1.7  |          |          | ✓        |

### Drupal Apache Solr

Apart from the default config set, this image contains predefined config sets for Drupal from [Apache Solr](https://www.drupal.org/project/apachesolr) module. To set one of the following config sets as a default for new cores, add environment variable `$SOLR_DEFAULT_CONFIG_SET` with the value `apachesolr_[VERSION]` with `[VERSION]` replaced to one of the listed below, e.g. `apachesolr_7.x-1.11`.

Matrix of Apache Solr x Solr version support.

| Version  | Solr 7.x | Solr 6.x | Solr 5.x |
| -------- | -------- | -------- | -------- |
| 7.x-1.11 |          |          | ✓        |
| 7.x-1.10 |          |          | ✓        |

## Configuration overrides

Configuration overrides can be added to a Docksal project codebase.

Put configuration files into `.docksal/etc/solr/conf` to override the predefined configuration

