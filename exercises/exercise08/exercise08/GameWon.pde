
class GameWon {

  // A variable to track whether the title screen is finished
  boolean finished = false;

  // The constructor does nothing
  GameWon() {
  }

  void update() {
    display();
  }

  void display() { //display the GAME OVER screen 
    background(0);
    textAlign(CENTER, CENTER);
    textSize(64);
    fill(255);
    text("You moved on", width/2, height/2);

    textSize(32);
    text("Press any key to continue", width/2, 3*height/4);
  }
  

  void keyPressed() { //key pressed takes us back to the title screen
    finished = true;
  }

  
  void keyReleased() {
  }
}