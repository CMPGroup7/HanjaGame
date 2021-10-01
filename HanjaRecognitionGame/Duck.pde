class Duck {
  float xpos;
  float ypos;
  float xspeed;
  float yspeed;
  float s1, s2;

  Duck() {
    s1 = 50;
    s2 = 45;
    xpos = width / 2;
    ypos = 10;
    xspeed = 1;
    yspeed = 1;
  }

  void display() {
    push();
    //head
    fill(#F7FF1F );
    ellipse(xpos, ypos, s1, s2);
    //eyes
    fill(0, 150, 150);
    ellipse((xpos - s1 *.3), (ypos), (s1 *.1), (s1*.15));
    fill(0, 150, 150);
    ellipse((xpos + s1 *.3), (ypos), (s1 *.1), (s1*.15));
    //mouth
    fill(#FFA512);
    ellipse((xpos), (ypos + s1*.2), (s1*.4), (s1*.2));
    line ((xpos - s1*.2), (ypos + s1*.2), (xpos + s1*.2), (ypos + s1*.2));
    pop();
  }

  void moveUp() { ypos = ypos -10;}
  void moveDown() {ypos = ypos +10;}
  void moveRight() {xpos = xpos +10;}
  void moveLeft() {xpos = xpos -10;}
}
