FROM ruby:2.6.5-alpine

RUN apk add --no-cache build-base libpq && gem install bundler

WORKDIR /app
COPY . /app
RUN bundle install -j $(nproc) --quiet

EXPOSE 2300
