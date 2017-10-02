

class Bouncer {
  
  //Variables for position, size, speed and colour
 int x;
 int y;
 int vx;
 int vy;
 int size;
 color fillColor;
 color defaultColor;
 color hoverColor;
 
//declaring the class and defining the parameters(is that how you say it??) that will indicate position, size, speed and colour   
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
 }
 
 void update() {
   //diagonal movement of the balls
   x += vx;
   y += vy;
   
   //calling the functions
   handleBounce();
   handleMouse();
 }
 
 void handleBounce() {
   //the ball bounces when it touches either the left side or the right side of the screen
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx; 
   }
   
   //the ball bounces when it touches either the top or the bottom of the screen
   if (y - size/2 < 0 || y + size/2 > height) {
     vy = -vy;
   }
   
   //contraining to prevent the balls from leaving the screen
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 
 void handleMouse() {
   // the color changes when the mouse hovers over the ball and reverts to normal when the mouse isn't on top of it
   if (dist(mouseX,mouseY,x,y) < size/2) {
    fillColor = hoverColor; 
   }
   else {
     fillColor = defaultColor;
   }
 }
 
 void draw() {
   //the ellipse is drawn in every frame with the draw loop
   noStroke();
   fill(fillColor);
   ellipse(x,y,size,size);
 }
}