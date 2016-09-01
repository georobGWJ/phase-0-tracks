# I worked with April Tang, github ID: apriltang09 for Challenge 5.3
# on 30 Aug 2016 13:30 PDT

# Release 0
def block_method
 puts "This is printing from the method."
 yield("Alice", "Bill")
 yield("Dan", "Carlos")
 yield
 puts "This is printing from the method again."
end

block_method { |x, y| puts "#{x} is friends with #{y}." }

array = ["cat", "dog", "rabbit", "hamster", "goldfish"]

puts "Before .each method:"
p array

array.each do |pet|
  puts "#{pet.upcase}"
end

array.map! do |pet|
  pet.upcase
end

companion = array.map do |pet|
  pet.capitalize
end

puts "After .each method:"
p array
p companion

pet_sounds = {
  meow: "cat",
  bark: "dog",
  silence: "rabbit",
  squeak: "hamster",
  bubbles: "goldfish"
}

puts "Before .each method:"
p pet_sounds

# pet_sounds.each do |sounds, animal|
#   puts "#{animal.capitalize} makes #{sounds}."
# end

pet_sounds.map do |sounds, animal|
  puts "#{sounds} is made by #{animal}."
end

puts "After .each method:"
p pet_sounds
# #map doesn't change anything on a hash just returns 

#Release 2

# 1.
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
numbers.delete_if {|number| number < 5}
# => [5, 6, 7, 8, 9]

numbers = {
  one: 1,
  two: 2,
  three: 3, 
  four: 4, 
  five: 5,
  six: 6,
  seven: 7, 
  eight: 8,
  nine: 9
}

p numbers.delete_if {|word, digit| digit < 5}
# {:five=>5, :six=>6, :seven=>7, :eight=>8, :nine=>9}
# {:five=>5, :six=>6, :seven=>7, :eight=>8, :nine=>9}
p numbers
# => {:five=>5, :six=>6, :seven=>7, :eight=>8, :nine=>9}
# #numbers is modified in place without !

#2.
numbers = {
  one: 1,
  two: 2,
  three: 3, 
  four: 4, 
  five: 5,
  six: 6,
  seven: 7, 
  eight: 8,
  nine: 9
}

p numbers.delete_if {|word, digit| digit > 5}
# {:one=>1, :two=>2, :three=>3, :four=>4, :five=>5}
p numbers
# {:one=>1, :two=>2, :three=>3, :four=>4, :five=>5}
# => {:one=>1, :two=>2, :three=>3, :four=>4, :five=>5}
# #numbers is modified in place without !

numbers = [-2, -1, 0, 1, 2, 3, 4, 5]
numbers.keep_if {|num| num < 3}
# => [-2, -1, 0, 1, 2]

#3.
[29304, 9231, 120395, 9386, 19353].select {|digit| digit.odd?}
# => [9231, 120395, 19353]

difficult_numbers = {
  pie_ish: 3,
  pound: 16,
  cup: 8,
  tablespoon: 5
}

difficult_numbers.select {|constant, num| num.odd?}
# => {:pie_ish=>3, :tablespoon=>5}

#4.

nums = [23, 568, 35, 890, 64 ,9]
nums.drop_while {|num| num < 600}
# => [890, 64, 9]
