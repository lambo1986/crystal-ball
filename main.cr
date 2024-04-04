require "colorize"
require "./src/fortune_teller"

def animate_speech(duration, mouth_open, mouth_closed)
  frames = [mouth_open, mouth_closed]
  start_time = Time.local
  
  while Time.local < start_time + duration.seconds
    system("clear") || system("cls")
    frame = frames[Time.local.second % 2]
    puts frame
    sleep 0.5 # timing for mouth movement
  end
end

def main
  mouth_open = "
               __||__
              /      \\
             /        \\
            /   o   o  \\
           (     >Y<    )
            \\    <O>   /
             | '.___.' |
         ____|  |___|  |___
        /     \\______/     \\
       /  / \\          / \\  \\
      /  /   \\        /   \\  \\
".colorize(:red)

mouth_closed = "
               __||__
              /      \\
             /        \\
            /   o   o  \\
           (     >Y<    )
            \\    -^-   /
             | '.___.' |
         ____|  |___|  |___
        /     \\______/     \\
       /  / \\          / \\  \\
      /  /   \\        /   \\  \\
".colorize(:red)



  system("clear") || system("cls")
  puts "
      ___
    .'   `.
   /       \\
  :         :
  :         :
   \\       /
    `.___.'
  Welcome to the Crystal Ball Fortune Teller".colorize(:green)
  Process.run("say", args: ["Step inside, please! Welcome to the Crystal Ball fortune teller!"])
  puts "Enter your name: "
  name = gets.to_s.strip

  loop do
    fortune = FortuneTeller.new("./resources/fortunes.txt").tell_fortune
    response_templates = [
      "Dear #{name}, the stars whisper to me that: #{fortune}",
      "Ah, #{name}, fate has a message for you: #{fortune}",
      "#{name}, in the tea leaves, I see... #{fortune}",
      "A vision appears, #{name}: #{fortune}",
      "For you, #{name}, the crystal ball reveals: #{fortune}",
      "Oh, curious one named #{name}, the universe declares: #{fortune}",
      "Listen! #{fortune}",
      "I will now speak. #{fortune}",
      "So, #{fortune}",
      "OK. #{fortune}",
      "You ask, I show you: #{fortune}",
      "Here: #{fortune}",
      "My advice is this: #{fortune}",
      "#{name}, #{fortune}",
      "I tell you #{fortune}"
    ]

    selected_template = response_templates.sample
    speech_duration = 8 # adjust for animation duration

    spawn do # kinda like threads in ruby?
      animate_speech(speech_duration, mouth_open, mouth_closed)
    end

    puts selected_template.colorize(:light_blue)
    sleep 0.5
    Process.run("say", args: [selected_template])
    puts selected_template.colorize(:light_blue)
    sleep 1

    system("clear") || system("cls")
    puts mouth_closed
    puts selected_template.colorize(:light_blue)
    puts "Would you like another fortune? (Y/N)".colorize(:yellow)
    response = gets.to_s.strip.upcase
    
    case response
    when "Y"
      system("clear") || system("cls")
      next 
    when "N"
      spawn do
        animate_speech(speech_duration, mouth_open, mouth_closed)
      end
      
      sleep 0.3
      Process.run("say", args: ["Good fortune for you and goodbye!"])
      puts "Thank you for visiting the Crystal Ball Fortune Teller. Farewell, #{name}!".colorize(:green)
      break 
    else
      puts "
            ___
           /   \\
          |     |
          | (*) |
          \\ ^^^/
           |||||
           |||||
          / | | \\
         /  | |  \\
        |   | |   |
        |   | |   |
        /___|_|___\\
       |    | |    |
       |    | |    |
       |____|_|____|
       |    | |    |
      /     | |     \\
     /      | |      \\
      ".colorize(:red)
      puts "Invalid response. Exiting...".colorize(:red)
      Process.run("say", args: ["Good-Bye, Nice Try!"])
      break 
    end
  end
end

main

