class Walldoor {
  // Will make a Walldoor object which can or cannot be opened
  boolean excPass = false; //Exception for non-Hanja that will be passable anyway. Seperated to distinguish between hanja and non-Hanja indices
  boolean door = false; //Usually a wall
  boolean collidedOnce = false;
  boolean collided = false; //Variable for storing and checking collision
  boolean interaction = false;

  int[] indices; //Individual[0] and group[1] indices for checking where in TextHandler's text ArrayList it was retrieved from

  float x = 0;
  float y = 0; // x and y positions
  float dim_W = 10; //Rect width
  float dim_H = 10; //Rect height

  color fillC = 100; //Rect color
  int strokeC = 100; //Rect border color
  color fontColor = 255; 
  int fontSize;
  int colorShift = 0; //For making color changes

  PShape rectObj; 
  char[][] hangulHanja;
  char hangul;
  char hanja;

  //Takes a hangul char, hanja char, x+y positions, font size,  individual index in hanjaContainer/ text, hanjaGroupIndex to check which word, and a door boolean
  Walldoor(char pHang, char pHanj, float pX, float pY, int pFontSize, int index, int grpIndex, boolean bHanja) { //Constructor for single syllable Walldoor

    fontSize = pFontSize-10;
    x = pX;
    y = pY;
    indices = new int[]{index, grpIndex};
    dim_W = fontSize;
    dim_H = fontSize;
    door = bHanja;
    //charArray = new char[1];
    hangul = pHang;
    hanja = pHanj;
    
    rectObj = createShape(RECT, x+4, y-10, dim_W, dim_H);
  }

  void display() {
    push();
    noFill();
    rectObj.setFill(color(100,100,100,0));
    shape(rectObj);
    pop();

    if (collided && door && interaction) { //Every time any door is collided
      push();
      textAlign(LEFT, CENTER);
      fill(255, 255, 0);
      text(""+hanja, x, y);
      text(""+hangul, x + (int)random(-10, 10), y + (int)random(-10, 10)); //예진 's effect
      pop();
    } else if (!collidedOnce || !door) { //if not collidedOnce then it should not display hanja. If not a door then it shouldn't either.
      push();
      textAlign(LEFT, CENTER);
      fill(fontColor);
      text(""+hangul, x, y);
      pop();
    } else if (collidedOnce && door && colorShift <= 0) { //Checks if a door has been collidedOnce and hasn't been recolored
      push();
      textAlign(LEFT, CENTER);

      int r = fontColor >> 16 & 0xFF; //same as function as red()
      int g = fontColor >> 8 & 0xFF; //same as green()
      int b = fontColor & 0xFF;     // same here.
      int a = fontColor >> 24 & 0xFF; //Much lighter function since it doesn't call the function

      colorShift = 200;
      a = a + colorShift % 255; //Adds a value to the respective colors, excluding green, and if it's larger or same as 255 then it starts from 0 again
      r = r + colorShift % 255;
      b = b + colorShift % 255;

      fontColor = color(r, g, b, a); // Applies new color to fontColor. I could do the same here, but a bit complicated for me
      fill(fontColor);
      text(""+hanja, x, y); //Then displays hanja
      pop();
      ring.play();
    } else if (collidedOnce && door && colorShift > 0) { //Continuation without changing color
      push();
      textAlign(LEFT, CENTER);
      fill(fontColor);
      text(""+hanja, x, y); //Keeps displaying hanja
      pop();
    }
  }

  boolean[] collision(float pX, float pY, float pRadius, boolean p_interaction) { //Duck retrieves collided and door value from Walldoor object's returned array values

    boolean[] collisionPass = {collided, door, interaction};
    float checkX = pX;
    float checkY = pY;
    
    interaction = p_interaction;

    if (collided && interaction && door) {
      collidedOnce = true;
      collided = !collided;
      //  interaction = p_interaction;
    } else if (collided && !interaction)
      collided = !collided;
      
  //Actual collision check
    if (pX < x)              checkX = x;
    else if (pX > x+dim_W)   checkX = x + dim_W;
    if (pY < y)              checkY = y;
    else if (pY > y + dim_H) checkY = y + dim_H;

    float distX = pX - checkX;
    float distY = pY - checkY;
    float distance = sqrt((distX *distX)+(distY*distY));

    if (distance <= pRadius) {

      collided = true;
      collisionPass[0] = collided;

      if (excPass) //Sets an exception and so that it can be handled like a door
        collisionPass[1] = excPass;
      else {
        collisionPass[1] = door;
      }

      return collisionPass;
    }

    return collisionPass; //for setting collided and pass in Duck class
  }
}
