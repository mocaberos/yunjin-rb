#!/usr/bin/env bash
#
# CIテストを実行する
# ruby 3.1.0
#
set -eu;

docker build -t mocaberos:mzk -f Dockerfile.3.1.0 .;
docker run /app/bin/test.sh
