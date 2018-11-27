#!/usr/bin/env sh

[[ "$(netstat -an | grep LISTEN | grep -E '0.0.0.0:8983.*LISTEN')" == "" ]] && exit 1

exit 0
