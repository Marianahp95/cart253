//EXERCISE 05

//by MARIANA HERNÁNDEZ 

//declaring variables for the gradient that will be drawn, the size of the squares and the rest of the images
PImage photo;
PImage pine;
PImage skiDude;

float size = 10;
float t = 0;
int x;
int hill = 230; //starting color of the hills
int hillCount; //number of hills drawn

boolean timerRunning = true;//taken from the timer code in the slides
int startTime = 0;
boolean timeUp = false;

//lights variables
float tx = random(0, 100);
float ty = random(0, 100);
float speed = 10;
float posX;
float posY;

float lightOpacity = 20;


void setup() {
  size(1080, 720);
  background(0);
  photo = loadImage("sunset.jpg"); //loading images
  pine = loadImage("pino.png"); 
  skiDude = loadImage("skier.png"); 
  imageMode(CENTER); //draws the image form the center
  noStroke();
}

void draw() { 

  borealis(); //calls the function that draws the color ellipses 
  fill(hill, 200); //the not completely opaque fill of the mountains 
  float n = noise(t); //randomizes the creation of the ellipses using noise, making them "graph"
  ellipseMode(CORNER); //changed the mode to corner so by adding a really big y value the bottom of the screen is filled with the color
  ellipse(x, n*height, 30, 700);//took this code from the class slides, draws the mountains using the noise value t

  if (x > width && hillCount < 1) { //limits the mountains drawn to 2
    x = 0; //the mointain starts being drawn on the left
    hill = hill + 25; //makes the mountain lighter so it'll contrast with the last one
    hillCount++;
  } else {
    x = x+2; //keeps the hill's value of x increasing as long as it's not colliding with the edge
  }

  t += 0.01; //time variable for the noise

  if (timerRunning) { //while the timer is running snow is falling 
    int x1 = int(random(photo.width)); //chooses a random x value of the photo
    int y1 = int(random(photo.height)); //chooses a random y value of the photo

    color pix = photo.get(x1, y1); //out of the random coordinates we get the color of a specific pixel of the photo

    fill(pix, 128);

    ellipse(x1, y1, size, size);//the ellipses get drawn every frame
  }

  if (timeUp) {
    trees(); //creates the trees when the time is up
    timeUp = false;
  }

  if (timerRunning) {
    int timeElapsed = (millis() - startTime)/1000;
    if (timeElapsed == 20) {//checks if the timer is done 
      timerRunning = false;
      timeUp = true;
    }
  }
}

void trees() { //randomly creates trees in the bottom half of the screen 
  for (int i = 0; i < 20; i++) { //for loop to generate the trees 
    int x1 = int(random(width)); //chooses a random x coordinate
    int y1 = int(random(360, 720)); //chooses a random y coordinate
    image(pine, x1, y1, 61, 120);//draws a pine at the random place
  }
}

void borealis() {
  
  float vx = speed * (noise(tx) * 2 - 1); //code taken from the pet slides
  float vy = speed * (noise(ty) * 2 - 1); 
  posX += vx;
  posY += vy;
  fill(random(floor(255)), random(floor(255)), random(floor(255)), lightOpacity); //random transparent colors
  ellipseMode(CENTER);
  ellipse(posX, posY, random(100), random(100)); //the ellipses are drawn with random sizes
  tx += 0.01;
  ty += 0.01;
  lightOpacity = lightOpacity-.001;
  if (posX < 0) { //wraps around the screen 
    posX += width;
    
  } else if (posX > width) {
    posX -= width;
  }
}