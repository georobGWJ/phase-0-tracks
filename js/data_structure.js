// DBC Challenge 7.2

var colors = ['blue', 'indigo', 'silver', 'black'];
var horses = ['Pinky', 'Brain', 'Robert', 'Julia'];

colors.push('auburn');
horses.push('Miguel');

var horse_colors = {};


for (counter = 0; counter < colors.length; counter++) {
  horse_colors[horses[counter]] = colors[counter];
}

function Car(color, size, type) {
  console.log('Our new car:', this);

  this.color = color;
  this.size = size;
  this.type = type;

  this.speed = function(mph) {
    console.log('This car is going ' + mph + ' miles per hour.');
  }
}

var sedan = new Car('red', 'big', '4-door');
console.log(sedan);
sedan.speed(55);
console.log('------')

var truck = new Car('black', 'compact', 'pick-up');
console.log(truck);
truck.speed(40);

// Test Driver Code
// console.log(colors);
// console.log(horses);
// console.log(horse_colors)
