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

  def speak
    puts "Ho, ho, ho! Haaappy holidays!"
  end

  def eat_milk_and_cookies(cookie_type)
    puts "That was a good #{cookie_type}!"
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

santas.each { |santa| p santa}
# al = Santa.new("male", "ambiguous")
# al.speak
# al.eat_milk_and_cookies("Oreo")

# p al