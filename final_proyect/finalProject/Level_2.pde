

class Level_2 {

  Avatar marvis; //declare the object variables
  Human[] human = new Human[2];

  Obstacle[] tombs = new Obstacle[30];//create an array of obstacles
  Item[] clues = new Item[4];//create an array of items

  // A variable to track whether the level is finished
  boolean finished = false;

  boolean won = false;

  boolean doorOpen = false;

  //starting position of the avatar
  int startX = width/2;
  int startY = height/2;

  //number of starting lives
  int lives = 3;

  //clue index
  int clueId;

  //size of the door
  int doorSizeX = 60;
  int doorSizeY = 60;

  //random door position
  float doorX = random(floor(width - doorSizeX)); //random position of the door
  float doorY = random(floor(height - doorSizeY));

  //variable to track the enemy collision
  boolean humanHit = false;

  //var to keep track of the clue pausing
  boolean paused = false;
  
  //var to keep track of the brightsest pixel activation
  boolean extraLifeOn = true;


  //var to store the location of the brightest pixel
  PVector brightestPixel = new PVector(-1, -1);

  //image variables
  PImage fondo;

  PImage grave;
  PImage[] door_Sp = new PImage[4];
  PImage[] heart = new PImage[5];
  
  PImage [] clue_sp = new PImage[4];
  
   int rate = 5;
   int currentFrame;
  
   PFont font;

