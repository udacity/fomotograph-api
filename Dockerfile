FROM ruby:3.3.0-alpine3.18

RUN apk add make gcc musl-dev
RUN apk add ruby-webrick ruby-etc

ADD Gemfile Gemfile.lock fomotograph.json fomotograph.rb README.md /app/

WORKDIR /app

RUN bundle config --local set without 'development test' \
    && bundle config --local deployment true \
    && bundle install --jobs 20 --retry 5

ENV RACK_ENV production
CMD ["bundle", "exec", "ruby", "fomotograph.rb", "-p", "4567"]
