FROM udacity/ruby
RUN bundle install --jobs 20 --retry 5 --without development test
ADD .
CMD ["fomotify.rb"]
