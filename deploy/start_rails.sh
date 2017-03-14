#!/bin/bash

source /home/findahome/.bash_profile
cd /home/findahome/findahome
rm -f tmp/pids/server.pid
bundle exec rails assets:precompile
bundle exec rails server --bind 0.0.0.0
