
class Intro {

  // A variable to track whether the title screen is finished
  boolean finished = false;

  // The constructor does nothing
  Intro() {
  }

  void update() { //display the intro
    display();
  }

  void display() {//----------WILL DISPLAY INTRO IN A FUTURE
    background(0);
    textAlign(CENTER, CENTER);
    textSize(64);
    fill(255);
    text("INTROGENIALPASIEMPRE", width/2, height/2);

    textSize(32);
    text("Press any key to continue", width/2, 3*height/4);
  }
  

  void keyPressed() { //ends this state when a key is pressed
    finished = true;
  }

  void keyReleased() {
  }
}