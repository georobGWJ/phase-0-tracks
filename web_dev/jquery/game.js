// Declare variables to store number of cards currently flipped and
// the total number of matches

//
var num_flipped = 0;
var total_score = 0;
var face_up_cards = [];
var guesses = [];
var flips = 0; 

$(document).ready(function(){  
    $( "button" ).click(function( event ) {
      if ($(this).hasClass("matched")) {
      } else if ($(this).hasClass("face_down")) {
        $(this).removeClass("face_down");
        $(this).addClass("face_up");
        flips = flips + 1
        guesses.push([$(this).text(), $(this).attr('id')]);
      } else {
        $(this).removeClass("face_up");
        $(this).addClass("face_down");
        flips = flips - 1;
      }
      if (flips % 2 == 0) {
        if (guesses[flips-1][0] == guesses[flips-2][0]) {
          console.log("MATCH!!!")
          $("#" + guesses[flips-1][1]).removeClass("face_up");
          $("#" + guesses[flips-1][1]).addClass("matched");
          $("#" + guesses[flips-2][1]).removeClass("face_up");
          $("#" + guesses[flips-2][1]).addClass("matched");
          total_score++;
        } else {
          $("#" + guesses[flips-1][1]).removeClass("face_up");
          $("#" + guesses[flips-1][1]).addClass("face_down");
          $("#" + guesses[flips-2][1]).removeClass("face_up");
          $("#" + guesses[flips-2][1]).addClass("face_down");
        }

      }
      console.log(guesses[flips-1][0], "   |   ", guesses[flips-2][0]);
      console.log(guesses[flips-1][1], "   |   ", guesses[flips-2][1]);
      console.log(guesses[flips-1][0] == guesses[flips-2][0]);
    });
  });

// while (total_score <=2) {
  // if (flips % 2 == 0) {
  //   if (guesses[flips-1][0] == guesses[flips-2][0]) {
  //     console.log("MATCH!!!")
  //     $(guesses[flips-1][1]).removeClass("face_up");
  //     $(guesses[flips-1][1]).addClass("matched");
  //     $(guesses[flips-2][1]).removeClass("face_up");
  //     $(guesses[flips-2][1]).addClass("matched");
  //     // guesses[0].addClass("matched");
  //     // guesses[1].addClass("matched");
  //     total_score++;
  //   } else {
  //     //
  //   }

  // }
// }

//   if ( num_flipped == 2 ) {
//     $( id1 ).removeClass( "on" );
//     $( id2 ).removeClass( "on" );
//   }


// if (total == 10) {
//   alert( "You win!" );
// }

// while (total <= 10) {
//   flip_turn()
// }

