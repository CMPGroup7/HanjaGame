class Duck {
 
  PVector pos;
  float speed;
  boolean up, down, right, left = false;
  
  float duckW, duckH;
  float radius;
  boolean collided = false;

  Duck() {
    pos = new PVector(width / 2, 10);
    duckW = 50;
    duckH = 45;
    speed = 1;
    radius = duckH;
  }

  Duck(float pW) {
    pos = new PVector(width / 2, 10);
    duckW = pW;
    duckH = pW*0.9; // 50*0.9 = 45
    speed = 2;
    radius = duckH/2;
  }

  void display() {
    
    if(up && !collided)
      pos.y -=speed;
    if(down && !collided)
      pos.y +=speed;
    if(left && !collided)
      pos.x -=speed;
    if(right && !collided)
      pos.x +=speed;
      
    if(collided){
      down = false;
      pos.y -= speed;
    }
    
    push();
    //head
    fill(#F7FF1F );
    ellipse(pos.x, pos.y, duckW, duckH);
    //eyes
    fill(0, 150, 150);
    ellipse((pos.x - duckW *.3), (pos.y), (duckW *.1), (duckW*.15));
    fill(0, 150, 150);
    ellipse((pos.x + duckW *.3), (pos.y), (duckW *.1), (duckW*.15));
    //mouth
    fill(#FFA512);
    ellipse((pos.x), (pos.y + duckW*.2), (duckW*.4), (duckW*.2));
    line ((pos.x - duckW*.2), (pos.y + duckW*.2), (pos.x + duckW*.2), (pos.y + duckW*.2));
    pop();
  }

  boolean collision(Walldoor pWd) { // Takes a Walldoor.class and uses it to check its collision,
    //set Duck object's collided value and then return it.
    return collided =  pWd.collision(pos.x, pos.y, radius);
  }

  float getXpos() {
    return pos.x;
  }
  float getYpos() {
    return pos.y;
  }
}
