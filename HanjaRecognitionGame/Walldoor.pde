class Walldoor {
  // Will make a Walldoor object which can or cannot be opened

  boolean door = false; //Usually a wall
  boolean collidedOnce = false;
  boolean collided = false; //Variable for storing and checking collision
  float x = 0;
  float y = 0; // x and y positions
  float dim_W = 10; //Rect width
  float dim_H = 10; //Rect height
  color c = 0; //Rect color
  int strokeC = 0; //Rect border color
  int[] indices; //Individual and group index for checking where in TextHandler.text ArrayList it was retrieved from

  color fontColor = 255;
  int fontSize;
  int colorShift = 0;

  PShape rectObj;
  char[][] hangulHanja;
  char hangul;
  char hanja;

  Walldoor(char pHang, char pHanj, float pX, float pY, int pFontSize, int index, int grpIndex, boolean bHanja) { //Constructor for single syllable Walldoor

    fontSize = pFontSize;
    x = pX;
    y = pY;
    indices = new int[]{index, grpIndex};
    dim_W = fontSize;
    dim_H = fontSize;
    door = bHanja;
    //charArray = new char[1];
    hangul = pHang;
    hanja = pHanj;
    
    rectObj = createShape(RECT, x, y, dim_W, dim_H);
    
  }

  void display() {
    push();
    rectObj.setStroke(strokeC);
    rectObj.setFill(c);
    shape(rectObj);
    pop();
   
    if (collided && door) {
      push();
      textAlign(LEFT, CENTER);
      fill(255, 255, 0);
      text(""+hanja, x, y);
      text(""+hangul,  x + (int)random(-10, 10),  y + (int)random(-10, 10));
      pop();
    } else if (!collidedOnce || !door){
      push();
      textAlign(LEFT, CENTER);
      fill(fontColor);
      text(""+hangul, x, y);
      pop();
    }else if (collidedOnce && door && colorShift <= 0){
      push();
      textAlign(LEFT, CENTER);
      
      int r = fontColor >> 16 & 0xFF;
      int g = fontColor >> 8 & 0xFF;
      int b = fontColor & 0xFF;
      int a = fontColor >> 24 & 0xFF;
      
      colorShift = 200;
      a = a + colorShift % 255;
      r = r + colorShift % 255;
      b = b + colorShift % 255;
      
      fontColor = color(r,g,b,a);
      fill(fontColor);
      text(""+hanja, x, y);
      pop();
    }else if (collidedOnce && door && colorShift > 0){
      push();
      textAlign(LEFT, CENTER);
      fill(fontColor);
      text(""+hanja, x, y);
      pop();
    }
    
  }

  boolean[] collision(float pX, float pY, float pRadius) { //Also added collision to Duck to check via Walldoor

    boolean[] collisionPass = {collided, door};
    float checkX = pX;
    float checkY = pY;
    
   // println(collidedOnce);
    if(collided){
      collidedOnce = true;
      collided = !collided;
    }

    if (pX < x)              checkX = x;
    else if (pX > x+dim_W)   checkX = x + dim_W;

    if (pY < y)              checkY = y;
    else if (pY > y + dim_H) checkY = y + dim_H;

    float distX = pX - checkX;
    float distY = pY - checkY;
    float distance = sqrt((distX *distX)+(distY*distY));

    if (distance <= pRadius){
      collided = true;
      
      collisionPass[0] = collided;
      collisionPass[1] = door;
      return collisionPass; 
    }
    
    return collisionPass;

  }
}
