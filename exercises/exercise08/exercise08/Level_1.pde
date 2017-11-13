

class Level_1 {

  // A variable to track whether the title screen is finished
  boolean finished = false;

  // The constructor does nothing
  Level_1() {
  }

  // update()
  //
  // Just displays the title

  void update() {
    display();
  }

  // display()
  //
  // Displays the title of the game and the basic instructions
  // to press any key
  void display() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(64);
    fill(255);
    text("PRIMERNIVEL", width/2, height/2);

    textSize(32);
    text("Press any key to continue", width/2, 3*height/4);
  }
  
  // keyPressed()
  //
  // Called by the main program when the title is active.
  // Sets finished to true immediately (since it's any key)

  void keyPressed() {
    finished = true;
  }

  // keyReleased()
  //
  // Does nothing.
  
  void keyReleased() {
  }
}