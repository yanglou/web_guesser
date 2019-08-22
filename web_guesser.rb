require 'sinatra'
require 'sinatra/reloader'



SECRET_NUMBER =rand(100)
message=""

def check_guess(guess)
  input=guess.to_i
  if input > SECRET_NUMBER
    if input-SECRET_NUMBER>5
      message = "Way too high!"
    else
      message = "Too high!"
    end
   elsif input < SECRET_NUMBER
    if SECRET_NUMBER-input>5
      message = "Way too low!"
    else
      message = "Too low!"
    end
   elsif input = SECRET_NUMBER
    message = "You got it right! \n The SECRET NUMBER is " + SECRET_NUMBER.to_s
  end
  message
end

get '/' do  
  guess=params["guess"]
  message = check_guess(guess)   
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}

end