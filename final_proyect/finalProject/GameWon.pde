
class GameWon {

  // A variable to track whether the title screen is finished
  boolean finished = false;
  
  PImage gamewonImg;

PImage[] MarvisGood_Sp = new PImage[4];

int fadeInTitle;
int rate = 10;
int currentFrame;

  // The constructor does nothing
  GameWon() {
    gamewonImg = loadImage("data/GAMEwon.png");
    for ( int i = 0; i< MarvisGood_Sp.length; i++ ) { //load the door images into an array to animate it
        MarvisGood_Sp[i] = loadImage( "sprite_marvisGood" + i + ".png" );   
      }
    
  }

  void update() {
    display();
    if (frameCount % rate == 0) { 
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % MarvisGood_Sp.length;
    }
  }

  void display() { //display the GAME OVER screen 
    background(gamewonImg);
    textAlign(CENTER, CENTER);
    textSize(64);
    fill(255);
    //text("You moved on", width/2, height/2);

    textSize(32);
    //text("Press X to restart", width/2, 3*height/4);
    pushStyle();
      tint(255, fadeInTitle); 
      imageMode(CENTER);
      image(MarvisGood_Sp[currentFrame],width/4,270, 620,620);
     
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