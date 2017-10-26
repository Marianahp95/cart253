//EXERCISE 05

//by MARIANA HERNÁNDEZ 

//declaring variables for the photo that will be drawn and the size of the squares
PImage photo;
float size = 10;
float t = 0;
int x;
int hill = 255;

void setup() {
  size(1080, 720);
  background(0);
  photo = loadImage("sunset.jpg"); //loading image
  imageMode(CENTER); //draws the image form the center
  noStroke();
  
}

void draw() { 
  int x1 = int(random(photo.width)); //chooses a random x value of the photo
  int y1 = int(random(photo.height)); //chooses a random y value of the photo
  color pix = photo.get(x1, y1); //out of the random coordinates we get the color of a specific pixel of the photo
  fill(pix, 128);
  rect(x1, y1, size, size);//the rectangles get drawn every frame
  
  float r = random(0,1);//randomizes the creation of the ellipses
  ellipse(x,r*height,5,5);//took this code from the class slides
 println(hill);
 
 fill(hill);
 float n = noise(t); //randomizes the creation of the ellipses using noise, making them "graph"
 ellipse(x,n*height,9,30);//took this code from the class slides
  if(x > width){
    x = 0;
    hill = hill - 20;
  }else{
     x = x+2;
  }
  
  t += 0.01;
  
}