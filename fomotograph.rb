require 'sinatra'
require 'json'

file = File.read('./fomotograph.json')
data_hash = JSON.parse(file)

get '/products.json' do
  content_type :json
  data_hash.to_json
end


data = JSON.parse('{"serviceName": "fomotograph-api","personalData": false}')

get '/erasurez' do
  content_type :json
  data.to_json
end