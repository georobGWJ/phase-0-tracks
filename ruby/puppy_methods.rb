class Puppy

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

gizmo = Puppy.new
gizmo.fetch("ball")
gizmo.speak(3)
gizmo.roll_over
puts gizmo.dog_years(4)
gizmo.high_five