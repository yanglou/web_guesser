require 'sinatra'
#require 'sinatra/reloader'

SECRET_NUMBER =rand(100)


message=""
color="white"
cheat=nil
cheat_message = ""
@@count_guesses = 5
guess=nil

get '/' do  
  
  
  guess=params["guess"]
  cheat= params["cheat"]
  
  if guess !=nil
    message = check_guess(guess)    
    color = color_check(message, guess.to_i)
  end

  if cheat == "true"
    cheat_message = "The SECRET NUMBER is " + SECRET_NUMBER.to_s
  end
  
   
  erb :index, :locals => {:cheat => cheat,:cheat_message => cheat_message, :count_guesses => @@count_guesses, :color => color, :number => SECRET_NUMBER, :message => message}

end

def check_guess(guess)
  input=guess.to_i
  if input > SECRET_NUMBER
    if (input-SECRET_NUMBER).abs>5
      message = "Way too high!"     
    else
      message = "Too high!"      
    end
  elsif input < SECRET_NUMBER
    if (SECRET_NUMBER-input).abs>5
      message = "Way too low!"      
    else
      message = "Too low!"      
    end
  elsif input = SECRET_NUMBER
    message = "You got it right! \n The SECRET NUMBER is " + SECRET_NUMBER.to_s+ ". A new number has been generated."
    reinit
    @@count_guesses +=1
  else
    message=""
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
  elsif message.include? "lost"
    color = "white"
  elsif (input-SECRET_NUMBER).abs<5
    color = "lightpink"
  else
    color = "white"
  end
end

def reinit
  @SECRET_NUMBER = rand(100)
  @@count_guesses=5
  @guess=nil
  @cheat=nil
end
