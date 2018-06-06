FROM ruby:2.5-alpine

RUN apk update \
    && apk add docker openrc --no-cache \
    && rc-update add docker boot \
    && service docker start || true \
    && gem install bundler \
    && mkdir /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN cd /app && bundle install
COPY . /app
WORKDIR /app
EXPOSE 9292

CMD bundle exec rackup -o 0.0.0.0

