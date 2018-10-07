require 'sinatra'
require 'sinatra/reloader'

set :port, 9393
set :secret_number, rand(100)

def check_guess(guess)
  if guess == 0
    ''
  elsif guess < settings.secret_number
    'Too low!'
  elsif guess > settings.secret_number
    'Too high!'
  elsif guess == settings.secret_number
    "You got it! The number is #{settings.secret_number}"
  else
    'Nothing'
  end
end

get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  erb :index, locals: { message: message }
end
