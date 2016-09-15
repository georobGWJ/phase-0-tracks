// DBC Challenge 7.2

var colors = ['blue', 'indigo', 'silver', 'black'];
var horses = ['Pinky', 'Brain', 'Robert', 'Julia'];

colors.push('auburn');
horses.push('Miguel');

var horse_colors = {};


for (counter = 0; counter < colors.length; counter++) {
  horse_colors[horses[counter]] = colors[counter];
}


// Test Driver Code
// console.log(colors);
// console.log(horses);
// console.log(horse_colors)
