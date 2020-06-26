import 'dart:math';

selectRandomTip() {
  Random rnd;
  int min = 0;
  int max = 20;
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
    return "dang writing these tips are boring";
  }
}