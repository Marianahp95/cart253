// Title
//
// A simple class to display the title of the game on the
// screen and listen for a press of any key. When a key is pressed
// it remembers the title is finished and the main program checks
// this in order to advance to the menu.

class Title {

  // A variable to track whether the title screen is finished
  boolean finished = false;
  
  // Variable to make the title fade in
  int fadeInTitle;

  // The constructor does nothing
  Title() {
  }

  void update() {
    display();
  }

 
  // Displays the title of the game and the basic instructions to press any key
  void display() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(64);
    fadeInTitle ++;//fades in the title
    fill(255,fadeInTitle);
    text("GHOST STORIES", width/2, height/2);

    textSize(32);
    text("Press any key to continue", width/2, 3*height/4);
  }
  
  
  // Called by the main program when the title is active.
  // Sets finished to true immediately (since it's any key)

  void keyPressed() {
    finished = true;
  }
  
  void keyReleased() {
  }
  
  void reset(){ //NEEDS FIXING
    finished = false;
  }
}