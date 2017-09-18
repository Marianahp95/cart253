void setup(){
  size(500,500);
  background(255);
}

void draw(){
  background(0);
  smooth();
  noStroke();
  fill(#8244AD);
  ellipse(mouseX,mouseY,200,200); //cuerpo
  
  stroke(#8244AD);
  strokeWeight(10);
  //ellipseMode(CORNER); //brazos
  line(mouseX+50,mouseY,pmouseX+150,pmouseY);
  line(mouseX-50,mouseY,pmouseX-150,pmouseY);
  
  ellipseMode(CENTER); //pies
  noStroke();
  ellipse(mouseX+50,mouseY+100,50,50);
  ellipse(mouseX-50,mouseY+100,50,50);
  
  fill(255);
  ellipse(mouseX,mouseY,100,100);//blanco ojo
  fill(mouseX,0,mouseY);
  ellipse(mouseX,mouseY,50,50);//iris
  fill(0);
  ellipse(mouseX,mouseY,25,25);//pupila
  fill(255);
  ellipse(mouseX+9,mouseY-10,18,18);//brillo
  
}

void mousePressed() {
println( "Take me to your leader! ");
background(mouseY,mouseX,0);
}