#!/bin/bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

sudo init_volumes

# Symlinks config set to volume.
ln -s /opt/docker-solr/configsets/"${SOLR_DEFAULT_CONFIG_SET}" "${SOLR_HOME}"/configsets/default;

if [[ ! -f /opt/solr/server/solr/solr.xml ]]; then
    ln -s /opt/docker-solr/solr.xml /opt/solr/server/solr/solr.xml
fi

# use user own configs if exists
if [[ -d /var/www/.docksal/etc/solr/conf ]]; then
    rm -rf "${SOLR_HOME}"/configsets/default
    mkdir -p /opt/docker-solr/configsets/default
    cp -R /var/www/.docksal/etc/solr/conf /opt/docker-solr/configsets/default/
    ln -s /opt/docker-solr/configsets/default "${SOLR_HOME}"/configsets/default
fi

# set default core
touch "${SOLR_HOME}"/configsets/default/core.properties

sudo sed -i 's@^SOLR_HEAP=".*"@'"SOLR_HEAP=${SOLR_HEAP}"'@' /opt/solr/bin/solr.in.sh

exec "$@"


