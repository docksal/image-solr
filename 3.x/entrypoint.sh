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

sed -i 's#defaultCoreName=".*">#defaultCoreName="default">#g' /opt/docker-solr/solr.xml
sed -i 's#<core name=".*" instanceDir=".*" />#<core name="default" instanceDir="configsets/default" />#g' /opt/docker-solr/solr.xml

if [[ "${1}" == 'make' ]]; then
    exec "$@" -f /usr/local/bin/actions.mk
else
    exec docker-entrypoint.sh "$@"
fi

