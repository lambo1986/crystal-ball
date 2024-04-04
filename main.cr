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

def play_music(file_path : String) : Int64
  process = Process.new("afplay", [file_path])
  spawn do
    process.wait
  end
  process.pid
end

def stop_music
  Process.run("pkill", args: ["afplay"])
end

pid = play_music("./resources/music/7a.mp3")

def intro
  system("clear") || system("cls")
  stop_music
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

  play_music("./resources/music/5a.mp3")
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
  puts "Do you wish to enter the Magic Tower of Ancient Wisdom? (Y/N)".colorize(:red)
  Process.run("say", args: ["Do you wish to enter the Magic Tower of Ancient Wisdom?"])
  response = gets.to_s.strip.upcase
    
    case response
    when "Y"
      system("clear") || system("cls")
      return main
    when "N"
      stop_music
      system("clear") || system("cls")
      
      spawn do
        animate_speech(8, mouth_open, mouth_closed)
      end
      
      sleep 0.3
      Process.run("say", args: ["Fine then, forget you ever found this place and do not return until you are ready to face the future!"])
      puts "Fine then, forget you ever found this place and do not return until you are ready to face the future!".colorize(:green)
      exit 
    else
      system("clear") || system("cls")
      stop_music
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
      puts "Invalid response. Exiting the Magic Tower of Ancient Wisdom...".colorize(:red)
      Process.run("say", args: ["Good-Bye, Nice Try!"])
      exit
    end
  end

  def main
    stop_music
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
  play_music("./resources/music/7a.mp3")
  puts "
      ___
    .'   `.
   /       \\
  :         :
  :         :
   \\       /
    `.___.'
    ".colorize(:blue)
  puts "Welcome to the Crystal Ball Fortune Teller".colorize(:green)
  Process.run("say", args: ["Step inside, please! Welcome to the Crystal Ball fortune teller! Please enter your name!"])
  puts "Enter your name: "
  name = gets.to_s.strip
  sleep 0.1
  stop_music
  sleep 0.1
  play_music("./resources/music/2a.mp3")

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
    sleep 1.5 # this is adjusted to leave space after fortune is read so it can be printed after animation stops

    system("clear") || system("cls")
    puts mouth_closed
    sleep 1.5 # this makes sure the screen isn't cleared again after the fortune is printed
    puts selected_template.colorize(:light_blue)
    puts "Would you like another fortune? (Y/N)".colorize(:yellow)
    response = gets.to_s.strip.upcase
    
    case response
    when "Y"
      system("clear") || system("cls")
      next 
    when "N"
      stop_music
      system("clear") || system("cls")
      play_music("./resources/music/6a.mp3")
      puts "
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⠾⠛⠋⠉⠉⠉⠉⢙⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⢀⣼⠟⠁⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⢠⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⡟⣷⡀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⣾⢇⣤⣶⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠙⠛⠛⠁⢹⣇⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⢸⡏⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⢠⡿⠁⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⢀⣴⠟⠁⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⣠⣤⡙⠻⢿⣿⣿⣿⣿⣿⣋⣠⣤⡶⠟⢁⣤⡄⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⢿⣿⣿⣷⣤⣈⣉⠉⠛⠛⠉⣉⣠⣤⣾⣿⣿⡟⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⣾⣦⣀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⢋⣠⣴⣷⠀⠀⠀⠀
      ⠀⠀⠀⠀⢿⣿⣿⣿⣷⣶⣤⣬⣭⣉⣉⣉⣩⣭⣥⣤⣶⣾⣿⣿⣿⡿⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠛⠋⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ".colorize(:magenta)
      sleep 0.3
      Process.run("say", args: ["Good fortune for you and goodbye! Thank you for visiting the Crystal Ball Fortune Teller. Farewell, #{name}!"])
      system("clear") || system("cls")
      puts "                                                        *******
                                      ~             *---*******
                                      ~             *----*******
                              ~                   *-------*******
                              __      _   _!__     *------*******
                        _   /  \\_  _/ \\  |::| ___ **-----********   ~
                      _/ \\_/^    \\/   ^\\/|::|\\|:|  **---*****/^\\_
                    /\\/  ^ /  ^    / ^ __|::|_|:|_/\\_******/  ^  \\
                  /  \\  _/ ^ ^   /    |::|--|:|---|  \\__/  ^     ^\\___
                _/_^  \\/  ^    _/ ^   |::|::|:|-::| ^ /_  ^    ^  ^   \\_
                /   \\^ /    /\ /       |::|--|:|:--|  /  \\        ^      \\
              /     \\/    /  /        |::|::|:|:-:| / ^  \\  ^      ^     \\
        _Q   / _Q  _Q_Q  / _Q    _Q   |::|::|:|:::|/    ^ \\   _Q      ^
        /_\\)   /_\\)/_/\\\)  /_\\)  /_\\)  |::|::|:|:::|          /_\\)
      _O|/O___O|/O_OO|/O__O|/O__O|/O__________________________O|/O__________
      //////////////////////////////////////////////////////////////////////".colorize(:blue)
      puts "Thank you for visiting the Crystal Ball Fortune Teller. Farewell, #{name}!".colorize(:green)
      exit 
    else
      stop_music
      system("clear") || system("cls")
      play_music("./resources/music/3a.mp3")
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
      puts "Invalid response. Exiting the Magic Tower of Ancient Wisdom... Good Luck on your Journey".colorize(:red)
      Process.run("say", args: ["Good Luck and Good-Bye!"])
      exit 
    end
  end
end

intro
main

