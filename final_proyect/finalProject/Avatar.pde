
class Avatar{
  // GHOST AVATAR CLASS -- MOVEMENT TAKEN FROM CLASS EXAMPLES 
  
//The avatar's rotation
  float theta = PI/2;
// The number of pixels the avatar moves per frame
  float speed = 0;
// The number of radians the avatar turns per frame
  float turnSpeed = 0;

// The current location of the avatar
  float x = width/2;
  float y = height/2;
  
  int mSize = 35; //size of the avatar
  
  int redness = 255; //variable that controls the redness of the avatar as it becomes more evil
  
  PImage marvisSp;
  
  Avatar(int _x, int _y, PImage _marvisSp) {
    x = _x;
    y = _y;
    marvisSp = _marvisSp;
  }
  
   void update() {
     // Set the avatar's rotation based on the current turning speed
    theta += turnSpeed;
    // Set the avatar's position based on adding the two components
    // of its speed based on its angle, using trigonometry!
    x += cos(theta) * speed;
    y += sin(theta) * speed;
    
    //contsrain the position so the avatar can't leave the screen 
    x = constrain(x, mSize/2, width - mSize/2);
    y = constrain(y, mSize/2, height - mSize/2);
   }
   
   void drawAvatar(){
     
    pushMatrix();
      // Translate to the location (so we rotate the avatar around its centre)
      translate(x, y);
      // Rotate by theta
      rotate(theta);
      
      //Color of the avatar
      pushStyle(); 
        fill(255,redness,redness);
        // Draw an ellipse for the body)
        image(marvisSp,-25,-22,51,43);
        //ellipse(0, 0, mSize, mSize);
        // Draw a line so we can see which way it's facing)
        //line(0, 0, 25, 0);
      popStyle();
    popMatrix();
    
   }
  
  void reset() { //avatar reset function
    x = width/2;
    y = height/2;
  }
  
 
  
  void keyPressed(){
    if (keyCode == UP) { //when the UP key is pressed the avatar starts moving forward (depending on it's direction)
        speed = 5;
      } else if (keyCode == LEFT) { //with the LEFT and RIGHT keys the avatar rotates
        turnSpeed = -0.1;
      } else if (keyCode == RIGHT) {
        turnSpeed = 0.1;
      }
  }
  
  void keyReleased(){ //key released stops the movement 
     if (keyCode == UP) {
      speed = 0;
    } else if (keyCode == LEFT) {
      turnSpeed = 0;
    } else if (keyCode == RIGHT) {
      turnSpeed = 0;
    }
  }
}