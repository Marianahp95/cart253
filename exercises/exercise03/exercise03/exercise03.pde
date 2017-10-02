//Initializing variable and instances of the class Bouncer 
color backgroundColor = color(200,150,150);
Bouncer bouncer;
Bouncer bouncer2;

void setup() {
  size(640,480);
  background(backgroundColor);
  //2 new and different balls are being created using the class Bouncer
  //-------------------------------------------------------------------CHANGED
  bouncer = new Bouncer(width/2,height/2,2,2,50,color(150,0,0,30),color(255,0,0,30),color(255,67,80,15));
  bouncer2 = new Bouncer(width/2,height/2,-2,2,50,color(0,0,150,30),color(0,0,255,30),color(0,255,49,15));
}

void draw() {
//calling the functions of Bouncer
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
}

//---------------------------------------------------------------CHANGED
void mouseClicked(){
  bouncer.directionChange();
  bouncer2.directionChange();
}