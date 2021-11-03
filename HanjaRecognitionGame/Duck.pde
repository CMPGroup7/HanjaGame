class Duck {

  PVector pos;//Position of the character
  float speed;
  boolean up, down, right, left = false;//To get user input for character movement

  float duckW, duckH;//width and Height of the charater
  float radius;

  boolean collided = false; //To check if the character and the object collided.
  boolean pass = true; // To check if an object is passable (hanja) or not.
  boolean interacting = false; //To check if user is pressing 'e' key.
  

  Duck(float pW) {
    pos = new PVector(width / 2, 10);
    duckW = pW;
    duckH = pW*0.9; // 50*0.9 = 45
    speed = 2;
    radius = duckH/2;
  }

  void display() {//Draws and moves character


    if (up&&pos.y>=0)//character moves up
      pos.y -=speed;
    if (down&& pos.y<=height)//charactor moves down
      pos.y +=speed;
    if (left&&pos.x>=0)//character moves left
      pos.x -=speed;
    if (right&&pos.x<=width)//character moves right
      pos.x +=speed;

    push();
    stroke(0);
    fill(#D6D8CE );
    ellipse(pos.x, pos.y, duckW, duckH);//draws head
    fill(#000000);
    ellipse((pos.x - duckW *.2), (pos.y), (duckW *.1), (duckW*.1));//draws left eye
    fill(#000000);
    ellipse((pos.x + duckW *.2), (pos.y), (duckW *.1), (duckW*.1));//draws right eye
    fill(#F4E367);
    ellipse((pos.x), (pos.y + duckW*.2), (duckW*.4), (duckW*.2));//draws mouth
    line ((pos.x - duckW*.2), (pos.y + duckW*.2), (pos.x + duckW*.2), (pos.y + duckW*.2));//draws line
    pop();
  }

  float collision(Walldoor pWd) { // Takes a Walldoor.class and uses it to check its collision, and returns bounce value
    boolean[] collisionPass =  pWd.collision(pos.x, pos.y, radius, interacting);//collide character
    collided = collisionPass[0];
    pass = collisionPass[1];
    
    if(interacting && collided && pass)//If intercted with while collided and a passable object.
      return 0.0f;
      
    else if(interacting && collided && !pass){ //If interacted with while collided and not a passable object.
      restart = true;
      return pos.y = lerp(pos.y, 10, 0.8);  //Severe punishment for cheating. Fly you fool!
    }
   
    else if(!interacting && collided)    
        return pos.y -= radius/2; //Bounce (if not interected while collided)
    
    else
      return 0.0f;
  }
}
