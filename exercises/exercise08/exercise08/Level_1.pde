

class Level_1 {

  Avatar marvis;
  
  Obstacle[] tombs = new Obstacle[10];
  
  // A variable to track whether the title screen is finished
  boolean finished = false;
  
  int startX = width/2;
  int startY = height/2;
  
  
  
  Level_1() {
   
    //we create the avatar 
    marvis = new Avatar(startX, startY);
    
    for (int i = 0; i < tombs.length; i++) {
      int x = floor(random(i, width));
      int y = floor(random(i, height));
      //for (int j = 0; j < tombs.length; j++){
      //  int x = (j)*20;
      //  int y = (i)*70;
        tombs[i] = new Obstacle(x, y , 40, 20);
    }
    
  }

  void update() {
    background(0);
    marvis.update();
    marvis.drawAvatar();
    checkObstColl();
    for (int i = 0; i < tombs.length; i++) {
      tombs[i].drawObstacle();
    }
    //updateAvatar();
    //drawAvatar();
  }
  
  void checkObstColl(){
    for (int i = 0; i < tombs.length; i++) {
      if ( tombs[i].x <= marvis.x + (marvis.mSize/2) && tombs[i].x + tombs[i].sizeX >= marvis.x - (marvis.mSize/2) && tombs[i].y <= marvis.y + (marvis.mSize/2) && tombs[i].y + tombs[i].sizeY >= marvis.y - (marvis.mSize/2)){
        println("collide");
      }else{
        println("nope");
      }
    }
  }
  
  void keyPressed() {
     marvis.keyPressed();
  }

  
  void keyReleased() {
     marvis.keyReleased();
  }
}