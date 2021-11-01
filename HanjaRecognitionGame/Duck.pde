class Duck {

  PVector pos;
  float speed;
  boolean up, down, right, left = false;

  float duckW, duckH;
  float radius;

  boolean collided = false;
  boolean pass = true;
  boolean interacting = false;

  Duck(float pW) {
    pos = new PVector(width / 2, 10);
    duckW = pW;
    duckH = pW*0.9; // 50*0.9 = 45
    speed = 2;
    radius = duckH/2;
  }

  void display() {

    if (up)
      pos.y -=speed;
    if (down)
      pos.y +=speed;
    if (left)
      pos.x -=speed;
    if (right)
      pos.x +=speed;

    push();
    stroke(0);
    //head
    fill(#D6D8CE );
    ellipse(pos.x, pos.y, duckW, duckH);
    //eyes
    fill(#000000);
    ellipse((pos.x - duckW *.2), (pos.y), (duckW *.1), (duckW*.1));
    fill(#000000);
    ellipse((pos.x + duckW *.2), (pos.y), (duckW *.1), (duckW*.1));
    //mouth
    fill(#F4E367);
    ellipse((pos.x), (pos.y + duckW*.2), (duckW*.4), (duckW*.2));
    line ((pos.x - duckW*.2), (pos.y + duckW*.2), (pos.x + duckW*.2), (pos.y + duckW*.2));
    pop();
  }

  float collision(Walldoor pWd) { // Takes a Walldoor.class and uses it to check its collision, and returns bounce value
    boolean[] collisionPass =  pWd.collision(pos.x, pos.y, radius, interacting);
    collided = collisionPass[0];
    pass = collisionPass[1];
    
    if(interacting && collided && pass)
      return 0.0f;
      
    else if(interacting && collided && !pass) //If interacted with while collided and not a passable object.
      return pos.y = lerp(pos.y, 10, 0.8);  //Severe punishment for cheating. Fly you fool!
   
    else if(!interacting && collided)    
        return pos.y -= radius/2; //Bounce
    
    else
      return 0.0f;
  }
/*
  float getXpos() {
    return pos.x;
  }
  float getYpos() {
    return pos.y;
  }
  */
}
