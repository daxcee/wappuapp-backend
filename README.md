[![Build Status](https://travis-ci.com/futurice/wappuapp-backend.svg?token=yjocXfDrdDpDqbwnbBG7&branch=master)](https://travis-ci.com/futurice/wappuapp-backend)

# Wappuapp backend

Dependencies:

* Node + npm
* Postgres
* Heroku toolbelt

Get started:

* `bash ./tools/reset-database.sh`
* `cp .env-sample .env`  
* `source .env`

  Or use [autoenv](https://github.com/kennethreitz/autoenv).

* `npm install`
* `knex migrate:latest`
* `knex seed:run`
* `npm start`
* Server runs at http://localhost:9000

Start using [API endpoints](#api-endpoints).

Production environment: https://wappuapp-backend.herokuapp.com

## Techstack

* Node.js express app
* Written in ES6
* Winston for logging
* Postgres

## Heroku env

```bash
#!/bin/bash
heroku addons:create --app wappuapp-backend papertrail
heroku addons:create --app wappuapp-backend heroku-postgresql:hobby-dev
heroku addons:create --app wappuapp-backend newrelic
```

Add Postgis:

```bash
heroku pg:psql -a wappuapp-backend
create extension postgis;
```

## API Endpoints

### `GET /api/events`

> List events

Responses:

* `200 OK` List of [event objects](event-object)


### `GET /api/teams`

> List all teams

Responses:

* `200 OK` List of [team objects](team-object)


### `POST /api/actions`

> Create a new action

Body is one of [action objects](#action-objects).

Responses:

* `200 OK`

### `POST /api/users`

> Create a new user

Body is one of [user object](#user-object).

Responses:

* `200 OK`

## Response objects

### Event object

```js
{
  "id": 1,
  "name": "Wappuinfo",
  "startTime": "2016-03-09T21:24:33Z",
  "endTime": "2016-03-10T00:00:00Z",
  "description": "Beer",
  "coverImage": "http://s3/path.jpg"
}
```

### Team object

```js
{
  "id": 1,
  "name": "Tietoteekkarikilta"
}
```

### Action objects

#### Basic action object

`type` is one of `BEER`, `CIDER`.

```js
{
  location: {
    latitude: -1.2345,
    longitude: 56.2322
  },
  type: "BEER",
  team: 1,
  user: 'UUID'
}
```

#### Image action object

```js
{
  location: {
    latitude: -1.2345,
    longitude: 56.2322
  },
  type: "IMAGE",
  team: 1,
  imageData: 'base64encodedimage',
  user: 'UUID'
}
```


## Error handling

When HTTP status code is 400 or higher, response is in format:

```json
{
  "error": "Internal Server Error"
}
```
