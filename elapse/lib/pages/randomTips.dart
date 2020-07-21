import 'dart:math';

selectRandomTip() {
  Random rnd;
  int min = 0;
  int max = 30;
  rnd = new Random();
  int r = min + rnd.nextInt(max - min);

  if(r == 0) {
    return 'Always file your axles!';
  }
  else if(r == 1) {
    return 'Do you like the GDC?';
  }
  else if(r == 2) {
    return 'Use a bearing on spinning joints!';
  }
  else if(r == 3) {
    return 'Good luck at your next Tournament!';
  }
  else if(r == 4) {
    return 'Nylock Nut > Kepsnut > Hexnut';
  }
  else if(r == 5) {
    return 'Use a Nylock Nut for places that need to be strong!';
  }
  else if(r == 6) {
    return 'Mark out your polycarbonate first, then cut!';
  }
  else if(r == 7) {
    return 'Organize your wires!';
  }
  else if(r == 8) {
    return 'Stick tape on parts of wires that may make contact with robot - it makes them stronger!';
  }
  else if(r == 9) {
    return 'Always wear safety glasses when using cutters!';
  }
  else if(r == 10) {
    return "VRC stands for VEX Robotics Competition, if you didn't know that already lol";
  }
  else if(r == 11) {
    return 'Green motors are the best for drive-trains!';
  }
  else if(r == 12) {
    return 'Be prepared for you next tournament!';
  }
  else if(r == 13) {
    return "Always use screws!";
  }
  else if(r == 14) {
    return "This season's game looks like Tic-Tac-Toe!";
  }
  else if(r == 15) {
    return "VRC Change Up";
  }
  else if(r == 16) {
    return "Pack snacks so you don't get hungry";
  }
  else if(r == 17) {
    return "I love you! <3";
  }
  else if(r == 18) {
    return "We hope you like using Elapse";
  }
  else if(r == 19) {
    return "lol imagine doing VEX";
  }
  else if(r == 20) {
    return "Make a good strategy to win the game!";
  }
  else if(r == 21) {
    return "Give the skills challenge a try!";
  }
  else if(r == 22) {
    return "Make sure to bring extra batteries!";
  }
  else if(r == 23) {
    return "Keep an extra battery in your pocket, just in case";
  }
  else if(r == 24) {
    return "We hope your team has a great season!";
  }
  else if(r == 25) {
    return "Try to memorize the main rules in the game manual";
  }
  else if(r == 26) {
    return "Give PROS V5 a try, it's more powerful for coding!";
  }
  else if(r == 27) {
    return "Remember to select your code at the start of the match, to avoid delays.";
  }
  else if(r == 28) {
    return "Not ready for a match in eliminations? Use a *timeout*, which delays the match by 3 minutes, giving you time to get ready!";
  }
  else if(r == 29) {
    return "Try not to get DQ'ed!";
  }
  else if(r == 30) {
    return "Remember, trapping your opponent is against the rules!";
  }
}