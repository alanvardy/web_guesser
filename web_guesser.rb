require 'sinatra'
require 'sinatra/reloader'

set :port, 9393

random_number = rand(100)

get '/' do
  "The secret number is #{random_number}"
end
