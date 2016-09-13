# Virus Predictor

# I worked on this challenge with: @mikejtaylor.
# We spent 2.0 hours on this challenge.

# EXPLANATION OF require_relative
# Require Relative is needed to pull the data and methods from another
# file into the scope of this program/script and makes it all accessible.

require_relative 'state_data'

class VirusPredictor

  # Create a new instance of VirusPredictor taking three arguments
  # to set the state of the instance (state, pop density and population).
  def initialize(state_of_origin, population_density, population)
    @state = state_of_origin
    @population = population
    @population_density = population_density
  end

  # Calls additional instance methods to calculate predicted deaths and
  # expected speed of spread for the virus
  def virus_effects
    predicted_deaths #(@population_density, @population, @state)
    speed_of_spread #(@population_density, @state)
  end

  private

  # Uses pop density and population to predict how many people will die
  def predicted_deaths #(population_density, population, state)
    # predicted deaths is solely based on population density


    if @population_density >= 200
      number_of_deaths = (@population * 0.4).floor
    elsif @population_density < 200 && @population_density >= 50
      number_of_deaths = (@population * (@population_density.to_i/50) * 0.1).floor
    else
      number_of_deaths = (@population * 0.05).floor
    end

    print "#{@state} will lose #{number_of_deaths} people in this outbreak!!!\n"

  end

  # Uses pop density to predict long it will take for the virus to spread
  def speed_of_spread #(population_density, state) #in months
    # We are still perfecting our formula here. The speed is also affected
    # by additional factors we haven't added into this functionality.
    speed = 0.0

    case @population_density
      when 200..10000 then speed = 0.5
      when 150...200  then speed = 1
      when 100...150  then speed = 1.5
      when 50...100   then speed = 2
    else
      speed = 2.5 
    end

    puts " and will spread across the state in #{speed} months.\n\n"

  end

end

#=======================================================================

# DRIVER CODE
 # initialize VirusPredictor for each state

STATE_DATA.each do |state_name, pop_data|
  state_instance = VirusPredictor.new(state_name, pop_data[:population_density],pop_data[:population])
  state_instance.virus_effects
end


  # STATE_DATA[state_name] == pop_data # => true

# Deprecated Driver Code

# alabama = VirusPredictor.new("Alabama", STATE_DATA["Alabama"][:population_density], STATE_DATA["Alabama"][:population])
# alabama.predicted_deaths
# alabama.virus_effects

# jersey = VirusPredictor.new("New Jersey", STATE_DATA["New Jersey"][:population_density], STATE_DATA["New Jersey"][:population])
# jersey.virus_effects

# california = VirusPredictor.new("California", STATE_DATA["California"][:population_density], STATE_DATA["California"][:population])
# california.virus_effects

# alaska = VirusPredictor.new("Alaska", STATE_DATA["Alaska"][:population_density], STATE_DATA["Alaska"][:population])
# alaska.virus_effects


#=======================================================================
# Reflection Section
#=======================================================================
# What are the differences between the two different hash syntaxes shown in the state_data file?

# The 2 kinds of hash syntaxes are using a rocket (=>) or a colon (:). When you use a rocket and a string, you are adding string keys. 
# ex. hash = {"cat" => "meow"}
# You can also use the rocket to add symbol keys.
# ex. hash = {:cat => "meow"}
# But it can be easier to use the colon syntax which automatically converts
# your keys to symbols
# ex. hash = {cat: "meow"}


# What does require_relative do? How is it different from require?

# require_relative will recursively search the directory that the .rb file that calls it is located within for the file(s) specified. require requires a complete filepath.


# What are some ways to iterate through a hash?

# The method that I default to is to use the .each method along with a do...end or {} block. You could also use the .map method or create a separate array of key values that you then use to loop through the array in a specific order.


# When refactoring virus_effects, what stood out to you about the variables, if anything?

# You are passing information to the instance that the instance already 'knows'. It can access it's own state and see those values.


# What concept did you most solidify in this challenge?

# Accessing nested elements within a nested hash using block parameters. For example in the code we wrote, STATE_ARRAY[state_name][:population] is the same as pop_data[:population] when looping through the hash in lines 74 to 77. This saves typing and would be easier to refactor if needed.