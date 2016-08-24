# DBC Solo Coding Challenge 4.4
# Robert Turner

puts "How many employees will be processed today?"
num_employees = gets.chomp.to_i

(1..num_employees).each do
  puts "\n================================================\n"

  # Gather information about a new employee
  puts "What is your name?"
  name = gets.chomp

  puts "How old are you and what year were you born?"
  age_year = gets.chomp
  age = age_year.split[0].to_i  # I know doing it this way is silly
  birth_year = age_year.split[1].to_i # but I'm experimenting.

  puts "Our company cafeteria serves garlic bread.\n" +
        "Should we order some for you?"
  case gets.chomp.downcase
    when "yes" then likes_garlic = true 
    when "y" then likes_garlic = true
    when "no" then likes_garlic = false
    when "n" then likes_garlic = false
    else nil
  end

  puts "Would you like to enroll in the company’s health insurance?"
  case gets.chomp.downcase
    when "yes" then wants_insurance = true 
    when "y" then wants_insurance = true
    when "no" then wants_insurance = false
    when "n" then wants_insurance = false
    else nil
  end

  # Apply logic to figure out whether the employee in question is a vampire.

  monster_type = "Results inconclusive."

  current_year = Time.now.year
  # If the employee got their age right, and is willing to eat garlic bread or 
  #sign up for insurance, the result is “Probably not a vampire.”
  if (current_year - birth_year == age) && (likes_garlic || wants_insurance)
    monster_type = "Probably not a vampire."
  end

  # If the employee got their age wrong, and hates garlic bread or waives 
  # insurance, the result is “Probably a vampire.”
  if (current_year - birth_year != age) && (!likes_garlic || !wants_insurance)
    monster_type = "Probably a vampire."
  end

  # If the employee got their age wrong, hates garlic bread, and doesn’t want 
  # insurance, the result is “Almost certainly a vampire.”
  if (current_year - birth_year != age) && !likes_garlic && !wants_insurance
    monster_type = "Almost certainly a vampire."
  end

  # Anyone going by the name of “Drake Cula” or “Tu Fang” is clearly a vampire. 
  # In that case, the result is “Definitely a vampire.
  if (name == "Drake Cula") || (name == "Tu Fang")
    monster_type = "Definitely a vampire!"
  end

  puts "\n------------------------------------------------"
  puts "Employee Evaluation: #{monster_type}"
  puts "------------------------------------------------\n"
end

puts "================================================\n"
