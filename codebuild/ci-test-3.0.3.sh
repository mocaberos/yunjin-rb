#!/usr/bin/env bash
#
# CIテストを実行する
# ruby 3.0.3
#
set -eu;

docker build -t mocaberos:mzk -f Dockerfile.3.0.3 .;
docker run -e CODECOV_TOKEN="${CODECOV_TOKEN}" /app/bin/test.sh
