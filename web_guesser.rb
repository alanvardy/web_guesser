require 'sinatra'
require 'sinatra/reloader'

set :port, 9393
@@secret_number = rand(100)
@@guesses_left = 5

def check_guess(guess)
  if @@guesses_left <= 0
    message = "You lose! The number was #{@@secret_number}. A new number has now been generated."
    color = 'red'
    @@guesses_left = 5
    @@secret_number
  elsif guess == 0
    message = ''
    color = '#ece2d0'
  elsif @@secret_number - guess < -5
    message = 'Way too high!'
    color = '#582c4d'
    @@guesses_left -= 1
  elsif @@secret_number - guess < 0
    message = 'Too high!'
    color = '#a26769'
    @@guesses_left -= 1
  elsif @@secret_number - guess > 5
    message = 'Way too low!'
    color = '#582c4d'
    @@guesses_left -= 1
  elsif @@secret_number - guess > 0
    message = 'Too low!'
    color = '#a26769'
    @@guesses_left -= 1
  elsif guess == @@secret_number
    message = "You got it! The number was #{@@secret_number}. A new number has now been generated."
    color = '#56cbf9'
    @@guesses_left = 5
    @@secret_number = rand(100)
  else
    message = 'Nothing'
    color = '#ece2d0'
  end
  [message, color]
end

get '/' do
  guess = params['guess'].to_i
  message, color = check_guess(guess)
  answer = params['cheat'] == 'true' ? @@secret_number : ''
  erb :index, locals: { message: message, color: color, guesses: @@guesses_left, answer: answer }
end
