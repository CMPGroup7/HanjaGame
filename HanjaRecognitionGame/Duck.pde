class Duck {
  float xpos;
  float ypos;
  float xspeed;
  float yspeed;
  float duckW, duckH; 
  float radius;
  boolean collided = false;

  Duck() {
    duckW = 50;
    duckH = 45;
    xpos = width / 2;
    ypos = 10;
    xspeed = 1;
    yspeed = 1;
    radius = duckH;
  }

  Duck(float pW) {
    duckW = pW;
    duckH = pW*0.9; // 50*0.9 = 45
    xpos = width / 2;
    ypos = 10;
    xspeed = 1;
    yspeed = 1;
    radius = duckH;
  }

  void display() {
    push();
    //head
    fill(#F7FF1F );
    ellipse(xpos, ypos, duckW, duckH);
    //eyes
    fill(0, 150, 150);
    ellipse((xpos - duckW *.3), (ypos), (duckW *.1), (duckW*.15));
    fill(0, 150, 150);
    ellipse((xpos + duckW *.3), (ypos), (duckW *.1), (duckW*.15));
    //mouth
    fill(#FFA512);
    ellipse((xpos), (ypos + duckW*.2), (duckW*.4), (duckW*.2));
    line ((xpos - duckW*.2), (ypos + duckW*.2), (xpos + duckW*.2), (ypos + duckW*.2));
    pop();
  }

  void moveUp() {
    ypos = ypos -10;
  }
  void moveDown() {
    ypos = ypos +10;
  }
  void moveRight() {
    xpos = xpos +10;
  }
  void moveLeft() {
    xpos = xpos -10;
  }

  boolean collision(Walldoor pWd) { // Takes a Walldoor.class and uses it to check its collision,
    //set Duck object's collided value and then return it.
    return collided =  pWd.collision(xpos, ypos, radius);
  }

}
