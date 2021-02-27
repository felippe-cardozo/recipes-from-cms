# Recipes

Welcome to your new Hanami project!

## Setup

### with docker
Make sure you have docker up and running.

start the docker container in the background (this will start the server at localhost:2300):
```
docker-compose up --build -d
``` 

Running tests:
```
docker-compose run recipes bundle exec rspec
```

### local setup
make sure you have bundler installed `bundle -v`

install the dependencies by running `bundle install` while in the root of the project

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```
