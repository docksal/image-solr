#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

rm -rf configsets tmp

modules="module_name=search_api_solr;tags=8.x-2.0,8.x-1.2,8.x-1.1,8.x-1.0,7.x-1.12,7.x-1.11,7.x-1.10,7.x-1.9,7.x-1.8 "
modules+="module_name=apachesolr;tags=7.x-1.11,7.x-1.10,7.x-1.9,7.x-1.8"

for module in $modules
do
  eval $module
  for tag in $(echo $tags | sed 's#,# #g')
  do
    #echo $module_name $tag
    git clone -b $tag git@github.com:drupalprojects/${module_name}.git tmp >/dev/null 2>&1
    dirs=$(find tmp/solr-conf/ -maxdepth 1 -type d -path "*.x")
    for dir in ${dirs}
    do
      src_dir=${dir##*/}
      conf_dir="configsets/${module_name}/${tag}/conf/${src_dir##solr-}"
      mkdir -p "${conf_dir}"
      cp "${dir}"/* "${conf_dir}"
    done
    rm -rf tmp
  done
done


exit

for module_name in "search_api_solr" "apachesolr"
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

