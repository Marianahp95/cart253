import processing.sound.*;
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

void setup() {
  size(1080,720, P3D);
  
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
  kick = new SoundFile(this,"sounds/kick.wav");
  snare = new SoundFile(this,"sounds/snare.wav");
}
void draw() {
  background(backColor);
  // Use modulo to check if this frame is a multiple of the beat count
  if (frameCount % framesPerBeat == 0) {
    // Pick a random index in the array
    int randomIndex = floor(random(0, frequencies.length));
    // Set the new frequency
    saw.freq(frequencies[randomIndex]);
  }
  // Use modulo to check if this frame is a drum beat frame
  if (frameCount % framesPerDrumbeat == 0) {
    // Check whether the current point in the drum pattern is a kick
    // or a snare and play them if so
     if (drumPattern.charAt(currentDrumBeat) == 'o') {
        kick.play();
        backColor = 255;
     }
     else if (drumPattern.charAt(currentDrumBeat) == 'x') {
       snare.play();
       backColor = 0;
     }
     // Increment the drum beat (and loop back to the start if finished)
     currentDrumBeat = (currentDrumBeat + 1) % drumPattern.length();
  }
 
}