#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

rm -rf configsets

for module_name in "search_api_solr" "apache_solr"
do
  for drupal in "8.x" "7.x"
  do
    versions=$(find ../configsets/${module_name}/ -maxdepth 1 -path *${drupal}*|rev|cut -d'/' -f1|rev)
    for version in ${versions}
    do
      dir="../configsets/${module_name}/${version}/conf/${SOLR_VER:0:1}.x"
      if [[ -d "${dir}" ]]
      then
        echo "${module_name} ${version}: adding config set for ${SOLR_VER:0:1}.x"

        conf_dir="configsets/${version}_${module_name}/conf"
        mkdir -p "${conf_dir}"
        cp "${dir}"/* "${conf_dir}"
      else
        echo "${module_name} ${version}: does not support Solr ${SOLR_VER:0:1}.x"
      fi
    done
  done
done

