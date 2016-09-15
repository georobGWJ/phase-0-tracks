// DBC Challenge 7.3

//==========================================================
// RELEASE 0: Write a function that takes an array of words or phrases and 
// returns the longest word or phrase in the array. 

// RELEASE 0 PSEUDOCODE

// Define function longest_element
//   This function takes an array of string elements and returns a string

//   Create an empty String variable to store the longest word or phrase

//   Use a for while loop to iterate through input array.
//     For each element, check it's length.
//     If the length is longer than the existing longest word variable,
//       replace the existing longest word variable with the current element.

//  Explicitly return the longest word phrase

//==========================================================
// RELEASE 0 IMPLEMENTED CODE
function find_longest(phrases) {
  var longest_phrase = '';

  for (idx = 0; idx < phrases.length; idx++) {
    if (phrases[idx].length > longest_phrase.length) {
      longest_phrase = phrases[idx]
    }
  }
  return longest_phrase
}

//==========================================================
// RELEASE 1: Write a function that takes two objects and checks to see if the 
// objects share at least one key-value pair. 

// RELEASE 1 PSEUDOCODE
// Define function key_value_match
//   This function takes two object and looks for matching key-value pairs. If
//   at least one matching pair is found the function returns True, otherwise
//   it returns False

//   Create a Boolean variable set to false to use as flag for matching pairs found

//   Create a loop to compare the key value pairs from the two objects
//     The loop will step through the keys in Object 1
//       For each key, The keys and values from Object 1 will be logically 
//         compared to those in Object 2. If the key doesn't even exist in 
//         Object2, no matches are possible. If the key exists in both Objects
//         and any matches are found, the matching pair flag will be set to 
//         true and the loop will exit

//   Explicity return the matching pair flag

//==========================================================
// RELEASE 1 IMPLEMENTED CODE
function key_value_match(object1, object2) {
  var match_flag = false;
  var object1_keys = Object.keys(object1);

  for (idx = 0; idx < object1_keys.length; idx++) {
    key = String(object1_keys[idx]);

    if (object1[key] == object2[key]) {
      match_flag = true;
      break;
    }
  }

return match_flag
}


//==========================================================
// RELEASE 2: Write a function that takes an integer for length, and builds 
// and returns an array of strings of the given length. So if we ran your 
// function with an argument of 3, we would get an array of 3 random words back 
// (the words don't have to be actual sensical English words -- "nnnnfph" 
// totally counts). The words should be of randomly varying length, with a 
// minimum of 1 letter and a maximum of 10 letters.

// RELEASE 2 PSEUDOCODE

// Define function random_words function
//   This function takes an integer and returns an array of string elements 
//   as long as the input argument. Each element in the return array varies
//   randomly between 1 and 10 characters.

//   Create an empty array variable that will hold the words and be returned
//   Create an alphabet string. This will be randomly sampled to build fake words

//     Create a for-while loop that iterates once for every word that is to be 
//       created.
//       Create an empty string variable to store the fake word

//         Randomly select a value between 1 and 10
//           Create a nested for-while loop to build the fake word that iterated
//           the number of times the RNG above generated.

//           Randomly generate another number between 1 and the length of the fake
//           letter list. 

//       Access the letter and concatenate it to the fake word

//     Explicity return the array of fake words.

//==========================================================
// RELEASE 2 IMPLEMENTED CODE

function random_words(num_of_words) {
  
}

//==========================================================
// RELEASE 2 Test Driver Code


//==========================================================
// RELEASE 1 Test Driver Code
// cat1 = {name: 'Tom', age: 7, fav_food: 'mice'}
// cat2 = {name: 'Heathcliff', age: 7, fav_food: 'mice'}
// mouse1 = {name: 'Jerry', age: 3, fav_food: 'cheddar'}
// mouse2 = {name: 'Micky', age: 70, fav_food: 'cheddar'}

// console.log(key_value_match(cat1, cat2))
// console.log(key_value_match(cat1, mouse1))
// console.log(key_value_match(mouse1, mouse2))


//==========================================================
// RELEASE 0 Test Driver Code
// some_words = ['cheese', 'cantaloupe', 'catamaran', 'cirronimbus clouds', 'cat']

//  console.log("The longest word or phrase is '" + find_longest(some_words) + "'.")
