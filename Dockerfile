FROM ruby:2.5-alpine

RUN apk update \
    && apk add docker openrc build-base make --no-cache \
    && rc-update add docker boot \
    && service docker start || true \
    && echo "gem: --no-ri --no-rdoc" > /root/.gemrc \
    && gem install bundler \
    && mkdir /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN cd /app && bundle install
COPY . /app
WORKDIR /app
EXPOSE 9292

CMD bundle exec rackup -o 0.0.0.0 -s puma

