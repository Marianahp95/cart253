//EXERCISE 02

//declaring variables for the background color and static
color backgroundColor = color(0);

int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);
int hue; //variable for the hue change-------------------------------------CHANGED

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

//variables for the extra ball -------------------------------------CHANGED
int ball2_X;
int ball2_Y;
int ball2_VX;
int ball2_VY;
int ball2_Speed = 5;
int ball2_Size = 16;
color ball2_Color = color(255,50,50);
boolean reverse = false;

//variables for the hit count -------------------------------------CHANGED

int hitCount;

void setup() {
  size(640, 480); 
  
  //calling the functions
  setupPaddle(); 
  setupBall();
  setupCircle();
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

void setupCircle() { //-------------------------------------CHANGED
    //sets up the second ball
  ball2_X = width/2;
  ball2_Y = height/2;
  ball2_VX = -ball2_Speed;
  ball2_VY = ball2_Speed; 
}

void draw() {
  background(backgroundColor); 

  drawStatic(); //creates the static in the background

  updatePaddle(); //updates the position of the paddle
  updateBall(); //updates the position of the ball

  drawPaddle();
  drawBall();
  drawCircle();//-------------------------------------CHANGED
  updateCircle();
  
  
}

void drawStatic() {
  for (int i = 0; i < numStatic; i++) { //checks wether the "i" is smaller than numStatic and if it is the code below is executed
   //generates random coordinates
   float x = random(0,width); 
   float y = random(0,height);
   // generates random sizes for the rectangles in the background
   float staticSize = random(staticSizeMin,staticSizeMax);
    
    colorMode(HSB);//changed mode to HSB---------------------------------------------CHANGED
    staticColor = color(hue,hue,hue);//made the color of the static dynamic 
   
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
  displayHitCount(); //calls the function to update the score//-------------------------------------CHANGED
}

void updateCircle() { //movement of the red ball //-------------------------------------CHANGED
  
  ball2_X += ball2_VX; //ball movement in x
  ball2_Y += ball2_VY; //ball movement in y
  
 if(reverse){ //color changes depending on wether the controls are reversed or not
   ball2_Color = color (0,0,250); 
 } else {
   ball2_Color = color (250,0,0);
 }
  handleCircleHitPaddle();
  handleBallHitWall();
  
}

void drawPaddle() {
  //draws the shape of the paddle
  colorMode(RGB);
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

void drawBall() {
  //draws the shape of the ball 
  colorMode(RGB);
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

void drawCircle () { //draws second ball //-------------------------------------CHANGED
  colorMode(RGB);
  fill(ball2_Color);
  ellipse(ball2_X, ball2_Y, ball2_Size, ball2_Size);
}

void displayHitCount (){ //displays the score-------------------------------------------------CHANGED
  textSize(480);
  text (hitCount,0,height);
}

void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) { //if the ball makes contact with the paddle then the speed is reversed and it bounces
    ballY = paddleY - paddleHeight/2 - ballSize/2; //avoids the intersection of the ball and the paddle
    ballVY = -ballVY; //reverses speed
    ballSize = ballSize + 20; //ball increases size every time it hits the paddle //-------------------------------------CHANGED
    hitCount ++;//adds one to the score-------------------------------------CHANGED
    hue = hue + 10; //shifts the color of the static
  }
}

//-------------------------------------CHANGED
void handleCircleHitPaddle() { //if the red ball hits the paddle, the key controls reverse and if it hits a second time they go back to normal
  if (ball2_X - ball2_Size/2 > paddleX - paddleWidth/2 && ball2_X + ball2_Size/2 < paddleX + paddleWidth/2 && ball2_Y > paddleY - paddleHeight/2 ) { 
    reverse = !reverse;  
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
    hitCount = 0; //resets the counter when you lose//-------------------------------------CHANGED
    hue = 0; //resets the hue of the static
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


//NEW BALL BOUNCE //-------------------------------------CHANGED
 if (ball2_X - ballSize/2 < 0) { //bounce off the left side
    ball2_X = 0 + ball2_Size/2;
    ball2_VX = -ball2_VX;
    
  } else if (ball2_X + ball2_Size/2 > width) { //bounce off the right side
    ball2_X = width - ball2_Size/2;
    ball2_VX = -ball2_VX;
     
  }
  
  if (ball2_Y - ball2_Size/2 < 0) { //bounce off the top 
    ball2_Y = 0 + ball2_Size/2;
    ball2_VY = -ball2_VY;
    
  } else if (ball2_Y - ball2_Size/2 > height) {
    ball2_Y = height - ball2_Size/2;
    ball2_VY = -ball2_VY;
  }
}


void keyPressed() { //the paddle is moved by the arrows on the keyboard
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
    if (reverse){ //direction of the paddle is reversed //-------------------------------------CHANGED
       paddleVX = paddleSpeed;
    }
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
    if (reverse){ //direction of the paddle is reversed //-------------------------------------CHANGED
       paddleVX = -paddleSpeed;
    }
  }
  
}

void keyReleased() { //the paddle stops moving if the arrows are released //-------------------------------------CHANGED
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
  
  if (keyCode == LEFT && paddleVX > 0 && reverse) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX < 0 && reverse) {
    paddleVX = 0;
  }
}