FROM docker.udacity.com/udacity/ruby:2.5

RUN apk add make gcc musl-dev
RUN apk add ruby-webrick ruby-etc

ADD Gemfile Gemfile.lock fomotograph.json fomotograph.rb README.md /app/

RUN bundle config --local set without 'development test' \
    && bundle config --local deployment true \
    && bundle install --jobs 20 --retry 5

ENV RACK_ENV production
CMD ["bundle", "exec", "ruby", "fomotograph.rb", "-p", "4567"]
