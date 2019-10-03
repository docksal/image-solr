# Apache Solr Docker images for Docksal

These images are based on the official Apache Solr images from Docker Hub (alpine base).

This image(s) is part of the [Docksal](http://docksal.io) image library.


## Versions

- `docksal/solr:5.5`,
- `docksal/solr:6.6`,
- `docksal/solr:7.5`,
- `docksal/solr:7.7`,
- `docksal/solr:8.1`, `docksal/solr:latest`

For a complete list of available images tags check the image page on [Docker Hub](https://cloud.docker.com/u/docksal/repository/docker/docksal/solr).

Tag scheme: `docksal/solr:<solr-version>[-<image-stability-tag>]`


## Environment variables

| Variable                  | Default Value | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `SOLR_HEAP`               | `1024m `      |                                 |
| `SOLR_DEFAULT_CONFIG_SET` |               | See [config sets](#config-sets) |


## Config sets

### Drupal Search API Solr

Apart from the default config set, this image contains predefined config sets for Drupal from 
[Search API Solr](https://www.drupal.org/project/search_api_solr) module. To set one of the following config sets 
as a default for new cores, add environment variable `$SOLR_DEFAULT_CONFIG_SET` with the value `search_api_solr_[VERSION]` 
with `[VERSION]` replaced to one of the listed below, e.g. `search_api_solr_8.x-2.1`.

Matrix of Search API Solr x Solr version support.

| Version  | Solr 8.x | Solr 7.x | Solr 6.x | Solr 5.x |
| -------- | -------- | -------- | -------- | -------- |
| 8.x-3.0  | ✓        | ✓        | ✓        |          |
| 8.x-2.7  |          | ✓        | ✓        |          |
| 8.x-2.6  |          | ✓        | ✓        |          |
| 8.x-2.5  |          | ✓        | ✓        |          |
| 8.x-2.4  |          | ✓        | ✓        |          |
| 8.x-2.3  |          | ✓        | ✓        |          |
| 8.x-2.2  |          | ✓        | ✓        |          |
| 8.x-2.1  |          | ✓        | ✓        |          |
| 8.x-2.0  |          | ✓        | ✓        |          |
| 8.x-1.2  |          |          | ✓        | ✓        |
| 8.x-1.1  |          |          | ✓        | ✓        |
| 8.x-1.0  |          |          | ✓        | ✓        |
| 7.x-1.14 |          | ✓        | ✓        | ✓        |
| 7.x-1.13 |          | ✓        | ✓        | ✓        |
| 7.x-1.12 |          |          | ✓        | ✓        |
| 7.x-1.11 |          |          |          | ✓        |
| 7.x-1.10 |          |          |          | ✓        |
| 7.x-1.9  |          |          |          | ✓        |
| 7.x-1.8  |          |          |          | ✓        |
| 7.x-1.7  |          |          |          | ✓        |

### Drupal Apache Solr

Apart from the default config set, this image contains predefined config sets for Drupal from 
[Apache Solr](https://www.drupal.org/project/apachesolr) module. To set one of the following config sets as a default 
for new cores, add environment variable `$SOLR_DEFAULT_CONFIG_SET` with the value `apachesolr_[VERSION]` 
with `[VERSION]` replaced to one of the listed below, e.g. `apachesolr_7.x-1.11`.

Matrix of Apache Solr x Solr version support.

| Version  | Solr 8.x | Solr 7.x | Solr 6.x | Solr 5.x |
| -------- | -------- | -------- | -------- |--------- |
| 7.x-1.11 |          |          |          | ✓        |
| 7.x-1.10 |          |          |          | ✓        |


## Configuration overrides

Configuration overrides can be added to a Docksal project codebase.

Put configuration files into `.docksal/etc/solr/conf` to override the predefined configuration.

## Credits

This image was inspired by https://github.com/wodby/solr
