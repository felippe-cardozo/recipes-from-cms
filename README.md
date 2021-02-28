# Recipes

## Architecture overview

This is a Hanami application that fetches Marley Spoon's recipes stored in Contentful's Delivery API.

While choosing the stack I was considering two main points. On one hand, I wanted to avoid unnecessary dependencies as much as possible. On the other, I wanted to avoid having to deal with too much boilerplate and be able to focus on the domain specific business code. Hanami fitted well for this, even though It's still a little bit bigger than what I wanted. 
Following the idea of avoiding dependencies, I removed the persistence and mailing layers of Hanami since, for now, they have no use for this project.

The architecture of the application is rather simple, and consists in the relationship between three components:
1. An [HTTP client](https://github.com/felippe-cardozo/recipes-from-cms/blob/master/lib/clients/contentful.rb) built on top of [Contentful' SDK](https://github.com/contentful/contentful.rb), that is responsible for integrating with their [Delivery API](https://www.contentful.com/developers/docs/references/content-delivery-api/)

1. The [Recipe](https://github.com/felippe-cardozo/recipes-from-cms/blob/master/lib/recipes/entities/recipe.rb) entity, that is an internal representation of a recipe, which is currently stored in the external service. The goal of this type of representation is to have a definition of the entity that is internal to our system, and only loosely coupled with its specific storage (currently an external service).The internal entity should change only due to domain specific reasons, while the storage can change for many reasons, including technical ones.

1. The Web application as the delivery mechanism, including routes, controllers, views, presenters, helpers and html templates. Hanami provides a nice structure to avoid coupling the domain specific abstraction with specific communication protocols and delivery strategies. Therefore, our core components will live inside the `lib` folder, and anything specific to the delivery mechanism will live inside the `apps` folder.

The application currently provides two routes:
- `GET /recipes` for listing all available recipes at the CMS (with pagination support)
- `GET /recipes/:id` for displaying a detailed view of a given recipe

## What could be improved?
- Since this challenge was meant to be more focused on the backend, my effort on the frontend was the bare minimal. It certainly could use some love.
- If this application was on production it would be nice to have some observability tools plugged in. This way we would be able to monitor the load on our endpoints, have an idea about Contentful's response time and if we need or not to consider adopting a caching strategy.

## Setup

### With docker
Make sure you have docker up and running.

start the docker container in the background (this will start the server at localhost:2300):
```
docker-compose up --build -d
``` 

Running tests:
```
docker-compose run recipes bundle exec rspec
```

Running the development console:
```
docker-compose run recipes bundle exec hanami console
```

### Local setup
make sure you have bundler installed `bundle -v`

install the dependencies by running `bundle install` while in the root of the project

How to run tests:

```
% bundle exec rspec
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```
