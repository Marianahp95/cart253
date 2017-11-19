class Item{

// The location of the obstacles
  float x;
  float y;
  
// The size of the obstacles
  int sizeX;
  int sizeY;
  
  //color variable 
  color itemCol;
  
  Item(int _x, int _y, int _sizeX, int _sizeY, color _itemCol) {
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    itemCol = _itemCol;
    
  }
  
  void update() {
  
  }
  
  void drawItem(){
    
    pushStyle(); //draw the obstacle
      fill(itemCol);
      noStroke();
      ellipse(x,y,sizeX,sizeY);
    popStyle();
  }
 
  void pickUp() {
    itemCol = color(#F75A79);
    fill(itemCol);
  }
}