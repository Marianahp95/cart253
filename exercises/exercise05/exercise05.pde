//EXERCISE 05

//by MARIANA HERNÁNDEZ 

//declaring variables for the photo that will be drawn and the size of the squares
PImage photo;
int size = 10;
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
  //int x1 = int(random(photo.width)); //chooses a random x value in the top left cuadrant of the photo
  //int y1 = int(random(photo.height)); //chooses a random y value in the top left cuadrant of the photo
  
  color pix = photo.get(mouseX, mouseY); //out of the 
  fill(pix, 128);
  
  float n = noise(t);
  //float r = random(0,1);
  ellipse(x,n*width, size, size);
  println(n);
  x++;
  t += 0.01;
  
  rect(mouseX, mouseY, size, size);
}