  Level_2() {
    
    //load font
    font = createFont("8bitOperatorPlus8-Regular.ttf", 700);
    
 //LOAD ALL IMAGES
 
     grave = loadImage("data/Grave_2.png");
     fondo = loadImage("fondoMarvis_2.png");
     for ( int i = 0; i< door_Sp.length; i++ ) { //load the door images into an array to animate it
        door_Sp[i] = loadImage( "sprite_door" + i + ".png" );   
      }
      
     for ( int i = 0; i< heart.length; i++ ) { //load the door images into an array to animate it
        heart[i] = loadImage( "sprite_Heart" + i + ".png" );   
      }
      
      for ( int i = 0; i< clue_sp.length; i++ ) { //load the clue images into an array 
        clue_sp[i] = loadImage( "sprite_clues_Sp_2" + i + ".png" );   
      }
    
    //we create the avatar 
    marvis = new Avatar(startX, startY, 5);

    for (int i = 0; i < tombs.length; i++) {//for loop draws the obstacles 
      int x = floor(random(0, width)); //randomize the positions
      //int y = floor(random(0, height));
      int y = i*38;
      //for (int j = 0; j < tombs.length; j++){
      //  int x = (j)*20;
      //  int y = (i)*70;
      tombs[i] = new Obstacle(x, y, 75, 69, grave); //create the obstacles
    }

    for (int i = 0; i < clues.length; i++) {//for loop draws the items 
      int x = floor(random( width - 20)); //randomize the positions
      int y = floor(random( height - 20));
      clues[i] = new Item(x, y, 30, 30, color(#5AF3F7)); //create the items
    }

    for (int i = 0; i < human.length; i++) {//for loop draws the human 
      human[i] = new Human(floor(random(width)), floor(random(height)), .05); //create the humans
    }
    
    
  
  }

  void update() {//calls the update, draw and collide functions

   background(fondo);//background with an image
   
    //webcam
    handleVideoInput();
    pushStyle();
      tint(0, 153, 204, 50);
      imageMode(CENTER);
      //image(video, width/2, height/2);
    popStyle();  
      brightestPixelDisplay();

    if (!paused) { //if the game isn't paused by the clues run everything normally

      for (int i = 0; i < tombs.length; i++) { //Draw the tombs
        tombs[i].drawObstacle();
      }
      
      marvis.update();
      checkObstColl();
      checkHumanColl();
      collectItem();
      
      for (int i = 0; i < human.length; i++) { //Draw the tombs
        human[i].update();
      } 
      doorCheck();
      marvis.drawAvatar();
     

      for (int i = 0; i < clues.length; i++) { //Draw the clues
        clues[i].drawItem();
      }

      //text(lives + " " + clueId, 100, 100); //temporary lives display 

      //door animation
      // Check if this frame is one where we should update the animation
    if (frameCount % rate == 0) {
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % door_Sp.length;
    }

      if (clueId == 4) { //if the player has collected all 4 clues the door opens
        doorOpen = true;
        pushStyle();
          fill(#98F75A);
          image(door_Sp[currentFrame],doorX, doorY, doorSizeX, doorSizeY);
        popStyle();
      }
    } else {
      displayClues();
    }

    
  }

  void handleVideoInput() {
    // Check if there's a frame to look at
    if (!video.available()) {
      // If not, then just return, nothing to do
      return;
    }
    // If we're here, there IS a frame to look at so read it in
    video.read();
    
    // Start with a very low "record" for the brightest pixel
  // so that we'll definitely find something better
  float brightnessRecord = 0;
  // loadPixels();

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * video.width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // Get the brightness of the pixel we're looking at
      float pixelBrightness = brightness(pixelColor);
      // Check if this pixel is the brighest we've seen so far
      if (pixelBrightness > brightnessRecord) {
        // If it is, change the record value
        brightnessRecord = pixelBrightness;
        // Remember where this pixel is in the the grid of pixels
        // (and therefore on the screen) by setting the PVector
        // brightestPixel's x and y properties.
        brightestPixel.x = x;
        brightestPixel.y = y;
      }
    }
  }
 }


  void brightestPixelDisplay(){
    
    if (extraLifeOn){
     pushStyle();
      //fill(random(floor(255)), random(floor(255)), random(floor(255)));
      //ellipse(brightestPixel.x, brightestPixel.y, 20, 20);
      image(heart[currentFrame], brightestPixel.x, brightestPixel.y, 30,30);
     popStyle();
      //marvis.redness = marvis.redness + 100;//color changing 
    }
   
  }

  void checkObstColl() { //ghost vs obstacle collision check
    for (int i = 0; i < tombs.length; i++) {

      if ( (marvis.x + marvis.mSize/2) > tombs[i].x && (marvis.x - marvis.mSize/2) < tombs[i].x + tombs[i].sizeX && 
        (marvis.y + marvis.mSize/2) > tombs[i].y && (marvis.y - marvis.mSize/2) < tombs[i].y + tombs[i].sizeY) {

        println("collide");
        marvis.speed = 1; //stops when it hits the obstacles but can pass through them
      }
    }
  }

  void checkHumanColl() {
    
  for (int i = 0; i < human.length; i++) {
    if ( (marvis.x + marvis.mSize/2) > human[i].x && (marvis.x - marvis.mSize/2) < human[i].x + human[i].size && 
      (marvis.y + marvis.mSize/2) > human[i].y && (marvis.y - marvis.mSize/2) < human[i].y + human[i].size && humanHit == false) {
      println("HE CAUGHT YOU");
      humanHit = true;
      marvis.redness = marvis.redness - 100;//color changing 
      looseLife.play();
      looseLife();
    }  
   }
  }

  void collectItem() {
    for (int i = 0; i < clues.length; i++) {

      if ( (marvis.x + marvis.mSize/2) > clues[i].x && (marvis.x - marvis.mSize/2) < clues[i].x + clues[i].sizeX && 
        (marvis.y + marvis.mSize/2) > clues[i].y && (marvis.y - marvis.mSize/2) < clues[i].y + clues[i].sizeY) {

        println("PICKUP");
        clues[i].pickUp();
        clueId ++;
        collectOrb_sound.play();
        paused = true;
      }
    }
    
    //brightest pixel collision
    if ( (marvis.x + marvis.mSize/2) > brightestPixel.x - 10 && (marvis.x - marvis.mSize/2) < brightestPixel.x + 10 && 
        (marvis.y + marvis.mSize/2) > brightestPixel.y - 10 && (marvis.y - marvis.mSize/2) < brightestPixel.y + 10 && extraLifeOn)  {
          extraLifeOn = false;
          lives = lives +1;
          marvis.redness = marvis.redness + 100;
     }
  }

  void displayClues() {

    pushStyle();
    textFont(font);
    fill(255, 0, 0);
    textSize(70);
    imageMode(CENTER);
    
    if (clueId == 1 ) {
      collectOrb_sound.play();
     String s = "I think that’s my father’s… looks like he was a solider.";
        background(0);
       image(clue_sp[clueId-1],width/2, height/2.5);
       fill(255);
       textSize(35);
       text(s, 80 , height-150, 920,80);
        fill(255, 0, 0);
        textSize(25);
        text("Press  X  to  continue", width/2 , height-30);
    }

    if (clueId == 2 ) {
      collectOrb_sound.play();
      String s = "My mother left these flowers by my grave, they’re still fresh…";
        background(0);
       image(clue_sp[clueId-1],width/2, height/2.5);
       fill(255);
       textSize(35);
       text(s, 80 , height-150, 920,80);
        fill(255, 0, 0);
        textSize(25);
        text("Press  X  to  continue", width/2 , height-30);
    }

    if (clueId == 3 ) {
      collectOrb_sound.play();
      String s = "My kite! I used to play with this everyday.";
        background(0);
       image(clue_sp[clueId-1],width/2, height/2.5);
       fill(255);
       textSize(35);
       text(s, 80 , height-150, 920,80);
        fill(255, 0, 0);
        textSize(25);
        text("Press  X  to  continue", width/2 , height-30);
    }
    
    if (clueId == 4 ) {
      collectOrb_sound.play();
     String s = "His dog tag… I remember now, we received this after he died.";
        background(0);
       image(clue_sp[clueId-1],width/2, height/2.5);
       fill(255);
       textSize(35);
       text(s, 80 , height-150, 920,80);
        fill(255, 0, 0);
        textSize(25);
        text("Press  X  to  continue", width/2 , height-30);
    }
    
    
    popStyle();
  }

  void reset() {//we reset the variables so that the game can be played again
    finished = false;
    won = false;
    doorOpen = false;
    lives = 3;
    clueId = 0;
    marvis.redness = 255;
    marvis.speed = 0;
    marvis.x = width/2;
    marvis.y = height/2;
    extraLifeOn = true;

    //draw the clues again
    for (int i = 0; i < clues.length; i++) {//for loop draws the items 
      int x = floor(random( width)); //randomize the positions
      int y = floor(random( height));
      clues[i] = new Item(x, y, 30, 30, color(#5AF3F7)); //create the items
    }
  }

  void looseLife() { 
    if (lives > 0 ) {//checks if there are still lifes left and removes one
      lives = lives - 1;
      looseLife.play();
    }
    if (lives == 0) { //No lives = game over
      finished = true;
    }
  }

  void doorCheck() { //CHecks if the ghost has reached the door
    if ( (marvis.x + marvis.mSize/2) > doorX && (marvis.x - marvis.mSize/2) < doorX +  doorSizeX && 
      (marvis.y + marvis.mSize/2) > doorY && (marvis.y - marvis.mSize/2) < doorY + doorSizeY && doorOpen == true) {
      won = true;
    }
  }

  void keyPressed() {
    humanHit = false;//prevents the human from taking more than 1 life at a time, when the ghost moves the human can take life again
    marvis.keyPressed();
    if (key == 'x') {
      paused = false;
    }
  }


  void keyReleased() {
    marvis.keyReleased();
  }
}