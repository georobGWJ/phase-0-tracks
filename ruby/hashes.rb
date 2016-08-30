# DBC Challenge 5.2

# Create empty hash to store client data with relevant keys and nil values
client_data = {first_name: nil, middle_name: nil, surname: nil, age: nil, 
  num_children: nil, house_sq_ft: nil, has_pets: nil, decor_pref: nil}

# Prompt the user for data to populate all key:value pairs
# Convert user input into appropriate data type before assigning values to keys
puts "\nHi! Welcome to Worldwide Domination Design, Inc.\n".center(60)
puts "Please answer the following questions to begin."
puts "============================================================\n"

puts "\nPlease enter your full name"
fullname = gets.chomp.split
client_data[:first_name] = fullname[0].to_s
if fullname.length > 2
  client_data[:middle_name] = fullname[1].to_s
  client_data[:surname] = fullname[2].to_s
elsif fullname.length == 2
  client_data[:surname] = fullname[1].to_s
end

puts "\nHow old are you?"
client_data[:age] = gets.chomp.to_i

puts "\nHow many chilren do you have?"
client_data[:num_children] = gets.chomp.to_i

puts "\nWhat is the square footage of your home?"
client_data[:house_sq_ft] = gets.chomp.to_f

puts "\nDo you have cats or dogs or turtles or other kinds of pets?"
case gets.chomp.downcase
    when "yes", "y" then client_data[:has_pets] = true 
    when "no", "n" then client_data[:has_pets] = false
end

puts "\nWhat is your preferred decor?"
client_data[:decor_pref] = gets.chomp.to_s

p client_data


# Print keys and values out in an easily readable format 


# Ask user if any values need to be changed. If so, prompt user to ask 
# which value to change. Use case statement to change chosen value.


# Print final keys and values out in an easily readable format and thank
# the user for using the program

