require 'sinatra'
require 'sinatra/reloader'



SECRET_NUMBER =rand(100)
message=""
color="white"

def check_guess(guess)
  input=guess.to_i
  if input > SECRET_NUMBER
    if input-SECRET_NUMBER>5
      message = "Way too high!"
      color = "red"
    else
      message = "Too high!"
      color = "#ffe6e6"
    end
   elsif input < SECRET_NUMBER
    if SECRET_NUMBER-input>5
      message = "Way too low!"
      color = "red"
    else
      message = "Too low!"
      color = "#ffe6e6"
    end
   elsif input = SECRET_NUMBER
    message = "You got it right! \n The SECRET NUMBER is " + SECRET_NUMBER.to_s
  end
  message
end

def color_check(message)
  if message.include? "Way"
    color = "red"
  elsif message.include? "right!"
    color = "green"
  else 
    color = "lightpink"
  end
end

get '/' do  
  guess=params["guess"]
  message = check_guess(guess)  
  color = color_check(message) 
  erb :index, :locals => {:color => color, :number => SECRET_NUMBER, :message => message}

end