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
  // A "switch" statement is like an "if" statement with different
  // syntax. Notice how we use "break;" after the instructions for
  // each state are finished.
  switch (state) {
    // If our state is NONE, we do nothing
  case NONE:
    break;

  // If our state is TITLE we update the title object
  // which displays it, and then we check whether the title
  // screen is finished and if so we go to the menu state
  case TITLE:
    title.update();
    if (title.finished) {
      state = State.INTRO;
    }
    break;
    
  case INTRO:
    intro.update();
    if (intro.finished) {
      state = State.LEVEL_1;
    }
    break;

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