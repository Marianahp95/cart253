void setup(){
  size(500,500);
  background(255);
}

void draw(){
  smooth();
  noStroke();
  fill(#8244AD);
  ellipse(250,250,200,200); //cuerpo
  
  ellipseMode(CORNER); //brazos
  ellipse(300,250,100,10);
  ellipse(100,250,100,10);
  
  ellipseMode(CENTER); //pies
  ellipse(300,350,50,50);
  ellipse(200,350,50,50);
  
  fill(255);
  ellipse(250,250,100,100);//blanco ojo
  fill(#77DEC8);
  ellipse(250,250,50,50);//iris
  fill(0);
  ellipse(250,250,25,25);//pupila
  fill(255);
  ellipse(259,240,18,18);//brillo
  
}