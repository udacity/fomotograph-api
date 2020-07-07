FROM docker.udacity.com/udacity/ruby:2.5
RUN apk-install make gcc musl-dev
RUN bundle config set without 'development test' \
    && bundle install --jobs 20 --retry 5
ADD . /app
ENV RACK_ENV production
CMD ["ruby", "fomotograph.rb", "-p", "4567"]
