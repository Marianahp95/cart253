class Obstacle{

// The location of the obstacles
  float x;
  float y;
  
// The size of the obstacles
  int sizeX;
  int sizeY;
  
  PImage graveSp;
  
  Obstacle(int _x, int _y, int _sizeX, int _sizeY, PImage _graveSp) {
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    graveSp = _graveSp;
    
  }
  
  
  void drawObstacle(){
    
    pushStyle(); //draw the obstacle
      //rectMode(CORNER);
      //fill(255);
      //noStroke();
      image(graveSp,x,y, sizeX,sizeY); 
      //rect(x,y,sizeX,sizeY);
    popStyle();
  }
  
}