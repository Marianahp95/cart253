//EXERCISE 05

//by MARIANA HERNÁNDEZ 

//declaring variables for the photo that will be drawn and the size of the squares
PImage photo;
PImage pine;
float size = 15;
float t = 0;
int x;
int hill = 230;
int hillCount;

boolean timerRunning = true;//taken from the timer code in the slides
int startTime = 0;
boolean timeUp = false;


void setup() {
  size(1080, 720);
  background(0);
  photo = loadImage("sunset.jpg"); //loading images
  pine = loadImage("pino.png"); //loading image
  imageMode(CENTER); //draws the image form the center
  noStroke();
}

void draw() { 
  
 fill(hill, 200);
 float n = noise(t); //randomizes the creation of the ellipses using noise, making them "graph"
 ellipseMode(CORNER);
 ellipse(x,n*height,30,700);//took this code from the class slides
  if(x > width && hillCount < 1){
    x = 0;
    hill = hill + 25;
    hillCount++;
    
  }else{
     x = x+2;
  }
  
  t += 0.01;
  
  if (timerRunning){
     int x1 = int(random(photo.width)); //chooses a random x value of the photo
  int y1 = int(random(photo.height)); //chooses a random y value of the photo
  
  color pix = photo.get(x1, y1); //out of the random coordinates we get the color of a specific pixel of the photo
  
  fill(pix, 128);
  ellipse(x1, y1, size, size);//the ellipses get drawn every frame
   
  }
    
 if(timeUp){
    trees();
    timeUp = false;
  }
  
    if (timerRunning) {
    int timeElapsed = (millis() - startTime)/1000;
      if(timeElapsed == 20){
        timerRunning = false;
        timeUp = true;
      }
    println(timeElapsed);
  }
}
  
void trees(){
  for (int i = 0; i < 20; i++) {
      int x1 = int(random(width)); //chooses a random x value of the photo
      int y1 = int(random(360,720)); //chooses a random y value of the photo
      image(pine, x1, y1,61,120);//the ellipses get drawn every frame  
      println(i);
    }
}