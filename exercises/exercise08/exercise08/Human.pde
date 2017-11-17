class Human{
  
float tx = random(0,100);
float ty = random(0,100);

int size = 35;

float x;
float y;
  
  Human() {
    
  }
  
  void display(){
    
  }
  
  void update(){
    x = width * noise(tx);
    y = height * noise(ty);
    ellipse(x,y,size,size);
    tx += 0.006;
    ty += 0.006;
  }
  
  
}