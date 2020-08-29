#!/usr/bin/env bash

set -e
set -x

docker build --rm . -t mantle_test
docker run --rm -v $(pwd)/data/:/data/ mantle_test
