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

