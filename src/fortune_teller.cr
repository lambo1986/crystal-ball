class FortuneTeller
  @@fortunes : Array(String)?# must define the type pf data and use ? to check if it's nil

  def initialize(path : String)
    @@fortunes = File.read_lines(path)
  end

  def tell_fortune
    @@fortunes.not_nil!.sample# select random fortune and check for nil
  end

  def fortunes# makes the array of fortunes available outside of the class
    @@fortunes.not_nil!
  end
end
