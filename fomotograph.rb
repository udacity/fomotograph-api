require 'sinatra'
require 'json'

file = File.read('./fomotograph.json')
data_hash = JSON.parse(file)

get '/products.json' do
  content_type :json
  data_hash.to_json
end
