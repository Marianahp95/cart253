
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
  
   PImage[] marvisSpA = new PImage[4];
   int mS = 0;
   
   int rate;
   
   int currentFrame;
  
  Avatar(int _x, int _y, int tempRate) {
    x = _x;
    y = _y;
    
    
    for ( int i = 0; i< marvisSpA.length; i++ ) {
        marvisSpA[i] = loadImage( "sprite_Marvis" + i + ".png" );   
      }
      // Save the rate
      rate = tempRate;
      
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
     
       // Check if this frame is one where we should update the animation
    if (frameCount % rate == 0) {
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % marvisSpA.length;
    }
     
    pushMatrix();
      // Translate to the location (so we rotate the avatar around its centre)
      translate(x, y);
      // Rotate by theta
      rotate(theta);
      
      //Color of the avatar
      pushStyle(); 
        tint(255,redness,redness, 150);
        image(marvisSpA[currentFrame],-25,-22,51,43);
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