

class Level_1 {

  // A variable to track whether the title screen is finished
  boolean finished = false;

  float theta = PI/2;

// The number of pixels the avatar moves per frame
// Default is zero (it's not moving)
  float speed = 0;
// The number of radians the avatar turns per frame
// Default is zero (it's not turning)
  float turnSpeed = 0;

// The current location of the avatar
  float x = width/2;
  float y = height/2;
  
  int mSize = 35;

  // The constructor does nothing
  Level_1() {
  }

  
  void update() {
    background(0);
    updateAvatar();
    drawAvatar();
  }

  void display() {
    //Marvis' starting position 
    x = width/2;
    y = height/2;
   
  }
  
  void updateAvatar() {
    
    // Set the avatar's rotation based on the current turning speed
    theta += turnSpeed;
    // Set the avatar's position based on adding the two components
    // of its speed based on its angle, using trigonometry!
    x += cos(theta) * speed;
    y += sin(theta) * speed;
    
    x = constrain(x, mSize/2, width - mSize/2);
    y = constrain(y, mSize/2, height - mSize/2);
    
  }

  void drawAvatar() {
    
    pushMatrix();
    // Translate to the location (so we rotate the avatar around its centre)
    translate(x, y);
    // Rotate by theta
    rotate(theta);
    // Draw an ellipse for the body)
    ellipse(0, 0, mSize, mSize);
    // Draw a line so we can see which way it's facing)
    line(0, 0, 25, 0);
    // If you pushMatrix() you gotta popMatrix()
    popMatrix();
    
  }
  

  void keyPressed() {
       if (keyCode == UP) {
      speed = 5;
    } else if (keyCode == LEFT) {
      turnSpeed = -0.1;
    } else if (keyCode == RIGHT) {
      turnSpeed = 0.1;
    }
  }

  
  void keyReleased() {
      if (keyCode == UP) {
      speed = 0;
    } else if (keyCode == LEFT) {
      turnSpeed = 0;
    } else if (keyCode == RIGHT) {
      turnSpeed = 0;
    }
  }
}