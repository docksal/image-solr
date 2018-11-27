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
sed -i 's#defaultCoreName=".*">#defaultCoreName="default">#g' /opt/docker-solr/solr.xml
sed -i 's#<core name=".*" instanceDir=".*" />#<core name="default" instanceDir="configsets/default" />#g' /opt/docker-solr/solr.xml

exec "$@"
