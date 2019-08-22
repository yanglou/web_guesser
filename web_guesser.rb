require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER =rand(100)


message=""
color="white"
cheat=false
cheat_message = ""

class Count  
  @@count_guesses=6  
end


get '/' do  
  
  cheat_message = "The SECRET NUMBER is " + SECRET_NUMBER.to_s if params["cheat"] = true
  guess=params["guess"]
  check_cheat(cheat)
  message = check_guess(guess)  
  color = color_check(message, guess.to_i) 
  erb :index, :locals => {:cheat_message => cheat_message, :count_guesses => @@count_guesses, :color => color, :number => SECRET_NUMBER, :message => message}

end

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
    reinit
  end

  @@count_guesses -= 1

  if @@count_guesses<=0    
    message = "You lost. A new number has been generated."
    reinit
  end

  message
end

def color_check(message, input)
  if message.include? "Way"
    color = "red"
  elsif message.include? "right!"
    color = "green"
  elsif (input-SECRET_NUMBER).abs<5
    color = "lightpink"
  else
    color = "white"
  end
end

def reinit
  @SECRET_NUMBER = rand(100)
  @@count_guesses=5
end
