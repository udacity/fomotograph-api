FROM ruby:2.6-alpine

COPY . .

RUN bundle install

ENV APP_ENV production

CMD ["ruby", "fomotograph.rb", "-p", "4567"]
