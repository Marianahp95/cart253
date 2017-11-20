

class Level_1 {

  Avatar marvis; //declare the object variables
  Human human_1;

  Obstacle[] tombs = new Obstacle[30];//create an array of obstacles
  Item[] clues = new Item[3];//create an array of items

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
  int doorSizeX = 40;
  int doorSizeY = 60;

  //random door position
  float doorX = random(floor(width - doorSizeX)); //random position of the door
  float doorY = random(floor(height - doorSizeY));

  //variable to track the enemy collision
  boolean humanHit = false;

  //var to keep track of the clue pausing
  boolean paused = false;

  //var to store the location of the brightest pixel
  PVector brightestPixel = new PVector(-1, -1);


  Level_1() {

    //we create the avatar 
    marvis = new Avatar(startX, startY);

    for (int i = 0; i < tombs.length; i++) {//for loop draws the obstacles 
      int x = floor(random(0, width)); //randomize the positions
      //int y = floor(random(0, height));
      int y = i*38;
      //for (int j = 0; j < tombs.length; j++){
      //  int x = (j)*20;
      //  int y = (i)*70;
      tombs[i] = new Obstacle(x, y, 40, 20); //create the obstacles
    }

    for (int i = 0; i < clues.length; i++) {//for loop draws the items 
      int x = floor(random( width)); //randomize the positions
      int y = floor(random( height));
      clues[i] = new Item(x, y, 20, 20, color(#5AF3F7)); //create the items
    }


    human_1 = new Human(); //create the human
  }

  void update() {//calls the update, draw and collide functions

   background(0);
   
    //webcam
    handleVideoInput();
    pushStyle();
      tint(0, 153, 204, 50);
      imageMode(CENTER);
      image(video, width/2, height/2);
    popStyle();  
      brightestPixelDisplay();

    if (!paused) { //if the game isn't paused by the clues run everything normally

      marvis.update();
      checkObstColl();
      checkHumanColl();
      collectItem();
      human_1.update();
      doorCheck();
      marvis.drawAvatar();
     

      for (int i = 0; i < tombs.length; i++) {
        tombs[i].drawObstacle();
      }

      for (int i = 0; i < clues.length; i++) {
        clues[i].drawItem();
      }

      text(lives + " " + clueId, 100, 100); //temporary lives display 

      if (clueId == 3) {
        doorOpen = true;
        pushStyle();
          fill(#98F75A);
          rect(doorX, doorY, doorSizeX, doorSizeY);
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
    
  
    //fill(random(floor(255)), random(floor(255)), random(floor(255)));
    ellipse(brightestPixel.x, brightestPixel.y, 20, 20);
    
   
  }

  void checkObstColl() { //ghost vs obstacle collision check
    for (int i = 0; i < tombs.length; i++) {

      if ( (marvis.x + marvis.mSize/2) > tombs[i].x && (marvis.x - marvis.mSize/2) < tombs[i].x + tombs[i].sizeX && 
        (marvis.y + marvis.mSize/2) > tombs[i].y && (marvis.y - marvis.mSize/2) < tombs[i].y + tombs[i].sizeY) {

        println("collide");
        marvis.speed = 0; //stops when it hits the obstacles but can pass through them
      }
    }
  }

  void checkHumanColl() {

    if ( (marvis.x + marvis.mSize/2) > human_1.x && (marvis.x - marvis.mSize/2) < human_1.x + human_1.size && 
      (marvis.y + marvis.mSize/2) > human_1.y && (marvis.y - marvis.mSize/2) < human_1.y + human_1.size && humanHit == false) {
      println("HE CAUGHT YOU");
      humanHit = true;
      marvis.redness = marvis.redness - 100;//color changing 
      looseLife();
    }
  }

  void collectItem() {
    for (int i = 0; i < clues.length; i++) {

      if ( (marvis.x + marvis.mSize/2) > clues[i].x && (marvis.x - marvis.mSize/2) < clues[i].x + clues[i].sizeX && 
        (marvis.y + marvis.mSize/2) > clues[i].y && (marvis.y - marvis.mSize/2) < clues[i].y + clues[i].sizeY) {

        println("PICKUP");
        clues[i].pickUp();
        clueId ++;
        paused = true;
      }
    }
  }

  void displayClues() {

    pushStyle();
    fill(255, 0, 0);
    textSize(70);
    if (clueId == 1 ) {
      background(0);
      text("CLUE 1", width/2, height/2);
    }

    if (clueId == 2 ) {
      background(0);
      text("CLUE 2", width/2, height/2);
    }

    if (clueId == 3 ) {
      background(0);
      text("CLUE 3", width/2, height/2);
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

    //draw the clues again
    for (int i = 0; i < clues.length; i++) {//for loop draws the items 
      int x = floor(random( width)); //randomize the positions
      int y = floor(random( height));
      clues[i] = new Item(x, y, 20, 20, color(#5AF3F7)); //create the items
    }
  }

  void looseLife() { 
    if (lives > 0 ) {//checks if there are still lifes left and removes one
      lives = lives - 1;
    }
    if (lives == 0) { //No lives = game over
      finished = true;
    }
  }

  void doorCheck() {
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