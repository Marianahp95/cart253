class Obstacle{

// The current location of the avatar
  float x;
  float y;
  
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
    
    pushStyle();
      fill(255);
      noStroke();
      rect(x,y,sizeX,sizeY);
    popStyle();
  }
  
}