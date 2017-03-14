# About

This directory contains the magic docker-compose.yml file needed to push findahome and its requirements to Hyper.sh.

The compose file has statements that aren't recognizable by docker-compose and are purely used by the Hyper client.

The reason why there is a nested directory structure (i.e hyper/findahome/docker-compose.yml) is because docker-compose and the Hyper client use the directory name as a project name when creating containers.

# Cheatsheet

To create the stack: `hyper compose up`
To destroy the stack: `hyper compose down`

To setup the resulting database: `hyper compose run app /bin/bash -l -c "rails db:setup"`
To run migrations: `hyper compose run app /bin/bash -l -c "rails db:migrate"`
To spin up listing jobs: `hyper compose run app /bin/bash -l -c "rails search_job:enqueue"`

Note, this requires a valid Hyper.sh account and a configured Hyper client.
