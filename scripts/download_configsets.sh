#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

drupal_projects=$(curl -s https://ftp.drupal.org/files/projects/ | cut -d'"' -f2)

rm -rf configsets

for module in search_api_solr apachesolr
do
  files=$(echo "${drupal_projects}" | grep -E "^${module}-(7.x|8.x).*.tar.gz" | grep -vE "(-beta|-dev|-alpha|-rc|-unstable)")

  for file in ${files}
  do
    tmp=$(mktemp -d)
    drupal_version=$(echo ${file} | cut -d'-' -f2)
    module_version=$(echo ${file} | cut -d'-' -f3 | sed 's/.tar.gz//g')

    curl -s https://ftp.drupal.org/files/projects/${file} | tar xz -C ${tmp}
    dirs=$(find ${tmp}/${module}/solr-conf/ -type d -path "*${VERSION:0:1}.x")
    for dir in ${dirs}
    do
      src_dir=${dir##*/}
      conf_dir="configsets/${module}_${drupal_version}-${module_version}/conf"
      mkdir -p "${conf_dir}"
      cp "${dir}"/* "${conf_dir}"
      echo Add support ${module}_${drupal_version}-${module_version}
    done
    rm -rf ${tmp}
  done
done
