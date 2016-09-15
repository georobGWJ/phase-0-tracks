// DBC Challenge 7.3
// RELEASE 0: Write a function that takes an array of words or phrases and 
// returns the longest word or phrase in the array. 


// Release 0 PSEUDOCODE

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

// RELEASE 1: Write a function that takes two objects and checks to see if the 
// objects share at least one key-value pair. 

// Release 1 PSEUDOCODE
// Define function key_value_match
//   This function takes two object and looks for matching key-value pairs. If
//   at least one matching pair is found the function returns True, otherwise
//   it returns False

//   Create a Boolean variable set to false to use as flag for matching pairs found

//   Create a nested loop to compart the key value pairs from the two objects
//     The outer loop will step through the keys in Object 1
//       For each key, a nested loop will step through the keys in Object 2
//         The keys and values from Object 1 will be logically compared to those
//         in Object 2. If any matches are found, the matching pair flag
//         will be set to true and the loop will exit

//   Explicity return the matching pair flag

// Release 0 IMPLEMENTED CODE


// RELEASE 0 Test Driver Code
some_words = ['cheese', 'cantaloupe', 'catamaran', 'cirronimbus clouds', 'cat']

 console.log("The longest word or phrase is '" + find_longest(some_words) + "'.")

 // RELEASE 1 Test Driver Code