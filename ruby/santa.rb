# DBC Challenge 6.3

class Santa

  def initialize(gender, ethnicity)
    @gender = gender
    @ethnicity = ethnicity
    @reindeer_ranking = ["Rudolph", "Dasher", "Dancer", "Prancer", "Vixen", 
                         "Comet", "Cupid", "Donner", "Blitzen"]
    @age = 0
    puts "Initializing Santa instance ..."
  end
  
  # Setter method(s)
  def gender=(new_gender)
    @gender = new_gender
  end

  # Getter method(s)
  def age
    @age
  end

  def ethnicity
    @ethnicity
  end

  # Other methods
  def speak
    puts "Ho, ho, ho! Haaappy holidays!"
  end

  def eat_milk_and_cookies(cookie_type)
    puts "That was a good #{cookie_type}!"
  end

  def celebrate_birthday
    @age += 1
  end

  def get_mad_at(reindeer)
    @reindeer_ranking.delete(reindeer)
    @reindeer_ranking << reindeer
  end

end

# Test Driver Code
santa_applicants = {"female" => "Korean", 
                    "male" => "Inuit", 
                    "bigender" => "Irish",
                    "no gender" => "Samoan",
                    "idiot" => "Trump"}

santas = []

santa_applicants.each { | gend, ethn | santas << Santa.new(gend, ethn) }

#santas.each { |santa| p santa}

al = Santa.new("male", "black")
p al
# al.speak
# al.eat_milk_and_cookies("Oreo")
al.celebrate_birthday
al.get_mad_at("Rudolph")
al.gender = "bigender"
p al

puts "Santa is #{al.age} years old and is #{al.ethnicity}."