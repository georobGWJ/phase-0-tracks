# DBC Solo Challenge 5.5
# Robert Turner, Secret Agent Name: Vaspis Sucisv

# PSEUDOCODE
# Create a method to implement the process.
def codename(real_name)
  # First take the name and split it into an array of 2 words using .split
  # I am assuming there is no middle name.
  code_name = real_name.downcase.split

  # Reverse the array using .reverse!
  code_name.reverse!

  # Rejoin the last and first name into a single string using join
  code_name = code_name.join(' ')

  # Replace all vowels with the next vowel in this string using .tr!
  code_name.tr!("aeiou", "eioua")

  # Replace all consonants with the next consonant in this string using .tr!
  code_name.tr!("bcdfghjklmnpqrstvwxyz", "cdfghjklmnpqrstvwxyb")
  code_name # test code line

  # Split the codename, capitalize and return
  code_name = code_name.split
  code_name.map! { |x| x.capitalize}
  code_name = code_name.join(' ')
  code_name
end

# Create hash to store secret agent data
secret_agents = {}

# UI Loop to convert multiple user names
while true
  # Ask User for real name
  puts "What is your name? (no middle names, please)"

  name = gets.chomp
  case name
    when "" then break
    when "quit" then break
    else 
      # Create hash entry for agent
      secret_agents[name] = codename(name)
      p secret_agents[name]
    
  end
end

# Reveal the identities of the Agents
secret_agents.each {|key, value| puts "Secret Agent #{value} is really #{key}." }
