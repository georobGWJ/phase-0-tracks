// Change font styles using JavaScript and DOM Elements
var para = document.getElementsByTagName("p");

para[0].style.fontFamily = "Helvetica";

para[0].style.fontSize = "40px"

// Add Event Listener using JavaScript and DOM Elements
var lizard = document.getElementById("lizard-photo")

function addBorder() { 
  var lizard = document.getElementById("lizard-photo");
  lizard.style.border = "2px solid green"; 
}

lizard.addEventListener("mouseover", addBorder)
