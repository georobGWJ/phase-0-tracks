// Declare variables to store number of cards currently flipped and
// the total number of matches

//
var matches = 0;
var guesses = [];
var flips = 0; 
var current_score = 0;
var best;
var best_score = 50;
var current;

// Function to reset game state
window.onload=function() {
    function resetGame() {
      $(".card").removeClass("face_up");
      $(".card").removeClass("matched");
      $(".card").addClass("face_down");
      matches = 0;
      guesses = [];
      flips = 0; 
      current_score = 0;
      current.innerHTML = current_score.toString();
  }
  var reset_button = document.getElementById("reset_button");
  if(reset_button){ reset_button.addEventListener("click", resetGame); }
}

// Function to listen for clicks and execute game logic
// Game state is stored in .css formatting
$(document).ready(function(){  
    $( ".card" ).click(function( event ) {
      if ($(this).hasClass("matched")) {
        // Do nothing if the card has already been matched
      } else if ($(this).hasClass("face_down")) {
        // If the card is face down, flip it and add the value and card
        // id to a guesses array ex. [ ["CHOW", "b9"], ["BEAGLE", "b13"] ]
        $(this).removeClass("face_down");
        $(this).addClass("face_up");
        flips = flips + 1;
        guesses.push([$(this).text(), $(this).attr('id')]);
      } else {
        // If you have a card fliped up you can flip it back down
        $(this).removeClass("face_up");
        $(this).addClass("face_down");
        flips = flips - 1;
      }
      if (flips % 2 == 0) {
        // After every other valid card flip, check to see if the
        // two cards match.
        current_score = current_score + 1;

        if (guesses[flips-1][0] == guesses[flips-2][0]) {
          // For matches, add the matched Class in .css
          $("#" + guesses[flips-1][1]).removeClass("face_up");
          $("#" + guesses[flips-1][1]).addClass("matched");
          $("#" + guesses[flips-2][1]).removeClass("face_up");
          $("#" + guesses[flips-2][1]).addClass("matched");
          matches++;
        } else {
          // Otherwise flip the cards back facedown
          $("#" + guesses[flips-1][1]).removeClass("face_up");
          $("#" + guesses[flips-1][1]).addClass("face_down");
          $("#" + guesses[flips-2][1]).removeClass("face_up");
          $("#" + guesses[flips-2][1]).addClass("face_down");
        }
      }

      current = document.getElementById("current");
      current.innerHTML = current_score.toString();

      if (matches == 8) {
        if (current_score < best_score) {
          best_score = current_score
          best = document.getElementById("best");
          best.innerHTML = best_score.toString();
        }
        alert("You Win!");
      }
    });
  });


