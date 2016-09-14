// DBC Challenge 7.1
// JavaScript Reverse String Function

// Define Function reverse_string
//   This function takes a string as an argument and returns a reversed string.

// Assign variable to hold string

// Assign variable with an empty string to hold the reversed string

// Use a for while loop to iterate through input string
//   Since the characters in the string can be accessed via their index values,
//   the loop will start at the end of the index string and iterate towards
//   the beginning.
//   As each character is accessed, it will be concatenated onto the 
//   return string variable.

// Explicity return the reversed string variable

function reverse_string(phrase) {
  var input_string = phrase;
  var reversed_string = ''

  for (idx = phrase.length - 1; idx >= 0; idx -= 1) {
    reversed_string += phrase[idx]
  }

  return reversed_string
}

// Test Driver Code
// console.log(reverse_string("Eggplant"))