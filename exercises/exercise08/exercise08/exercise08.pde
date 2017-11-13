//Ghost Stories
//by Mariana Hernández


//I'm using enum to track the state the program is in.
enum State {
  NONE, 
    TITLE, 
    INTRO, 
    LEVEL_1, 
    //LEVEL_2,
    //LEVEL_3
}

State state;

//variables that represent the states of the game
Title title;
Intro intro;
Level_1 level_1;
//Level_2 level_2;
//Level_3 level_3;


void setup() {
  // Set the size
  size(640, 480);

  // Create the different states
  title = new Title();
  intro = new Intro();
  level_1 = new Level_1();
  //level_2 = new Level_2();
  //level_3 = new Level_3();

  // We start our state in the title screen
  state = State.TITLE;
}

void draw() {
  //I'm using a switch statement to change between the different states of the game
  switch (state) {
    // If our state is NONE, we do nothing
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
    if (level_1.returnToMenu) {
      state = State.TITLE;
      //state = State.LEVEL_2;
      level_1.reset();
    }
    break;
    //ADD HERE FUTURE LEVELS
  }
}

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

  }
}