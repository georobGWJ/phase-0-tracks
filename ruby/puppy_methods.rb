class Puppy

  def initialize
    puts "Initializing new puppy instance ..."
  end

  def fetch(toy)
    puts "I brought back the #{toy}!"
    toy
  end

  def speak(int)
    int.times { puts "Woof!" }
  end

  def roll_over
    puts "**rolls over**"
  end

  def dog_years(human_years)
    human_years * 7
  end

  def high_five
    puts "Your puppy high fives you!"
  end

end

# Test Driver Code
# gizmo = Puppy.new
# gizmo.fetch("ball")
# gizmo.speak(3)
# gizmo.roll_over
# puts gizmo.dog_years(4)
# gizmo.high_five

class Kitten

  def initialize
    puts "You have initialized a new kitten!"
  end

  def eats(food)
    puts "Your kitten eats #{food} and meows for more."
  end

  def sleeps(hours)
    puts "Your kitten took a #{hours} hour long nap in the sun."
  end

end

num_of_kittens = 50
kittens = []

num_of_kittens.times { kittens << Kitten.new }

kittens.each do |kitten|
  kitten.eats("IAMs cat food")
  kitten.sleeps(rand(0..3))
end


# Test Driver Code
# berkeley = Kitten.new
# berkeley.eats("tuna")
# berkeley.sleeps(2)