require "./spec_helper"
require "../src/fortune_teller"

describe FortuneTeller do
  it "exists" do 
    fortunes_path = "spec/fixtures/test_fortunes.txt"
    fortune_teller = FortuneTeller.new(fortunes_path)

    fortune_teller.should be_a FortuneTeller
  end

  it "loads fortunes from a file" do
    fortunes_path = "spec/fixtures/test_fortunes.txt"
    fortune_teller = FortuneTeller.new(fortunes_path)
    fortunes = fortune_teller.fortunes 

    fortunes.should_not be_nil
    fortunes.size.should eq 3
    fortunes.first.should eq "Fortune 1"
  end

  it "returns a random fortune" do
    fortunes_path = "spec/fixtures/test_fortunes.txt"
    fortune_teller = FortuneTeller.new(fortunes_path)
    fortune = fortune_teller.tell_fortune
    fortunes = fortune_teller.fortunes 

    fortunes.should contain(fortune)
  end
end