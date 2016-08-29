# Replace in the "<???>" with the appropriate method (and arguments, if any).
# Uncomment the calls to catch these methods red-handed.

# When there's more than one suspect who could have
# committed the crime, add additional calls to prove it.

puts "iNvEsTiGaTiOn".swapcase
puts 'This should return: => "InVeStIgAtIoN"'
puts "iNvEsTiGaTiOn".swapcase!
puts 'This should also return: => "InVeStIgAtIoN" except it modifies the 
object in place.'
puts

puts "zom".gsub('o', 'oo')
puts 'This should return: => "zoom"'
puts "zom".gsub!('o', 'oo')
puts 'This should also return: => "zoom" except it modifies the 
object in place.'
puts

puts "enhance".center(15)
puts 'This should return: => "    enhance    "'
puts

puts "Stop! You’re under arrest!".upcase
puts 'This should return: => "STOP! YOU’RE UNDER ARREST!"'
puts

puts "the usual".concat(" suspects")
puts 'This should return: => "the usual suspects"'
puts "the usual".<<" suspects"
puts 'So should this.'
puts "the usual" + " suspects"
puts "And this."
puts

puts " suspects".prepend("the usual")
puts 'This should return: => "the usual suspects"'
puts

puts "The case of the disappearing last letter".chop
puts 'This should return: => "The case of the disappearing last lette"'
puts "The case of the disappearing last letter"[0...-1]
puts "So should this, using String indexing."
puts

puts "The mystery of the missing first letter".sub(/^./, '')
puts 'This should return: => "he mystery of the missing first letter"'
puts "The mystery of the missing first letter"[1..-1]
puts "So should this, using String indexing."
puts

puts "Elementary,    my   dear        Watson!".squeeze
puts 'This should return: => "Elementary, my dear Watson!"'
puts

puts "z".bytes
puts 'This should return: => 122. However it returns it in an Array.'
puts "z".bytes[0].to_s
puts 'This should return 122 as a String.'
#(What is the significance of the number 122 in relation to the character z?)
puts '122 is the ASCII value of the lowercase letter "z"'
puts

puts "How many times does the letter 'a' appear in this string?".count("a")
puts 'This should return: => 4'
puts
