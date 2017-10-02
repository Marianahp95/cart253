

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
 color bounceColor;//------------------------------CHANGED
 boolean bounceOn = false;
 
//declaring the class and defining the parameters(is that how you say it??) that will indicate position, size, speed and colour   
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor, color tempBounceColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
   bounceColor = tempBounceColor; //------------------------------CHANGED
 }
 
 void update() {
   //diagonal movement of the balls
   x += vx;
   y += vy;
   
   //calling the functions
   handleBounce();
   handleMouse();
   bounceColorChange();
 }
 
 void handleBounce() {
   //the ball bounces when it touches either the left side or the right side of the screen
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx;
    bounceOn = !bounceOn; //------------------------------CHANGED
    x = -x;//teleports to the other side of the screen when it bounces on the left or right side
   }
   
   //the ball bounces when it touches either the top or the bottom of the screen
   if (y - size/2 < 0 || y + size/2 > height) {
     vy = -vy;
     bounceOn = !bounceOn;//------------------------------CHANGED
   }
   
   //contraining to prevent the balls from leaving the screen
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 
 void bounceColorChange(){//------------------------------CHANGED
     if (bounceOn){
       fillColor = bounceColor;  
     }
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