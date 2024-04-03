require "colorize"
require "./src/fortune_teller"


def main
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
      "Oh, curious one named #{name}, the universe declares: #{fortune}"
    ]

    selected_template = response_templates.sample
    puts selected_template.colorize(:light_blue)
    Process.run("say", args: [selected_template])
    puts "Would you like another fortune? (Y/N)".colorize(:yellow)
    response = gets.to_s.strip.upcase
    
    case response
    when "Y"
      next 
    when "N"
      puts "Thank you for visiting the Crystal Ball Fortune Teller. Farewell, #{name}!".colorize(:green)
      Process.run("say", args: ["Good fortune for you and goodbye!"])
      break 
    else
      puts "Invalid response. Exiting...".colorize(:red)
      break 
    end
  end
end

main

