// GriddiEaters

//The natural predators and superiors of the griddies
class GriddiEater {
  // Limits for energy level and gains/losses
  int maxEnergy = 300;
  int moveEnergy = -2;
  int collideEnergy = 20;
  
  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(#58E4FF);
  
  // Griddie(tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  // Initialise energy to the maximum
  GriddiEater(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Griddie and update its energy levels
  void update() {
    
    // it checks if the griddieater ran out of energy (died) and returns a true or false
    if (energy == 0) {
      return;
    }
    
    // the griddie can randomly move in -2, -1, 0, 1 or 2 in x and y direction within the spots in the grid (that' why it's multiplied by size)
    int xMoveType = floor(random(-2,3));
    int yMoveType = floor(random(-2,3));
    x += size * xMoveType;
    y += size * yMoveType;
    
    // they are checking whether the griddies are trying to escape the grid (position outside the screen) and preventing them from doing so by
    // either adding or substracting from the width and height, keeping them inside the grid.
    if (x < 0) {
      x += width;
    }
    else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    }
    else if (y >= height) {
      y -= height;
    }

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;
    
    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy,0,maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Griddie
  // and updates energy level
  
  void collide(GriddiEater other) {
    // checks if either of the griddies are dead and collide doesn't get executed if they are
    if (energy == 0 || other.energy == 0) {
      return;
    }
    
    // checks if the griddie is intersecting with another griddie, if it is then the collide energy is added to it
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy,0,maxEnergy);
    }
  }

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // it shows the amount of energy the griddies have by displaying their health in their color opacity 
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
  
  void eatGriddie (){
    // Increase this Griddie's energy
      energy += collideEnergy;
  }
  
  
}