#!/usr/bin/env bash

export RAILS_ENV=production

./bin/setup

export SECRET_KEY_BASE="`bundle exec rake secret`"
export RAILS_SERVE_STATIC_FILES=true

./bin/rails server
