# Virus Predictor

# I worked on this challenge with: @mikejtaylor.
# We spent 1.5 hours on this challenge.

# EXPLANATION OF require_relative
# Require Relative is needed to pull the data and methods from another
# file into the scope of this program / script and makes it all accessible.

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

    # if @population_density >= 200
    #   number_of_deaths = (@population * 0.4).floor
    # elsif @population_density >= 150
    #   number_of_deaths = (@population * 0.3).floor
    # elsif @population_density >= 100
    #   number_of_deaths = (@population * 0.2).floor
    # elsif @population_density >= 50
    #   number_of_deaths = (@population * 0.1).floor
    # else
    #   number_of_deaths = (@population * 0.05).floor
    # end

    # print "#{@state} will lose #{number_of_deaths} people in this outbreak"

  end

  # Uses pop density to predict long it will take for the virus to spread
  def speed_of_spread #(population_density, state) #in months
    # We are still perfecting our formula here. The speed is also affected
    # by additional factors we haven't added into this functionality.
    speed = 0.0

    if @population_density >= 200
      speed += 0.5
    elsif @population_density >= 150
      speed += 1
    elsif @population_density >= 100
      speed += 1.5
    elsif @population_density >= 50
      speed += 2
    else
      speed += 2.5
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

# What does require_relative do? How is it different from require?

# What are some ways to iterate through a hash?

# When refactoring virus_effects, what stood out to you about the variables, if anything?

# What concept did you most solidify in this challenge?