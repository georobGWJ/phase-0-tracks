# DBC Challenge 6.4

# module Shout
  
#   def self.yell_angrily(words)
#     words + "!!!" + " :("
#   end

#   def self.yelling_happily(words)
#     "\xE2\x99\xA5 " + words + "! \xE2\x99\xA5"
#   end

# end

# Test Driver Code for stand alone Shout Module
# p Shout.yell_angrily("I hate trains")

# p Shout.yelling_happily("I love cheeseburgers")

module Shout
  def yell_angrily(words)
    words + "!!!" + " :("
  end

  def yelling_happily(words)
    "\xE2\x99\xA5 " + words + "! \xE2\x99\xA5"
  end
end

class The_Isley_Brothers
  include Shout
end

class Tears_For_Fears
  include Shout
end

# Test Driver Code for mixin Shout Module
brothers = The_Isley_Brothers.new
puts brothers.yelling_happily("You know you make me wanna (Shout!)")
puts brothers.yelling_happily("Kick my heels up and (Shout!)")
puts brothers.yelling_happily("Throw my hands up and (Shout!)")
puts brothers.yelling_happily("Throw my head back and (Shout!)")
puts brothers.yelling_happily("Come on now (Shout!)")
puts "\n\n"

tears = Tears_For_Fears.new
puts tears.yell_angrily("Shout, shout, let it all out")
puts tears.yell_angrily("These are the things I can do without")
puts tears.yell_angrily("Come on")
puts tears.yell_angrily("I'm talking to you, so come on")