

class Level_1 {

  Avatar marvis; //declare the object variables
  Human human_1;
  
  Obstacle[] tombs = new Obstacle[20];//create an array of obstacles
  
  // A variable to track whether the level is finished
  boolean finished = false;
  
  //starting position of the avatar
  int startX = width/2;
  int startY = height/2;
  
  //number of starting lives
  int lives = 3;
  
  //variable to track the enemy collision
  boolean humanHit = false;
  
  Level_1() {
   
    //we create the avatar 
    marvis = new Avatar(startX, startY);
    
    for (int i = 0; i < tombs.length; i++) {//for loop draws the obstacles 
      int x = floor(random(i, width)); //randomize the positions
      int y = floor(random(i, height));
      //for (int j = 0; j < tombs.length; j++){
      //  int x = (j)*20;
      //  int y = (i)*70;
        tombs[i] = new Obstacle(x, y , 40, 20); //create the obstacles
    }
    
    human_1 = new Human(); //create the human
    
  }

  void update() {//calls the update, draw and collide functions
    
    background(0);
    marvis.update();
    marvis.drawAvatar();
    checkObstColl();
    checkHumanColl();
    human_1.update();
    for (int i = 0; i < tombs.length; i++) {
      tombs[i].drawObstacle();
    }
    text(lives,100,100); //temporary lives display 
  }
  
  void checkObstColl(){ //ghost vs obstacle collision check
    for (int i = 0; i < tombs.length; i++) {
      
      if ( (marvis.x + marvis.mSize/2) > tombs[i].x && (marvis.x - marvis.mSize/2) < tombs[i].x + tombs[i].sizeX && 
      (marvis.y + marvis.mSize/2) > tombs[i].y && (marvis.y - marvis.mSize/2) < tombs[i].y + tombs[i].sizeY){
        
        println("collide");
        marvis.speed = 0; //stops when it hits the obstacles but can pass through them
        
      }else{
        
        println("nope");
      }
    }
  }
  
  void checkHumanColl(){
   
      if ( (marvis.x + marvis.mSize/2) > human_1.x && (marvis.x - marvis.mSize/2) < human_1.x + human_1.size && 
      (marvis.y + marvis.mSize/2) > human_1.y && (marvis.y - marvis.mSize/2) < human_1.y + human_1.size && humanHit == false){
        println("HE CAUGHT YOU");
        humanHit = true;
        marvis.redness = 0;//color changing ------NEEDS FIXING
        looseLife();
      }else{
        marvis.redness = 255;
      }
  }
  
  void looseLife(){ 
    if (lives > 0 ){//checks if there are still lifes left and removes one
      lives = lives - 1; 
    }
    if (lives == 0){ //No lives = game over
        finished = true;
    }
  }
  
  void keyPressed() {
    humanHit = false;//prevents the human from taking more than I life at a time, when the ghost moves the human can take life again
     marvis.keyPressed();
  }

  
  void keyReleased() {
     marvis.keyReleased();
  }
  
  
}