
class GameOver {

  // A variable to track whether the title screen is finished
  boolean finished = false;
  PImage gameoverImg;

PImage[] MarvisEvil_Sp = new PImage[2];

int fadeInTitle;
int rate = 10;
int currentFrame;

  // The constructor does nothing
  GameOver() {
    
    gameoverImg = loadImage("data/GAMEOVER.png");
    for ( int i = 0; i< MarvisEvil_Sp.length; i++ ) { //load the door images into an array to animate it
        MarvisEvil_Sp[i] = loadImage( "sprite_evilMarvis" + i + ".png" );   
      }
  }

  void update() {
    display();
    if (frameCount % rate == 0) { 
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % MarvisEvil_Sp.length;
    }
  }

  void display() { //display the GAME OVER screen 
    background(gameoverImg);
    textAlign(CENTER, CENTER);
    textSize(64);
    fill(255);
    //text("GAME OVER", width/2, height/2);

    textSize(32);
    //text("Press X to restart", width/2, 3*height/4);
    pushStyle();
      tint(255, fadeInTitle); 
      imageMode(CENTER);
      image(MarvisEvil_Sp[currentFrame],width/2,height/2,880,682);
     
    popStyle();
    fadeInTitle ++;//fades in the title
  }
  

  void keyPressed() { //key pressed takes us back to the title screen
    if (key == 'x'){
      finished = true;
    }
    
  }

  
  void keyReleased() {
  }
}