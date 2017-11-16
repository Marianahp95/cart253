

class Level_1 {

  Avatar marvis;
  
  Obstacle[] tombs = new Obstacle[20];
  
  // A variable to track whether the title screen is finished
  boolean finished = false;
  
  int startX = width/2;
  int startY = height/2;
  
  Level_1() {
   
    //we create the avatar 
    marvis = new Avatar(startX, startY);
    
    for (int i = 0; i < tombs.length; i++) {
      int x = floor(random(0, width));
      int y = floor(random(0, height));
      tombs[i] = new Obstacle(x, y , 40, 20);
    }
    
  }

  void update() {
    background(0);
    marvis.update();
    marvis.drawAvatar();
    for (int i = 0; i < tombs.length; i++) {
      tombs[i].drawObstacle();
    }
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