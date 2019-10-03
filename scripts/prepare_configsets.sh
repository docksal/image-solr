#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

pwd=$(pwd)
tmp=$(mktemp -d)

mv configsets/* ${tmp}
cd ${tmp}

for module in search_api_solr apachesolr
do
  dirs=$(find . -type d -path "*/${module}_*/conf/${VERSION:0:1}.x")

  for dir in ${dirs}
  do
    conf_dir="${pwd}/configsets/$(echo ${dir} | cut -d'/' -f2- | rev | cut -d'/' -f2- | rev)"
    mkdir -p ${conf_dir}
    cp -r ${dir}/* ${conf_dir}
    echo Add support $(echo ${dir} | cut -d'/' -f2)
  done
done

rm -rf ${tmp}
cd ${pwd}