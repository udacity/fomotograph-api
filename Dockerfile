FROM udacity/ruby:2.2.4
RUN bundle install --jobs 20 --retry 5 --without development test
ADD .
CMD ["fomotograph.rb"]
