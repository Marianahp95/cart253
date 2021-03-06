// Awesome Pong <3
// by Mariana Hernández
//
// The player on the right controls his paddle with 'o' & '0' and his enemy territory paddle with 'i' & '9'
// His special key that changes the direction of the ball is 'u'
//The player on the left controls his paddle with 'q' & '1' and his enemy territory paddle with 'w' & '2'
// His special key that changes the direction of the ball is 'e'
// The player on the right gets to use the special key first and the player on the left can' use it until the other one does
// Each player gets to use it 2 times, alternating with each other (so 4 in total)
// If any of the players hit the reverse ball the controls of all the paddles will be reversed until someone hits the ball again

// When a player reaches a score of 5 he/she wins a set, when a player wins 3 sets he/she wins the whole game. 

// Global variables for the paddles and the balls
Paddle leftPaddle;
Paddle rightPaddle;

Paddle leftPaddle2;
Paddle rightPaddle2;

Ball ball;
Ball revBall; //reverse ball


// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 11;
//Second paddle's distance
int PADDLE_INSET_2 = 600;

//scores for each game
int p1_score;
int p2_score;

//sum of games won
int gamePoint_p1;
int gamePoint_p2;

//variables for the background color changes
int red;
int blue;

//positions of the score bars
int barX = 20;
int barY = 6000;

int tSize = 400; //size of the set score

int opacity; //opacity of the winniner phrase
boolean win = false; //indicates whether someone has won

boolean activSP = false;// indicates whether the special key was activated
int spCount; //counts how many times was the special key used 
boolean spOver = false; //indicates if the special key can still be used

// The background colour during play (black)
color backgroundColor;

// indicates if the paddles are reversed
boolean reverse = false;

//number font
PFont font;

// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(900, 480);

  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, '1', 'q');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, '0', 'o');
  
  //creation of the two center paddles
  leftPaddle2 = new Paddle(PADDLE_INSET_2, height/2, '2', 'w'); //i'm giving the player the hability to control the second paddle which is on the enemy's side
  rightPaddle2 = new Paddle(width - PADDLE_INSET_2, height/2, '9', 'i');

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2, 255);
  
  //creating the reversing ball higher than the normal one
  revBall = new Ball(width/2, height-30, 255);
  
  //load the font
  font = createFont("KGLifeisMessy.ttf", 700);
  
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // Fill the background each frame so we have animation
  backgroundColor = color (red, 0, blue );
  background(backgroundColor);
 
  // Update the paddles and ball by calling their update methods
  leftPaddle.update();
  rightPaddle.update();
  
  leftPaddle2.update();
  rightPaddle2.update();
  
  ball.update();
  revBall.updateRev();
  
  ball.checkWin(); //checks if someone won 

  // Check if the ball has collided with either paddle
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);
  
  ball.collide(leftPaddle2);
  ball.collide(rightPaddle2);
  
  revBall.collideRev(leftPaddle);
  revBall.collideRev(rightPaddle);
  
  
  ball.gamePointMark(); //show the bar that indicates the number of sets won 

 // Check if the ball has gone off the right screen
  if (ball.isOffScreenP1()) {
    //add one to the P1 score
    p1_score ++;
    p2_score --;
    
    if (p2_score < 0){
      p2_score = 0;
    }
    //make the backgorund more red to represent the red player winning
    
    if (blue > 0){
      blue = 0;
    }
    
    //blue = blue - 50;
    red = red + 25;
    
    // If it has, reset the ball
    ball.reset();
  }
  

  // Check if the ball has gone off the left side of the screen 
  if (ball.isOffScreenP2()) {
    //add one to the P1 score
    p2_score ++;
    p1_score --;
    
    if (p1_score < 0){
      p1_score = 0;
    }
    
    if (red > 0){
      red = 0;
    }
    
    //make the backgorund more blue to represent the blue player winning
    //red = red - 50;
    blue = blue + 25;
   
  
    // If it has, reset the ball
    ball.reset();
  }
  
 

  // Display the paddles and the ball
  leftPaddle.display();
  rightPaddle.display();
  
  leftPaddle2.display();
  rightPaddle2.display();
  
  ball.display();
  revBall.displayREVERSE();
  
  //the winning message fades in
  if (win){
    opacity ++;
  }
  
}


// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
  
  leftPaddle2.keyPressed();
  rightPaddle2.keyPressed();
  
  //changes the direction of the ball when the special key is activated and it is the players turn to use it and it hasn't been used more than 4 times
  if (key == 'u' && !activSP && !spOver){
    ball.changeDirection();
    
  }
  
  if (key == 'e' && activSP && !spOver){
    ball.changeDirection();
  }
  
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
  
   leftPaddle2.keyReleased();
  rightPaddle2.keyReleased();
}