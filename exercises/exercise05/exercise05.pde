//EXERCISE 05

//by MARIANA HERNÁNDEZ 

//declaring variables for the photo that will be drawn and the size of the squares
PImage photo;
int size = 5;

void setup() {
  size(1080, 720);
  photo = loadImage("Xochi.jpg"); //loading image
  imageMode(CENTER); //draws the image form the center
  noStroke();
  background(255);
}