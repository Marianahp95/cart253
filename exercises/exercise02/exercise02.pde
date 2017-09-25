//EXERCISE 02

//declaring variables for the background color and static
color backgroundColor = color(0);

int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);

//variables for the location, speed, color and size of the paddle
int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);

//variables for the ball's position, color, speed and size
int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
color ballColor = color(255);

void setup() {
  size(640, 480); 
  
  //calling the functions
  setupPaddle(); 
  setupBall();
}

void setupPaddle() { //assigns value to the variables of the paddle 
  paddleX = width/2; // places the paddle's x coordinate in the middle
  paddleY = height - paddleHeight; // places the paddle at the bottom of the screen
  paddleVX = 0; //sets the speed to 0
}

void setupBall() {
  //places the ball in the middle of the screen and initializes the speed
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

void draw() {
  background(backgroundColor); 

  drawStatic(); //creates the static in the background

  updatePaddle(); //updates the position of the paddle
  updateBall(); //updates the position of the ball

  drawPaddle();
  drawBall();
}

void drawStatic() {
  for (int i = 0; i < numStatic; i++) { //checks wether the "i" is smaller than numStatic and if it is the code below is executed
   //generates random coordinates
   float x = random(0,width); 
   float y = random(0,height);
   // generates random sizes for the rectangles in the background
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   //draws the static
   rect(x,y,staticSize,staticSize);
  }
}

void updatePaddle() {
  paddleX += paddleVX;  //movement to the paddle in x
  //limits the movement of the paddle to the width of the screen
  paddleX = constrain(paddleX, paddleWidth/2, width-paddleWidth/2);
}

void updateBall() {
  
  ballX += ballVX; //ball movement in x
  ballY += ballVY; //ball movement in y
  
  //calls functions
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

void drawPaddle() {
  //draws the shape of the paddle
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

void drawBall() {
  //draws the shape of the ball 
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) { //if the ball makes contact with the paddle then the speed is reversed and it bounces
    ballY = paddleY - paddleHeight/2 - ballSize/2; //avoids the intersection of the ball and the paddle
    ballVY = -ballVY; //reverses speed
    ballSize = ballSize + 20; //ball increases size every time it hits the paddle
  }
}

boolean ballOverlapsPaddle() { //checks whether the ball is intersecting th paddle
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}

void handleBallOffBottom() { //reset the ball if it is not caught by the paddle
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
  }
}

boolean ballOffBottom() { //checks if the ball has left the screen's bottom
  return (ballY - ballSize/2 > height);
}

void handleBallHitWall() { //makes the ball bounce off the walls
  if (ballX - ballSize/2 < 0) { //bounce off the left side
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
    ballSize = ballSize - 10; //ball decreases size when it hits the wall
  } else if (ballX + ballSize/2 > width) { //bounce off the right side
    ballX = width - ballSize/2;
    ballVX = -ballVX;
     ballSize = ballSize - 10; //ball decreases size when it hits the wall
  }
  
  if (ballY - ballSize/2 < 0) { //bounce off the top 
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
    ballSize = ballSize - 10; //ball decreases size when it hits the wall
  }
}

void keyPressed() { //the paddle is moved by the arrows on the keyboard
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

void keyReleased() { //the paddle stops moving if the arrows are released
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}