import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.sound.*;

Minim minim;
AudioInput mic; // The class that lets us use the microphone
AudioPlayer turret; //class that lets us play audio

// Somewhere to store our 5 wave frequencies
int[] frequencies = new int[5];
// The number of frames per beat of music
int framesPerBeat = 10;
// Oscillator to play tones
SawOsc saw;
// Sound files for kick and snare
SoundFile kick;
SoundFile snare;
// A string to represent our drum loop
// o = kick
// x = snare
// - = nothing
String drumPattern = "o-x-oox-o-xoooxx";
// Track which character we're playing
int currentDrumBeat = 0;
// Tempo of the drums
int framesPerDrumbeat = 20;

//background color
color backColor = 0;

//cube rotation variables
float rotX;
float rotY;

//stores the random index to imput it into the rotation
float beat;

void setup() {
  size(1080,720, P3D);//enabling 3D library
  
  minim = new Minim(this); //new minim object
  // turn on the mic 
  mic = minim.getLineIn();
  
   turret = minim.loadFile("sounds/Portal 2 - Turret Sounds.mp3", 1024);//load the file of the audio that will affect the lines
  turret.loop();//loop that file
  
  // Go through the array loading frequencies into it
  for (int i = 0; i < frequencies.length; i++) {
    // We can use the i variable to set up equidistant frequencies
    frequencies[i] = 110 + (i * 55);
  }
  // Create the oscillor, set its frequency to a default, make it a bit quieter,
  // and then play it
  saw = new SawOsc(this);
  saw.freq(110);
  saw.amp(0.2);
  saw.play();
  // Load our drum samples
  kick = new SoundFile(this,"sounds/Kick_1.wav");
  snare = new SoundFile(this,"sounds/snare.wav");
}
void draw() {
  background(backColor);//colors the background each frame
  
  float level = mic.mix.level(); // put the mic level into a variable
  rotX =+ level*5; //make the level of the mic affect the x rotation of the cube
  //println(level);
  
   for(int i = 0; i < turret.bufferSize() - 1; i++){ 
     //base code taken from the minim reference examples, generates the frecuency lines for both audio channels
    float x1 = map( i, 0, turret.bufferSize(), 0, width );
    float x2 = map( i+1, 0, turret.bufferSize(), 0, width );
    line( x1, 50 + turret.left.get(i)*50, x2, 50 + turret.left.get(i+1)*80 );
    line( x1, height - 50 + turret.right.get(i)*50, x2, height-50 + turret.right.get(i+1)*80 );
  }
  
  //mouse position controls the rate for the base rythm clips
    float newRateX = map(mouseX,0,width,0.01,5);
    snare.rate(newRateX);//assigns the new rate to the snare sound based on the x postion of the mouse
    
    float newRateY = map(mouseY,0,width,0.01,5);
    kick.rate(newRateY);//assigns the new rate to the kick sound based on the y postion of the mouse
  
  //ellipses that grow with the mic levels 
   fill(0);
   noStroke();
   ellipse(width/4,height/2,level*10000,level*10000);
   ellipse(width - width/4,height/2,level*10000,level*10000);
  
  pushMatrix(); //drawing the 3D cube
    translate(width/2, height/2, 0); //place it in the middle of the screen
    rotateX(rotX); //rotation in x with the mic levels
    rotateY(rotY = rotY + beat);//rotation in y with the random index of the frequencies
    stroke (255); 
    noFill();
    box(300 +(level*1000)); //drawing the cube that grows with the mic level
  popMatrix();
  
  // Use modulo to check if this frame is a multiple of the beat count
  if (frameCount % framesPerBeat == 0) {
    // Pick a random index in the array
    int randomIndex = floor(random(0, frequencies.length));
    beat = randomIndex;
    // Set the new frequency
    saw.freq(frequencies[randomIndex]);
  }
  // Use modulo to check if this frame is a drum beat frame
  if (frameCount % framesPerDrumbeat == 0) {
    // Check whether the current point in the drum pattern is a kick
    // or a snare and play them if so
     if (drumPattern.charAt(currentDrumBeat) == 'o') {
        kick.play();
        backColor = color(random(floor(255)), random(floor(255)), random(floor(255)));
     }
     else if (drumPattern.charAt(currentDrumBeat) == 'x') {
       snare.play();
       backColor = 0;
     }
     // Increment the drum beat (and loop back to the start if finished)
     currentDrumBeat = (currentDrumBeat + 1) % drumPattern.length();
  }
 
}