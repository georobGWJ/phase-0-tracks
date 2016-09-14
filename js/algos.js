// DBC Challenge 7.3
// Release 0: Write a function that takes an array of words or phrases and 
// returns the longest word or phrase in the array. 


// Release 0 PSEUDOCODE
//   This function takes an array of string elements and returns a string

// Define function longest_element
//   This function takes an array of string elements and returns a string

//   Create an empty String variable to store the longest word or phrase

//   Use a for while loop to iterate through input array.
//     For each element, check it's length.
//     If the length is longer than the existing longest word variable,
//       replace the existing longest word variable with the current element.

//  Explicitly return the longest word phrase

// Release 0 IMPLEMENTED CODE
function find_longest(phrases) {
  var longest_phrase = '';

  for (idx = 0; idx < phrases.length; idx++) {
    if (phrases[idx].length > longest_phrase.length) {
      longest_phrase = phrases[idx]
    }
  }
  return longest_phrase
}

// Test Driver Code
some_words = ['cheese', 'cat', 'cantaloupe', 'catamaran', 'cirronimbus clouds']

 console.log("The longest word or phrase is '" + find_longest(some_words) + "'.")