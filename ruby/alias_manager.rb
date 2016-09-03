# DBC Solo Challenge 5.5
# Robert Turner

# Develop an Algorithm, given a name as an input, to:
# 1. Swap the first and last name.
# 2. Changing all of the vowels (a, e, i, o, or u) to the next vowel in 'aeiou', 
# and all of the consonants (everything else besides the vowels) to the next 
# consonant in the alphabet. So 'a' would become 'e', 'u' would become 'a', 
# and 'd' would become 'f'.

# PSEUDOCODE
# Create a method to implement the process.

  # First take the name and split it into an array of 2 words using .split
  # I am assuming there is no middle name.

  # Reverse the array using .reverse
  # Rejoin the last and first name into a single string using +

  # Replace all vowels with the next vowel in this string using .tr

  # Replace all consonants with the next consonant in this string using .tr

  # Return the codename
