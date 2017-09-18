void setup(){
  size(500,500);
  background(255);
}

void draw(){
  background(255);
  smooth();
  noStroke();
  fill(#8244AD);
  ellipse(mouseX,mouseY,200,200); //cuerpo
  
  ellipseMode(CORNER); //brazos
  ellipse(mouseX+50,mouseY,100,10);
  ellipse(mouseX-150,mouseY,100,10);
  
  ellipseMode(CENTER); //pies
  ellipse(mouseX+50,mouseY+100,50,50);
  ellipse(mouseX-50,mouseY+100,50,50);
  
  fill(255);
  ellipse(mouseX,mouseY,100,100);//blanco ojo
  fill(#77DEC8);
  ellipse(mouseX,mouseY,50,50);//iris
  fill(0);
  ellipse(mouseX,mouseY,25,25);//pupila
  fill(255);
  ellipse(mouseX+9,mouseY-10,18,18);//brillo
  
}