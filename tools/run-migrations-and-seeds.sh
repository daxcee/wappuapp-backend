#!/bin/bash
# NOTE: Run this only from project root!

if [[ $NODE_ENV == 'production' ]]
then
    echo -e '\n -- Running migrations\n'
    npm install -g knex
    DEBUG=knex knex migrate:latest
    echo -e '\n -- End of migrations\n'

    echo -e '\n -- Running seeds\n'
    VERBOSE_SEEDS=true DEBUG=knex knex seed:run
    echo -e '\n -- End of seeds\n'
else
    echo 'Skip migrations. NODE_ENV != production'
fi
