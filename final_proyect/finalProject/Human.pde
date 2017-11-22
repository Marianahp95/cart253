class Human{
  
  //randomizes time for the noise function
float tx = random(0,100);
float ty = random(0,100);

//size of the human
int size = 35;

//variables for the position
float x;
float y;
  
  Human() {
    
  }
  
  void display(){
    
  }
  
  void update(){ //makes it move organically using noise() (TAKEN FROM CLASS SLIDES)
    x = width * noise(tx);
    y = height * noise(ty);
    
    //draw the ellipse
    ellipse(x,y,size,size);
    
    //makes the values used in noise() change over time
    tx += 0.006;
    ty += 0.006;
  }
  
  
}