class Human{
  
float tx = random(0,100);
float ty = random(0,100);

int size = 35;
  
  Human() {
    
  }
  
  void display(){
    
  }
  
  void update(){
    float x = width * noise(tx);
    float y = height * noise(ty);
    ellipse(x,y,size,size);
    tx += 0.006;
    ty += 0.006;
  }
  
  void collide(){
    
  }
}