# DBC Challenge 6.3

class Santa

  def initialize
    puts "Initializing Santa instance ..."
  end

  def speak
    puts "Ho, ho, ho! Haaappy holidays!"
  end

  def eat_milk_and_cookies(cookie_type)
    puts "That was a good #{cookie_type}!"
  end

end

# Test Driver Code
al = Santa.new
al.speak
al.eat_milk_and_cookies("Oreo")