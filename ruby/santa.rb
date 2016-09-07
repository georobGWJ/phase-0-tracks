# DBC Challenge 6.3

class Santa

  attr_reader :age, :ethnicity
  attr_accessor :gender
  def initialize(gender, ethnicity)
    @gender = gender
    @ethnicity = ethnicity
    @reindeer_ranking = ["Rudolph", "Dasher", "Dancer", "Prancer", "Vixen", 
                         "Comet", "Cupid", "Donner", "Blitzen"]
    @age = 0
    puts "Initializing Santa instance ..."
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

# From http://nonbinary.org/wiki/List_of_nonbinary_identities
genders = ['male', 'female', 'agender', 'bigender', 'hijra', 
           'demiboy', 'demigirl', 'two-spirit', 'sekhet', 'polygender']

ethnicities = ['English', 'French', 'German', 'Nordic', 'Inuit', 'Indonesian', 
               'Japanese', 'Arabic', 'Chinese', 'Korean', 'Mixed Race', 
               'Samoan', 'Mexican','Peruvian', 'Russian', 'Indian', 'Kurdish', 
               'Persian', 'Sioux', 'Dakota', 'Seminole', 'Algonquin']

num_of_santas = 10000 # Arbitrary value

counter = 0

while counter < num_of_santas
  unique_santa = Santa.new(genders.sample, ethnicities.sample)
  
  random_age = rand(0..140)
  subcounter = 0
  while subcounter < random_age
    unique_santa.celebrate_birthday
    subcounter += 1
  end
  counter += 1
  puts "This Santa is a #{unique_santa.gender} #{unique_santa.ethnicity} and #{unique_santa.age} years old."
end

# santas = []

# santa_applicants.each { | gend, ethn | santas << Santa.new(gend, ethn) }

#santas.each { |santa| p santa}

# al = Santa.new("male", "black")
# p al
# al.speak
# al.eat_milk_and_cookies("Oreo")
# al.celebrate_birthday
# al.get_mad_at("Rudolph")
# al.gender = "bigender"
# p al

# puts "Santa is #{al.age} years old and is #{al.ethnicity}."