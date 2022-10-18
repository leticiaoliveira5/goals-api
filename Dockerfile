FROM ruby:2.7.6

RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /app

COPY ./Gemfile /app/Gemfile

COPY ./Gemfile.lock /app/Gemfile.lock

RUN gem install rails bundler && bundle install

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
