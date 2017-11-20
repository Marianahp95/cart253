//Ghost Stories
//by Mariana Hernández

//*******TO DO LIST*******

//- FIX RESET *
//- COLLISION OF HUMAN WITH OBSTACLES

//- CLUE POP UP * 
//- AFTER ITEM COLLECTION OPEN DOOR TO NEXT LEVEL
//- HEALTH WITH WEBCAM
//- ADD SOUNDS
//- ADD GRAPHICS


//I'm using enum to track the state the program is in.
enum State {
  NONE, 
    TITLE, 
    INTRO, 
    LEVEL_1, 
    //LEVEL_2,
    //LEVEL_3
    GAMEOVER,
    GAMEWON
}

State state;

//variables that represent the states of the game
Title title;
Intro intro;
Level_1 level_1;
//Level_2 level_2;
//Level_3 level_3;
GameOver gameover;
GameWon gamewon;


void setup() {
  // Set the size
  size(1080, 720);

  // Create the different states
  title = new Title();
  intro = new Intro();
  level_1 = new Level_1();
  //level_2 = new Level_2();
  //level_3 = new Level_3();
  gameover = new GameOver();
  gamewon = new GameWon();

  // We start our state in the title screen
  state = State.TITLE;
  
}

void draw() {
  //I'm using a switch statement to change between the different states of the game
  switch (state) {
    // If the state is NONE, we do nothing
  case NONE:
    break;

//title screen
  case TITLE:
    title.update();
    if (title.finished) {
      state = State.INTRO;
    }
    break;
    
//story intro
  case INTRO:
    intro.update();
    if (intro.finished) {
      state = State.LEVEL_1;
    }
    break;

//first level
  case LEVEL_1:
    level_1.update();
    if (level_1.won){
      state = State.GAMEWON;
    }
    
    if (level_1.finished) {
      state = State.GAMEOVER;
      //state = State.LEVEL_2;
      //level_1.reset();
    }
    
    
    break;
    //ADD HERE FUTURE LEVELS
    
     case GAMEWON:
    gamewon.update();
    if (gamewon.finished) {
      state = State.TITLE;
      //state = State.LEVEL_2;
      //level_1.reset();
      title.reset();
    }
    break;
    
    
    //if the player loses
    case GAMEOVER:
    gameover.update();
    if (gameover.finished) {
      state = State.TITLE;
      //state = State.LEVEL_2;
      //level_1.reset();
      title.reset();
    }
    break;
  }
}

//calling the key pressed and key released for every different state
void keyPressed() {
  switch (state) {
  case NONE:
    break;

  case TITLE:
    title.keyPressed();
    break;

  case INTRO:
    intro.keyPressed();
    break;

  case LEVEL_1:
    level_1.keyPressed();
    break;
    
  case GAMEOVER:
    gameover.keyPressed();
    break;
    
  case GAMEWON:
    gamewon.keyPressed();
    break;
  }
}

void keyReleased() {
  switch (state) {
  case NONE:
    break;

  case TITLE:
    title.keyReleased();
    break;

  case INTRO:
    intro.keyReleased();
    break;


  case LEVEL_1:
    level_1.keyReleased();
    break;

  case GAMEOVER:
    gameover.keyReleased();
    break;
    
  case GAMEWON:
    gamewon.keyReleased();
    break;
  }
}