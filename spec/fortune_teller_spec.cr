require "./spec_helper"
require "../src/fortune_teller"

describe FortuneTeller do
  it "tells a fortune" do
    fortune_teller = FortuneTeller.new
    fortune = fortune_teller.tell_fortune
    fortunes = ["Good things are coming your way!", "Be wary of unexpected emails.", "An exciting opportunity lies ahead."]
    fortunes.should contain(fortune)
  end
end
