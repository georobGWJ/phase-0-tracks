# Define the Word_Game class 

# Initialize the Class
#   set class variable goal_phrase, this is passed in as an argument

#   set class phrase nested array that stores each character in the goal_phrase and a false flag. When printing the partially guessed phrase, this flag will track if the user has guessed that character. For example the nested array for 'Nest' would be:
#   [['N', false], ['e', false], ['s', false], ['t', false]]

#   set class variable array phrases_guessed to track what the user has already guessed

#   set class int variable guesses_made set to 0 to track how many guesses have been made

#   set class int variable guesses_allowed using some logic to give more guesses for longer names

# Print Phrase Method
#   Create a string by looping through the phrase nested array and appending the correct character if the flag is true and '_' if it is false
#   Return this string

# User Guess Method
#   Takes a string argument as input.

#   If the guess hasn't been made before, add the string to the phrases_guessed array and increment guesses_made
#   Otherwise just continue

#   Attempt direct comparison of the input phrase and the goal phrase. If they match call self Win method.

#   Otherwise, set a counter to 0 and loop through both the phrase guessed characters and the phrase nested array. Where characters in both match, change the flag in the nested array to true.

#   Call self Print method

#   If the number of guesses equals the number of guesses allowed call self Lose method


# User Win Method
#   Print a You Win! message

# User Lose Method
#   Print a You Lose! message