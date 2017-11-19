class Obstacle{

// The location of the obstacles
  float x;
  float y;
  
// The size of the obstacles
  int sizeX;
  int sizeY;
  
  
  Obstacle(int _x, int _y, int _sizeX, int _sizeY) {
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    
  }
  
  void update() {
  
  }
  
  void drawObstacle(){
    
    pushStyle(); //draw the obstacle
      rectMode(CORNER);
      fill(255);
      noStroke();
      rect(x,y,sizeX,sizeY);
    popStyle();
  }
  
}