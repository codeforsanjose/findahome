#!/bin/bash

source /home/findahome/.bash_profile
cd /home/findahome/findahome
bundle exec sidekiq -C config/sidekiq.yml
