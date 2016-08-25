# DBC Solo Coding Challenge 4.4
# Robert Turner

puts "How many employees will be processed today?"
num_employees = gets.chomp.to_i
if num_employees < 1
  puts "YOU ran the program bud. You need to put in at least one employee!\n"
  num_employees = 1
end

(1..num_employees).each do
  puts "\n================================================\n"

  # Gather information about a new employee
  puts "What is your name?"
  name = gets.chomp

  puts "\nHow old are you and what year were you born?
  Put a space between these."
  age_year = gets.chomp
  age = age_year.split[0].to_i        # Splitting a string creates an array.
  birth_year = age_year.split[1].to_i # Using array_name[] calls an element.

  puts "\nOur company cafeteria serves garlic bread.\n" +
        "Should we order some for you?"
  case gets.chomp.downcase
    when "yes", "y" then likes_garlic = true 
    when "no", "n" then likes_garlic = false
    else nil
  end

  puts "\nWould you like to enroll in the company’s health insurance?"
  case gets.chomp.downcase
    when "yes", "y" then wants_insurance = true 
    when "no", "n" then wants_insurance = false
    else nil
  end

  # Apply logic to figure out whether the employee in question is a vampire.

  result = "Results inconclusive."

  current_year = Time.now.year
  # If the employee got their age right, and is willing to eat garlic bread or 
  # to sign up for insurance, the result is “Probably not a vampire.”
  if (current_year - birth_year == age) && (likes_garlic || wants_insurance)
    result = "Probably not a vampire."
  end

  # If the employee got their age wrong, and hates garlic bread or waives 
  # insurance, the result is “Probably a vampire.”
  if (current_year - birth_year != age) && (!likes_garlic || !wants_insurance)
    result = "Probably a vampire."
  end

  # Check for allergies to see how the employee feels about sunshine
  puts "Please enter your allergies one at a time.\nWhen finished, enter Done:"
  while true
    print "Allergy: "
    allergy = gets.chomp.downcase
    # Break out of loop if user enters 'sunshine' or 'done'
    if allergy == "sunshine"
      result = "Probably a vampire."
      break
    elsif allergy == "done"
      break
    end
  end

  # If the employee got their age wrong, hates garlic bread, and doesn’t want 
  # insurance, the result is “Almost certainly a vampire.”
  if (current_year - birth_year != age) && !likes_garlic && !wants_insurance
    result = "Almost certainly a vampire."
  end

  # Anyone going by the name of “Drake Cula” or “Tu Fang” is clearly a vampire. 
  # In that case, the result is “Definitely a vampire.
  if (name == "Drake Cula") || (name == "Tu Fang")
    result = "Definitely a vampire!"
  end

  puts "\n------------------------------------------------"
  puts "Employee Evaluation: #{result}"
  puts "------------------------------------------------\n"
end

puts "================================================\n"

# The string \xE2\x99\xA5 prints a heart.
puts "\nActually, never mind! \nWhat do these questions have to do with anything?
\n\xE2\x99\xA5 Let's all be friends! \xE2\x99\xA5"
