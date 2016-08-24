# DBC Solo Coding Challenge 4.4
# Robert Turner

# Gather information about new employee
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

# Test Code #
# p name
# p age 
# p birth_year 
# p likes_garlic
# p wants_insurance

# Apply logic to figure out whether the employee in question is a vampire.

monster_type = "Results inconclusive."

current_year = Time.now.year
if (current_year - birth_year == age) && (likes_garlic || wants_insurance)
  monster_type = "Probably not a vampire."
end

if (current_year - birth_year != age) && (!likes_garlic || !wants_insurance)
  monster_type = "Probably a vampire."
end

if (current_year - birth_year != age) && !likes_garlic && !wants_insurance
  monster_type = "Almost certainly a vampire."
end

if (name == "Drake Cula") || (name == "Tu Fang")
  monster_type = "Definitely a vampire!"
end

puts "Employee Evaluation: #{monster_type}"
