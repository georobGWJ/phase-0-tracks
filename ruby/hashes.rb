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
client_data[:first_name] = fullname[0].to_s.capitalize
if fullname.length > 2
  client_data[:middle_name] = fullname[1].to_s.capitalize
  client_data[:surname] = fullname[2].to_s.capitalize
elsif fullname.length == 2
  client_data[:surname] = fullname[1].to_s.capitalize
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

#p client_data

# Print keys and values out in an easily readable format 
puts "\n============================================================\n"
puts "Thank you #{client_data[:first_name]}! Here is what we understand to be true:\n"
puts "------------------------------------------------------------\n"

puts "%-20s| %s" % 
  ["Name", client_data[:first_name] + " " + client_data[:surname]]
puts "%-20s| %d" % ["Age", client_data[:age]]
puts "%-20s| %d" % ["Number of Children", client_data[:num_children]]
puts "%-20s| %1.1f" % ["Home Square Footage", client_data[:house_sq_ft]]
puts "%-20s| %s" % ["Pet Owner", client_data[:has_pets].to_s.capitalize]
puts "%-20s| %s" % ["Preferred Decor", client_data[:decor_pref].capitalize]
puts "\n============================================================\n"

# Ask user if any values need to be changed. If so, prompt user to ask 
# which value to change. Use case statement to change chosen value.
puts "Is this correct?"
case gets.chomp.downcase
  when "yes", "y"
    puts "Great!" 
  when "no", "n"
    puts "Sorry! What would you like to change?"
    case gets.chomp.downcase
      when "name"
        puts "\nPlease enter your full name"
        fullname = gets.chomp.split
        client_data[:first_name] = fullname[0].to_s.capitalize
        if fullname.length > 2
          client_data[:middle_name] = fullname[1].to_s.capitalize
          client_data[:surname] = fullname[2].to_s.capitalize
        elsif fullname.length == 2
          client_data[:middle_name] = ""
          client_data[:surname] = fullname[1].to_s.capitalize
        end

      when "age"
        puts "\nHow old are you?"
        client_data[:age] = gets.chomp.to_i

      when "children", "number of children"
        puts "\nHow many chilren do you have?"
        client_data[:num_children] = gets.chomp.to_i

      when "square footage", "home square footage"
        puts "\nWhat is the square footage of your home?"
        client_data[:house_sq_ft] = gets.chomp.to_f

      when "pet owner"
        puts "\nDo you have cats or dogs or turtles or other kinds of pets?"
        case gets.chomp.downcase
          when "yes", "y" then client_data[:has_pets] = true 
          when "no", "n" then client_data[:has_pets] = false
        end

      when "decor", "preferred decor"
        puts "\nWhat is your preferred decor?"
        client_data[:decor_pref] = gets.chomp.to_s
    end
end

# Print final keys and values out in an easily readable format and thank
# the user for using the program

puts "\n============================================================\n"
puts "Thank you #{client_data[:first_name]}! This is the Truth.\n"
puts "------------------------------------------------------------\n"
puts "%-20s| %s" % 
  ["Name", client_data[:first_name] + " " + client_data[:surname]]
puts "%-20s| %d" % ["Age", client_data[:age]]
puts "%-20s| %d" % ["Number of Children", client_data[:num_children]]
puts "%-20s| %1.1f" % ["Home Square Footage", client_data[:house_sq_ft]]
puts "%-20s| %s" % ["Pet Owner", client_data[:has_pets].to_s.capitalize]
puts "%-20s| %s" % ["Preferred Decor", client_data[:decor_pref].capitalize]
puts "============================================================\n"

puts "We look forward to working with you to decorate your house!!!"