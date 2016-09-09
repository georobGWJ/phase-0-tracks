# Define the Word_Game class 
class WordGame

  attr_accessor :player1, :player2
  attr_reader :phrase, :chars_guessed, :guesses_made, :guesses_allowed

  # Initialize the Class
  #   set class variable goal_phrase, this is passed in as an argument
    def initialize(phrase, player1, player2)
      @phrase = phrase
      @player1, @player2 = player1, player2
  #   set class phrase nested array that stores each character in the 
  #   goal phrase and a false flag. When printing the partially guessed phrase, 
  #   this flag will track if the user has guessed that character. 
      @chars_guessed = []
      @phrase.split('').each { |char| chars_guessed << [char, false] }

  #   set class variable array phrases_guessed to track what the user has already 
  #   guessed
      @phrases_guessed = []

  #   set class int variable guesses_made set to 0 to track how many guesses have been made
      @guesses_made = 0

  #   set class int variable guesses_allowed using some logic to give more 
  #   guesses for longer names
      @guesses_allowed = 4 + @phrase.length / 2
    end


  # Print Phrase Method
  #   Create a string by looping through the phrase nested array and appending 
  #   the correct character if the flag is true and '_' if it is false
  #   Return this string
  def pretty_print
    pretty_str = ""
    @chars_guessed.each do |idx|
      if !idx[1] 
        pretty_str += "_ "
      else
        pretty_str = pretty_str + idx[0] + " "
      end
    end
    pretty_str
  end

  # User Guess Method
  #   Takes a string argument as input.

  #   If the guess hasn't been made before, add the string to the phrases_guessed array and increment guesses_made
  #   Otherwise just continue

  #   Attempt direct comparison of the input phrase and the goal phrase. If they match call self Win method.

  #   Otherwise, set a counter to 0 and loop through both the phrase guessed characters and the phrase nested array. Where characters in both match, change the flag in the nested array to true.

  #   Call self Print method

  #   If the number of guesses equals the number of guesses allowed call self Lose method
  def user_guess
  end

  # User Win Method
  #   Print a You Win! message

  # User Lose Method
  #   Print a You Lose! message

end