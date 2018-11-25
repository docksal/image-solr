#!/bin/bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

sudo init_volumes
migrate

# Symlinks config set to volume.
ln -s /opt/docker-solr/configsets/"${SOLR_DEFAULT_CONFIG_SET}" "${SOLR_HOME}"/configsets/default;

if [[ ! -f /opt/solr/server/solr/solr.xml ]]; then
    ln -s /opt/docker-solr/solr.xml /opt/solr/server/solr/solr.xml
fi

# use user own configs if exists
if [[ -d /var/www/.docksal/etc/solr ]]; then
    rm -f "${SOLR_HOME}"/configsets/default
    ln -s /var/www/.docksal/etc/solr "${SOLR_HOME}"/configsets/default
fi

touch "${SOLR_HOME}"/configsets/default/conf/core.properties

sudo sed -i 's@^SOLR_HEAP=".*"@'"SOLR_HEAP=${SOLR_HEAP}"'@' /opt/solr/bin/solr.in.sh

if [[ "${1}" == 'make' ]]; then
    exec "$@" -f /usr/local/bin/actions.mk
else
    exec docker-entrypoint.sh "$@"
fi

