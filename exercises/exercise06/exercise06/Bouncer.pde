// Bouncer
//
// A class that defines a circle that can bounce around on the screen
// at a specific velocity.

class Bouncer {

  // Variables for position
  float x;
  float y;

  // Variables for velocity
  float vx;
  float vy;

  // The size of the Bouncer
  float size;

  // The current fill colour of the Bouncer
  color fillColor;

  // The default fill colour of the Bouncer
  color defaultColor;
  
  //boolean to check id the bouncer has changed
  boolean change;

  // Bouncer(tempX,tempY,tempVX,tempVY,tempSize,tempDefaultColor)
  //
  // Creates a Bouncer with the provided values by remembering them.

  Bouncer(float tempX, float tempY, float tempVX, float tempVY, float tempSize, color tempDefaultColor, boolean tempChange) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    size = tempSize;
    defaultColor = tempDefaultColor;
    fillColor = defaultColor;
    change = tempChange;
  }

  // update()
  //
  // Adds the Bouncer's current velocity to its position
  // and checks for bouncing off the walls.
  void update() {
    x += vx;
    y += vy;

    handleBounce();
  }

  // handleBounce()
  //
  // Checks if the bouncer is overlapping a side of the window
  // and if so reverses its velocity appropriately

  void handleBounce() {
    // Check the left and right
    if (x - size/2 < 0 || x + size/2 > width) {
      // Bounce on the x-axis
      vx = -vx;
    }

    // Check the top and bottom
    if (y - size/2 < 0 || y + size/2 > height) {
      // Bounce on the y-axis
      vy = -vy;
    }

    // Make sure the Bouncer isn't off the edge
    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
  }

  void crash(Bouncer other){ //checks if the location of one bouncer is the same as another bouncer
     if (!change && (x + size/2) > (other.x - size/2) && (x - size/2) < (other.x + size/2) && (y + size/2) > (other.y - size/2) && (y - size/2) < (other.y + size/2)) {
      vx = -vx; //makes them both go the opposite direction 
      vy = -vy;
     }
  }
  
  
  void collide(){//when they come in contact with the brightest pixel they change to a random color
    fillColor = color(random(floor(255)),random(floor(255)),random(floor(255)));
    colCount ++;//one piont is added to the counter
    change = true;//flag that indicates if it came in contact with the brightest pixel
  }

  // display()
  //
  // Draw an ellipse in the Bouncer's location, with its size
  // and with its fill
  void display() {
    noStroke();
    fill(fillColor);
    ellipse(x, y, size, size);
  }
}