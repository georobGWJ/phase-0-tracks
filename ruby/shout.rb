module Shout
  
  def self.yell_angrily(words)
    words + "!!!" + " :("
  end

  def self.yelling_happily(words)
    "\xE2\x99\xA5 " + words + "! \xE2\x99\xA5"
  end

end

p Shout.yell_angrily("I hate trains")

p Shout.yelling_happily("I love cheeseburgers")