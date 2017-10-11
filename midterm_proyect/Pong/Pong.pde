// Pong
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// No scoring. (Yet!) CHECK!
// No score display. (Yet!)
// Pretty ugly. (Now!)
// Only two paddles. (So far!)

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;


// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

int p1_score;
int p2_score;

int red;
int blue;

// The background colour during play (black)
color backgroundColor;


// setup()
//
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

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
  
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
  ball.update();

  // Check if the ball has collided with either paddle
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);

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
    red = red + 50;
    
    println("p1 " + p1_score);
    println("p2 " + p2_score);

    
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
    blue = blue + 50;
    
    
    println("p1 " + p1_score);
    println("p2 " + p2_score);
  
    // If it has, reset the ball
    ball.reset();
  }
  
 

  // Display the paddles and the ball
  leftPaddle.display();
  rightPaddle.display();
  ball.display();
  
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
  
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}