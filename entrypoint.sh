#!/bin/bash
set -e

bundle check || bundle install

yarn install --check-files

rm -f "$APP_HOME"/tmp/pids/server.pid

bundle exec "${@}"
