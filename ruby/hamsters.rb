# I worked with Brian Rodriguez, brianrodriguez on GitHub on this challenge on
# 23 August 2016 (My birthday!), 18:00 PDT. 

puts "What is the hamsters name?"
hamsterName = gets.chomp

puts "What is the volume level of the hamster? On scale of 1 to 10"
hamsterVolume = gets.chomp.to_i

puts "What is the fur color of the hamster"
hamsterColor = gets.chomp

puts "Does the hamster bite?"
hamsterBite = gets.chomp
if hamsterBite.downcase == "yes"
  hamsterBite = true
else 
  hamsterBite = false
end

puts "How old is this hamster?"
hamsterAge = nil
hamsterAge = gets.chomp
if hamsterAge.length == 0
   hamsterAge = nil
end

unless hamsterAge.nil? 
  hamsterAge = hamsterAge.to_i
end 

puts "This hamster's name is #{hamsterName}"

puts "This hamster's noise level is #{hamsterVolume}"

puts "This hamster's fur color is #{hamsterColor}"

if hamsterBite
  puts "Do not adopt! This hamster bites!"
else
  puts "This hamster is ok to adopt, it doesn't bite"
end

puts "This hamster is #{hamsterAge} years old"