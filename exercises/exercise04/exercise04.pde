// Griddies
// by Pippin Barr
// MODIFIED BY: 
// Mai Hernandez :)
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element
int gridSize = 20;
// An array storing all the griddies
Griddie[] griddies = new Griddie[100];
GriddiEater[] griddiEaters = new GriddiEater[100];

// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(15);

  // QUESTION: What does this for loop do?
  // it goes through the whole array generating the griddies in random places within the grid and it makes them the size of one square in the grid 
  for (int i = 0; i < griddies.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }
  
  //Griddieaters random generation
   for (int i = 0; i < griddiEaters.length; i++) {
    int x = floor(random(0, width/(gridSize)));
    int y = floor(random(0, height/(gridSize)));
    griddiEaters[i] = new GriddiEater(x * (gridSize), y * (gridSize), (gridSize));
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.

void draw() {
  background(50);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();
    
    //griddieaters eat the griddies when they collide
    if (griddies[i].x == griddiEaters[i].x && griddies[i].x == griddiEaters[i].x){
            griddiEaters[i].eatGriddie();
            griddies[i].beEaten();
    }

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // this is veryfing that the griddie is not giving itself life, without it the griddies never die because the collide is activated when they are colliding with themselves
      if (j != i) {
        // it checks whether the griddies are coming in contact with other griddies and calling the collide function
        griddies[i].collide(griddies[j]);
        
      }
    }
    
    // Display the griddies
    griddies[i].display();
  }
  
  for (int i = 0; i < griddiEaters.length; i++) {

    // Update the griddies
    griddiEaters[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddiEaters.length; j++) {
      // QUESTION: What is this if-statement for?
      // this is veryfing that the griddie is not giving itself life, without it the griddies never die because the collide is activated when they are colliding with themselves
      if (j != i) {
        // QUESTION: What does this line check?
        // it checks whether the griddies are coming in contact with other griddies and calling the collide function
        griddiEaters[i].collide(griddiEaters[j]);
      }
    }
    
    // Display the griddies
    griddiEaters[i].display();
  }
}