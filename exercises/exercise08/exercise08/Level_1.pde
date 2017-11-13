

class Level_1 {

  Avatar marvis;
  
  // A variable to track whether the title screen is finished
  boolean finished = false;
  
  int startX = width/2;
  int startY = height/2;
  

  // The constructor does nothing
  Level_1() {
    marvis = new Avatar(startX, startY);
  }

  void update() {
    background(0);
    marvis.update();
    marvis.drawAvatar();
    //updateAvatar();
    //drawAvatar();
  }
  
  void keyPressed() {
     marvis.keyPressed();
  }

  
  void keyReleased() {
     marvis.keyReleased();
  }
}