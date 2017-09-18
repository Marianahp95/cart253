float circleWidth = 1;
float circleHeight = 1;
int circleX = 500;
int circleY = 500;

void setup() {
  size(300, 200);
}

void draw() {
  background(0);
  stroke(255);
  fill(mouseX,mouseY,0);
  //circleSize = (mouseX / 2);
  circleWidth = width/4;
  circleHeight = height/4;
  ellipse(width/2 ,height / 2, circleWidth , circleHeight);
}