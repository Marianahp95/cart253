// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 5; 
  int SIZE = 16;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // The colour of the ball
  color ballColor;


  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties

  Ball(int _x, int _y, color _ballCol) {
    x = _x;
    y = _y;
    ballColor = _ballCol;
    vx = SPEED;
    vy = SPEED;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
  }
  
  void updateRev() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
    
    if (x - SIZE/2 < 0 || x + SIZE/2 > width){
      vx = -vx;
    }
    
    if (reverse){
         //ACTIVATE REVERSE MODE
          reverse = true;
          println("REVRESEEE");
      }
  }
  
  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity
  
  void reset() {
    x = width/2;
    y = height/2;
    vx = -vx; //everytime the ball is reset the direction gets inverted
    vy = -vy; 
  }
  
  void stopBall() { //stops the movement of the ball
    reset();
    vx = 0;
    vy = 0; 
  }
  
  void changeDirection(){
    vx = -vx; //the direction gets inverted when a player activates their special key
    vy = -vy;
    activSP = !activSP; //indicates who's turn it is tu use the special key
    spCount ++; //adds to the count of special key uses
    if (spCount >= 4){ //blocks the special keys after 4 uses
      spOver = true; 
    }
  }
  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window
  // otherwise false
  // (If we wanted to return WHICH side it had gone off, we'd have to return
  // something like an int (e.g. 0 = not off, 1 = off left, 2 = off right)
  // or a String (e.g. "ON SCREEN", "OFF LEFT", "OFF RIGHT")
  
  boolean isOffScreenP1() {
    return (x + SIZE/2 < 0);
  }
  
  boolean isOffScreenP2() {
    return (x - SIZE/2 > width);
  }


//CHECK WINNER
  void checkWin (){
    if (p1_score == 5){
      println("GANO ROJO");
      gamePoint_p1 ++; //adds one gamepoint
      p1_score= 0; //resets the score and color of the background
      p2_score= 0;
      red = 0;
      blue = 0;
    }
    if (p2_score == 5){
      println("GANO AZUL");
      gamePoint_p2 ++; //adds one gamepoint
      p1_score= 0;//resets the score and color of the background
      p2_score= 0;
      red = 0;
      blue = 0;
    }
    
    if (gamePoint_p1 == 3){ //when the red player reaches 3 game points he wins
      println("ROJO CAMPEON");
      textSize(100);
      fill(#D8344A, opacity);
      text("Roses are red", width/2, height/4);
      stopBall();
      win = true;
    }
    
    if (gamePoint_p2 == 3){//when the blue player reaches 3 game points he wins
      println("AZUL CAMPEON");
      textSize(100);
      fill(#50B1FF, opacity);
      text("Violets are blue", width/2, height/4);
      stopBall();
      win = true;
    }
  }
  
  void gamePointMark(){
    if (gamePoint_p1 == 1){ //displays 1 bar to represent match won by red
      fill(255, 50);
      noStroke();
      rectMode(CENTER);
      rect(width - 100, 0, barX, barY);
    } 
    
    if (gamePoint_p1 == 2){ //displays 2 bars to represent 2 matches won by red
      fill(255, 50);
      noStroke();
      rect(width - 100, 0, barX, barY);
      rect(width - 200, 0, barX, barY);
    } 
    
    if (gamePoint_p2 == 1){ //displays 1 bar to represent match won by blue
      fill(255, 50);
      noStroke();
      ellipse(100, 0, barX, barY);
    } 
    
    if (gamePoint_p2 == 2){ //displays 2 bars to represent 2 matches won by blue
      fill(255, 50);
      noStroke();
      ellipse(100, 0 , barX, barY);
      ellipse(200, 0, barX, barY);
    } 
    
     
    
  }

  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);
    
    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      
      // And make it bounce
      vx = -vx;
    }
  }
  
  void collideRev(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);
    
    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      
      //REVERSE MODE
      reverse = !reverse;
      println("reverseee");
      // And make it bounce
      vx = -vx;
    }
  }
  

  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
    noStroke();
    
    fill(ballColor);
    rectMode(CENTER);
    
    textFont(font);
    
    //set scores 
    fill(255,red);
     textSize(tSize);
     textAlign(CENTER, CENTER);
      text(p1_score,width/2, height/2 - 50);
      
      fill(255,blue);
      textAlign(CENTER, CENTER);
      text(p2_score,width/2, height/2 - 50);

    fill(255);
    
    //if(!activSP && !spOver){ //changes colors to indicate who can use the special key and if they can do it ///////CHECAAAAA
    //  ballColor = color(#D8344A);
    //}
    
    //if(activSP && !spOver){
    //  ballColor = color(#50B1FF);
    //}
    // Draw the ball
    rect(x, y, SIZE, SIZE);
  }
  
  void displayREVERSE(){
    if (reverse){
     fill(#FFB846);
    }else{
     fill(#9B46FF); 
    }
    ellipse(x, y, SIZE, SIZE);
  }
}