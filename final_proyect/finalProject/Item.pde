class Item{

// The location of the obstacles
  float x;
  float y;
  
// The size of the obstacles
  int sizeX;
  int sizeY;
  
  //color variable 
  color itemCol;
  
  PImage[] clue_Sp = new PImage[4];

  int rate = 5;
  int currentFrame;
  
  
  Item(int _x, int _y, int _sizeX, int _sizeY, color _itemCol) {
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    itemCol = _itemCol;
    
    for ( int i = 0; i< clue_Sp.length; i++ ) { //load the door images into an array to animate it
        clue_Sp[i] = loadImage( "sprite_clue" + i + ".png" );   
      }
    
  }
  
  void update() {
  
  }
  
  void drawItem(){
    
    if (frameCount % rate == 0) { 
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % clue_Sp.length;
    }
    
    pushStyle(); //draw the obstacle
      fill(itemCol);
      noStroke();
      image(clue_Sp[currentFrame],x,y,sizeX,sizeY);
    popStyle();
  }
 
  void pickUp() {
    itemCol = color(#F75A79);
    x = width +30;//moving the picked up clue out of the way
    y = height + 30;
    
  }
}