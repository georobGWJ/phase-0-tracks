// Declare variables to store number of cards currently flipped and
// the total number of matches

//
var matches = 0;
var guesses = [];
var flips = 0; 
var current_score = 0;
var best;
var current;

$(document).ready(function(){  
    $( "button" ).click(function( event ) {
      if ($(this).hasClass("matched")) {
      } else if ($(this).hasClass("face_down")) {
        $(this).removeClass("face_down");
        $(this).addClass("face_up");
        flips = flips + 1;
        guesses.push([$(this).text(), $(this).attr('id')]);
      } else {
        $(this).removeClass("face_up");
        $(this).addClass("face_down");
        flips = flips - 1;
      }
      if (flips % 2 == 0) {
        current_score = current_score + 1;

        if (guesses[flips-1][0] == guesses[flips-2][0]) {
          console.log("MATCH!!!")
          $("#" + guesses[flips-1][1]).removeClass("face_up");
          $("#" + guesses[flips-1][1]).addClass("matched");
          $("#" + guesses[flips-2][1]).removeClass("face_up");
          $("#" + guesses[flips-2][1]).addClass("matched");
          matches++;
        } else {
          $("#" + guesses[flips-1][1]).removeClass("face_up");
          $("#" + guesses[flips-1][1]).addClass("face_down");
          $("#" + guesses[flips-2][1]).removeClass("face_up");
          $("#" + guesses[flips-2][1]).addClass("face_down");
        }
      }
      best = document.getElementById("best");
      current = document.getElementById("current");
      current.innerHTML = current_score.toString();

      if (matches == 8) {
        best = current_score;
        alert("You Win!");
      }
    });
  });

$(document).ready(function(){
    function resetGame() {
      $(".card").removeClass("face_up");
      $(".card").removeClass("matched");
      $(".card").addClass("face_down");
      current_score = 0;
      flips = 0;
      guesses = [];
      current.innerHTML = current_score.toString();
      return;
  }
});

reset_button = document.getElementById("reset_button");
reset_button.addEventListener("click", resetGame);