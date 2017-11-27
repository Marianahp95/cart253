class Human{
  
  float theta = PI/2;

// The number of pixels the avatar moves per frame
// Default is zero (it's not moving)
float speed = 5;
// The number of radians the avatar turns per frame
// Default is zero (it's not turning)
float turnSpeed = 0;
  
//  //randomizes time for the noise function
//float tx = random(0,100);
//float ty = random(0,100);

float t = 0;

//size of the human
int size = 90;

//variables for the position
float x;
float y;
  
PImage[] human_Sp = new PImage[4];

int rate = 5;
int currentFrame;
  
  Human() {
    for ( int i = 0; i< human_Sp.length; i++ ) { //load the door images into an array to animate it
        human_Sp[i] = loadImage( "sprite_human" + i + ".png" );   
      }
  }
  
  void display(){
    
  }
  
  void update(){ //makes it move organically using noise() (TAKEN FROM CLASS SLIDES)
    //x = width * noise(tx);
    //y = height * noise(ty);
    
    // Set the avatar's rotation based on the current turning speed
    theta = TWO_PI * noise(t);
  
  // Set the avatar's position based on adding the two components
  // of its speed based on its angle, using trigonometry!
    x += cos(theta) * speed;
    y += sin(theta) * speed;
  
    t += 0.05;
    
    if (frameCount % rate == 0) { 
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % human_Sp.length;
    }
    
  pushMatrix();
    // Translate to the location (so we rotate the avatar around its centre)
    translate(x, y);
    // Rotate by theta
    rotate(theta);
    // Draw an ellipse for the body)
    pushStyle();
      imageMode(CENTER);
     image(human_Sp[currentFrame],0,0,size,size);
     popStyle();
    // If you pushMatrix() you gotta popMatrix()
  popMatrix();
  
  //edge wrapping 
   if (x > width){
    x = 0;
   }
   
   if (y > height){
    y = 0;
   }
   
   if (x < 0){
    x = width;
   }
   
   if (y < 0){
    y = height;
   }
   
  }
  
  
}