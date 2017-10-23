//EXERCISE 05

//by MARIANA HERNÁNDEZ 

//declaring variables for the photo that will be drawn and the size of the squares
PImage photo;
float size = 10;
float t = 0;
int x;

void setup() {
  size(1080, 720);
  photo = loadImage("Xochi.jpg"); //loading image
  imageMode(CENTER); //draws the image form the center
  noStroke();
  background(255);
}

void draw() { 
  int x1 = int(random(photo.width)); //chooses a random x value of the photo
  int y1 = int(random(photo.height)); //chooses a random y value of the photo
  color pix = photo.get(x1, y1); //out of the random coordinates we get the color of a specific pixel of the photo
  fill(pix, 128);
  
  rect(x1, y1, size, size);
}