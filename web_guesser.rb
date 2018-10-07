require 'sinatra'
require 'sinatra/reloader'

set :port, 9393
set :secret_number, rand(100)

def check_guess(guess)
  if guess == 0
    message = ''
    color = 'white'
  elsif settings.secret_number - guess < -5
    message = 'Way too high!'
    color = 'red'
  elsif settings.secret_number - guess < 0
    message = 'Too high!'
    color = '#a26769'
  elsif settings.secret_number - guess > 5
    message = 'Way too low!'
    color = 'red'
  elsif settings.secret_number - guess > 0
    message = 'Too low!'
    color = '#a26769'
  elsif guess == settings.secret_number
    message = "You got it! The number is #{settings.secret_number}"
    color = 'green'
  else
    message = 'Nothing'
    color = 'white'
  end
  [message, color]
end

get '/' do
  guess = params['guess'].to_i
  message, color = check_guess(guess)
  erb :index, locals: { message: message, color: color }
end
