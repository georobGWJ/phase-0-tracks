# DBC Solo Challenge 5.5
# Robert Turner, Secret Agent Name: Vaspis Sucisv

# Develop an Algorithm, given a name as an input, to:
# 1. Swap the first and last name.
# 2. Changing all of the vowels (a, e, i, o, or u) to the next vowel in 'aeiou', 
# and all of the consonants (everything else besides the vowels) to the next 
# consonant in the alphabet. So 'a' would become 'e', 'u' would become 'a', 
# and 'd' would become 'f'.

# PSEUDOCODE
# Create a method to implement the process.
def codename(real_name)
  # First take the name and split it into an array of 2 words using .split
  # I am assuming there is no middle name.
  code_name = real_name.downcase.split

  # Reverse the array using .reverse!
  code_name.reverse!
  # p code_name # test code line

  # Rejoin the last and first name into a single string using join
  code_name = code_name.join(' ')
  # p code_name # test code line

  # Replace all vowels with the next vowel in this string using .tr!
  code_name.tr!("aeiou", "eioua")
  # p code_name # test code line

  # Replace all consonants with the next consonant in this string using .tr!
  code_name.tr!("bcdfghjklmnpqrstvwxyz", "cdfghjklmnpqrstvwxyb")
  code_name # test code line

  # Return the codename
  code_name
end

# Ask User for real name
puts "What is your name? (no middle names, please)"
name = gets.chomp

p codename(name)