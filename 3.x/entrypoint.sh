#!/bin/bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

sudo init_volumes
migrate

# Symlinks config sets to volume.
for configset in $(ls -d /opt/docker-solr/configsets/*); do
    if [[ ! -d "/opt/solr/server/solr/configsets/${configset##*/}" ]]; then
        ln -s "${configset}" /opt/solr/server/solr/configsets/;
    fi
done

if [[ ! -f /opt/solr/server/solr/solr.xml ]]; then
    ln -s /opt/docker-solr/solr.xml /opt/solr/server/solr/solr.xml
fi


# <cores adminPath="/admin/cores" defaultCoreName="8.x-1.x_apache_solr">
# <core name="8.x-1.x_apache_solr" instanceDir="configsets/8.x-1.x_apache_solr" />

sed -i 's#defaultCoreName=".*">#defaultCoreName="'${SOLR_DEFAULT_CONFIG_SET}'">#g' /opt/docker-solr/solr.xml
sed -i 's#<core name=".*" instanceDir=".*" />#<core name="'${SOLR_DEFAULT_CONFIG_SET}'" instanceDir="configsets/'${SOLR_DEFAULT_CONFIG_SET}'" />#g' /opt/docker-solr/solr.xml

if [[ "${1}" == 'make' ]]; then
    exec "$@" -f /usr/local/bin/actions.mk
else
    exec docker-entrypoint.sh "$@"
fi

