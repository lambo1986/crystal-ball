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
            /   -   -  \\
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
      "I'll tell you what: #{fortune}",
      "Listen to what I say! #{fortune}",
      "For your information, #{fortune}",
      "#{fortune}",
      "#{fortune} Did you get that?",
      "#{fortune} Does that make sense?!",
      "#{fortune} Ok?",
      "#{fortune} Can you believe it?",
      "#{fortune} Who can deny it!?"
    ]

    selected_template = response_templates.sample
    speech_duration = 7.7 # adjust for animation duration
    puts selected_template.colorize(:light_blue)# just in case the fortune is short and the animation overrides the printing below

    spawn do # kinda like threads in ruby? can run side by side another operation
      animate_speech(speech_duration, mouth_open, mouth_closed)
    end

    Process.run("say", args: [selected_template])
    sleep 1 # this is adjusted to leave space after fortune is read so it can be printed after animation stops

    system("clear") || system("cls")
    puts mouth_closed
    sleep 2 # this makes sure the screen isn't cleared again after the fortune is printed
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

