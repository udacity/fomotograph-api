require 'sinatra'
require 'json'

file = File.read('./fomotify.json')
data_hash = JSON.parse(file)

get '/example.json' do
  content_type :json
  data_hash.to_json
end