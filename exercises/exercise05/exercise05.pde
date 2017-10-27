//EXERCISE 05

//by MARIANA HERNÁNDEZ 

//declaring variables for the photo that will be drawn and the size of the squares
PImage photo;
float size = 15;
float t = 0;
int x;
int hill = 255;
int hillCount;

boolean timerRunning = false;//taken from the timer code in the slides
int startTime = 0;


void setup() {
  size(1080, 720);
  background(0);
  photo = loadImage("sunset.jpg"); //loading image
  imageMode(CENTER); //draws the image form the center
  noStroke();
  surface.setResizable(true);
}

void draw() { 
 
  int x1 = int(random(photo.width)); //chooses a random x value of the photo
  int y1 = int(random(photo.height)); //chooses a random y value of the photo
  
  color pix = photo.get(x1, y1); //out of the random coordinates we get the color of a specific pixel of the photo
  
  fill(pix, 128);
  ellipse(x1, y1, size, size);//the ellipses get drawn every frame
  
  
  //float r = random(0,1);//randomizes the creation of the ellipses
  //ellipse(x,r*height,5,5);//took this code from the class slides
  
 fill(hill);
 float n = noise(t); //randomizes the creation of the ellipses using noise, making them "graph"
 ellipseMode(CORNER);
 ellipse(x,n*height,30,700);//took this code from the class slides
  if(x > width && hillCount < 2){
    x = 0;
    hill = hill - 25;
    hillCount++;
    
  }else{
     x = x+2;
  }
  
  t += 0.01;
  
  if (hillCount == 2){
    
  }
  
    if (timerRunning) {
    int timeElapsed = (millis() - startTime)/1000;
    println(timeElapsed);
  }
}
  

void keyPressed() {
  if (key == 's') {
    startTime = millis();
    timerRunning = true;
  } else if (key == 'x') {
    timerRunning = false;
  }
}