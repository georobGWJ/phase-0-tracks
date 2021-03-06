# PSEUDOCODE
# Define the Word_Game class 
  # Initialize the Class
    #   set class variables phrase, player1 and player2 
    #   these are passed in as arguments

    #   set class phrase nested array that stores each character in the 
    #   goal phrase and a false flag. When printing the partially guessed phrase, 
    #   this flag will track if the user has guessed that character. 

    #   set class variable array phrases_guessed to track what the user has already 
    #   guessed

    #   set class int variable guesses_made set to 0 to track how many guesses 
    #   have been made
  
    #   set class int variable guesses_allowed using some logic to give more 
    #   guesses for longer names

    #   set game_over flag
    #   Initialize returns false by default

  # Pretty Print Phrase Method
    #   Create a string by looping through the phrase nested array and appending 
    #   the correct character if the flag is true and '_' if it is false
    #   Pretty Print Returns this string

  # User Guess Method
    #   Takes a string argument as input.

    #   If the guess hasn't been made before, add the string to the 
    #   phrases_guessed array and increment guesses_made

    #   Attempt direct comparison of the input phrase and the goal phrase. If 
    #   they match call self Win method.

    #   Otherwise, set a counter to 0 and loop through both the phrase guessed 
    #   characters and the phrase nested array. Where characters in both match, 
    #   change the flag in the nested array to true.

    #   Call self pretty_print method

    #   If the number of guesses equals the number of guesses allowed call 
    #   self Lose method
    #   User Guess Returns nil by default

  # User Win Method
  #   Print a You Win! message and set game_over flag to true

  # User Lose Method
  #   Print a You Lose! message and set game_over flag to true


  
class WordGame

  attr_accessor :player1, :player2
  attr_reader :phrase, :chars_guessed, :guesses_made, :guesses_allowed,
              :phrases_guessed, :game_over

    def initialize(phrase, player1 = "Player 1", player2 = "Player 2")
      @phrase = phrase
      @player1, @player2 = player1, player2
      @chars_guessed = []
      @phrase.split('').each { |char| chars_guessed << [char, false] }

      @phrases_guessed = []
      @guesses_made = 0
      @guesses_allowed = 4 + @phrase.length / 2
      @game_over = false
    end


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

  def user_guess(guess)
    if !@phrases_guessed.include? guess 
      @phrases_guessed << guess
      @guesses_made += 1
    end
    
    idx = 0
    while idx < guess.length && idx < @phrase.length
      if guess[idx] == @phrase[idx]
        chars_guessed[idx][1] = true
      end
      idx += 1
    end

    puts self.pretty_print

    if guess == @phrase
      self.win
    elsif @guesses_made == @guesses_allowed
      self.lose
    end

  end

  def win
    puts "\nYou're a big winner. I'm gonna ask you a simple question and I" 
    puts "want you to listen to me: who's the big winner here tonight?" 
    puts "Huh? #{player2}, that's who. #{player2}'s the big winner."
    puts "#{player2} wins!"
    @game_over = true
  end


  def lose
    puts "\nYou had #{@guesses_allowed} guesses...  #{@guesses_allowed}, #{player2}!"
    puts "It looks like #{player1} outsmarted you."
    @game_over = true
  end

end

# Driver Code

puts "Welcome to the Wondeful, Wooly and Wacky World of Words!!!"
puts "==========================================================\n"

while true
  puts "Would you like to play a game?"
  puts "There should be two of you:"
  puts "One devious devil defining the phrase (Player 1), and"
  puts "One energetic etymolygist to guess the phrase (Player 2)"

  puts "\nWho gets to choose the phrase for this game? (Player 1)"
  player1 = gets.chomp

  puts "\nWho will guess the phrase for this game? (Player 2)"
  player2 = gets.chomp

  puts "\nGreat! Glad that's decided. #{player2}, close your eyes now."
  puts "#{player1}, enter your phrase now:"
  phrase = gets.chomp

  game = WordGame.new(phrase, player1, player2)

  until game.game_over
    puts "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "#{game.player2}, the word is #{game.phrase.length} characters long."
    puts "You have #{game.guesses_allowed-game.guesses_made} guesses remaining."
    puts "Please enter your next guess:"
    game.user_guess(gets.chomp)
  end

  puts "\nWould you like to play again?\n"
  if ['n', 'no'].include? gets.chomp.downcase
    break 
  end

end
