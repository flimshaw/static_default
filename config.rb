require 'sinatra'

get '/' do
  send_file "public/index.html"
end

get '/projects' do
  content_type "application/json"
  send_file "data/data.json"
end

get '/tests' do
  send_file "tests/SpecRunner.html"
end

