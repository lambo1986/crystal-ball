require "./src/fortune_teller"

fortunes_path = "./resources/fortunes.txt"
fortune_teller = FortuneTeller.new(fortunes_path)
puts fortune_teller.tell_fortune
