require 'sinatra'
require 'sinatra/reloader'

random_number=rand(100)

get '/' do
  "The SECRET number is #{random_number}."
end