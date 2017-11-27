class Human{
  
  //randomizes time for the noise function
float tx = random(0,100);
float ty = random(0,100);

//size of the human
int size = 35;

//variables for the position
float x;
float y;
  
PImage[] human_Sp = new PImage[4];

int rate = 5;
int currentFrame;
  
  Human() {
    for ( int i = 0; i< human_Sp.length; i++ ) { //load the door images into an array to animate it
        human_Sp[i] = loadImage( "sprite_door" + i + ".png" );   
      }
  }
  
  void display(){
    
  }
  
  void update(){ //makes it move organically using noise() (TAKEN FROM CLASS SLIDES)
    x = width * noise(tx);
    y = height * noise(ty);
    
      if (frameCount % rate == 0) { 
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % human_Sp.length;
    }
    
    //draw the ellipse
    image(human_Sp[currentFrame],x,y,size,size);
    
    //makes the values used in noise() change over time
    tx += 0.006;
    ty += 0.006;
    
   
  }
  
  
}