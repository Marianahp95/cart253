//Declaring the variables 
final int CIRCLE_SPEED = 7; //speed at which the circle will be travelling
//variables for the different colors that will be used
final color NO_CLICK_FILL_COLOR = color(118, 217, 255);
final color CLICK_FILL_COLOR = color(100, 100, 250);
final color BACKGROUND_COLOR = color(250, 150, 150);
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50; //variable for the size of the circle

//Declaring the variables for the position and the velocity of the circle 
int circleX;
int circleY;
int circleVX;
int circleVY;

//MY VARIABLES
int randomR ; //random for red
int randomG ; //random for green
int randomB ; //random for blue
int changingSize = 50; //size of the circle which changes 

void setup() {
  size(640, 480);  
  //setting the starting position of the circle in the middle of the canvas
  circleX = width/2; 
  circleY = height/2;
  //making both velocities the same as the speed (7)
  circleVX = CIRCLE_SPEED; 
  circleVY = CIRCLE_SPEED;
  //setting the colour of the circle and its storke, as well as the background
  stroke(STROKE_COLOR);
  fill(NO_CLICK_FILL_COLOR);
  background(BACKGROUND_COLOR);
  rectMode(CENTER);
}

void draw() {
  //generate random colours
 randomR = int(random(255)); 
 randomG = int(random(255));
 randomB = int(random(255));
 
 
 
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) { //checks whether the distance between the mouse and the circle is less than the size of the circle, in order to determine whether the mouse is on top of it or not
    fill(CLICK_FILL_COLOR); //if it is then the colour of the circle changes to the value stored in the CLICK_FILL_COLOR variable
  }
  else {
    fill(randomR,randomG,randomB);//otherwise the colour stays random
  }
  
  if (mouseX > width/2){ //depending on which side of the screen the mouse is the circle gets smaller or bigger
    changingSize += 1;  //gets bigger
    rect(circleX, circleY, changingSize, changingSize); // the rectangle is drawn using the cooridinates and sizes stated in the variables
  }else{
    changingSize -= 1;  //gets smaller
    ellipse(circleX, circleY, changingSize, changingSize); // the ellipse is drawn using the cooridinates and sizes stated in the variables
  }
  
  
  //ellipse(circleX, circleY, changingSize, changingSize); 
  //With every draw loop the speed is added to the position of the circle (both in X and Y), making it move diagonally
  circleX += circleVX;
  circleY += circleVY;
  if (circleX + changingSize/2 > width || circleX - changingSize/2 < 0) { //checks if the ellipse touches either of the edges in x
    circleVX = -circleVX;//reverses the direction of the circle in x if it does, making the circle bounce back
  }
  if (circleY + changingSize/2 > height || circleY - changingSize/2 < 0) { //checks if the ellipse touches either of the edges in y
    circleVY = -circleVY;//reverses the direction of the circle in y if it does, making the circle bounce back
  }
}

void mousePressed() {
  background(BACKGROUND_COLOR);//if the mouse is pressed the trail of the circle gets erased by the background color 
  
}