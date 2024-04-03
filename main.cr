require "colorize"
require "./src/fortune_teller"


def main
  system("clear") || system("cls")
  puts "Welcome to the Crystal Ball Fortune Teller".colorize(:green)
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
    puts "Would you like another fortune? (Y/N)".colorize(:yellow)
    response = gets.to_s.strip.upcase
    
    case response
    when "Y"
      next 
    when "N"
      puts "Thank you for visiting the Crystal Ball Fortune Teller. Farewell!".colorize(:green)
      break 
    else
      puts "Invalid response. Exiting...".colorize(:red)
      break 
    end
  end
end

main

