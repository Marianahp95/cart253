class Timer {
  // The value of millis() when the timer was started
  int startTime;
  // The number of milliseconds that have elapsed for the timer
  // Need this for pausing
  int elapsed = 0;
  // The time this timer is set for (in milliseconds)
  int time;
  // Whether or not the timer is active
  boolean running = false;
  // Whether or not the timer is paused
  boolean paused = false;
  // Timer (int tempTime)
  //
  // Create a new timer with a set number of milliseconds to count to
  Timer(int tempTime) {
    time = tempTime;
  }
}