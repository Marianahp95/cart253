// Title
//
// A simple class to display the title of the game on the
// screen and listen for a press of any key. When a key is pressed
// it remembers the title is finished and the main program checks
// this in order to advance to the menu.

class Title {

  // A variable to track whether the title screen is finished
  boolean finished = false;
  
  // Variable to make the title fade in
  int fadeInTitle;
  
  PImage titleScreen;
  
  PImage[] MarvisFront_Sp = new PImage[4];
  PImage[] ClueBig = new PImage[4];

  int rate = 10;
  int currentFrame;

  // The constructor does nothing
  Title() {
    titleScreen = loadImage("TitleScreen.png");
     for ( int i = 0; i< MarvisFront_Sp.length; i++ ) { //load the door images into an array to animate it
        MarvisFront_Sp[i] = loadImage( "sprite_MarvisFront" + i + ".png" );   
      }
     for ( int i = 0; i< ClueBig.length; i++ ) { //load the door images into an array to animate it
       ClueBig[i] = loadImage( "sprite_clueBig" + i + ".png" );   
      }
  }

  void update() {
    display();
     
    if (frameCount % rate == 0) { 
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % MarvisFront_Sp.length;
    }
  }

 
  // Displays the title of the game and the basic instructions to press any key
  void display() {
    background(0);
    pushStyle();
      tint(255, fadeInTitle); 
      image(titleScreen,0,0);
      image(MarvisFront_Sp[currentFrame],0,170,540,540);
      image(ClueBig[currentFrame],560,350,300,300);
    popStyle();
    fadeInTitle ++;//fades in the title
  }
  
  
  // Called by the main program when the title is active.
  // Sets finished to true immediately (since it's any key)

  void keyPressed() {
    finished = true;
  }
  
  void keyReleased() {
  }
  
  void reset(){ //NEEDS FIXING
    finished = false;
  }
}