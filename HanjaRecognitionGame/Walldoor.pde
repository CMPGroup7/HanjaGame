class Walldoor {
  // Will make a Walldoor object which can or cannot be opened

  boolean door = false; //Usually a wall
  boolean collided = false; //Variable for storing and checking collision
  float x = 0;
  float y = 0; // x and y positions
  float dim_W = 10; //Rect width
  float dim_H = 10; //Rect height
  color c = 0; //Rect color
  int strokeC = 0; //Rect border color
  int[] indices = {-1, -1}; //Start and end index for checking where in TextHandler.text ArrayList it was retrieved from

  color fontColor = 255;
  int fontSize;

  PShape rectObj;
  char[][] hangulHanja;
  char hangul;
  char hanja;

  Walldoor(char[] pHang, char[] pHanj, float pX, float pY, int pFontSize, int ind_st, int ind_end, boolean bHanja) { //Constructor for several syllables
// Not finished, not useable yet
    fontSize = pFontSize;
    x = pX;
    y = pY;
    indices[0]=ind_st;
    indices[1]=ind_end;
    dim_W = ind_end - ind_st * fontSize;
    door = bHanja;
    hangulHanja = new char[2][];
   // hangulHanja = {pHang, pHanj};
    //for (int i = 0; i<hangulHanja.length; i++)
     // charConvS+= ""+charArray[i];
    rectObj = createShape(RECT, x, y, dim_W, dim_H);
    
  }

  Walldoor(char pHang, char pHanj, float pX, float pY, int pFontSize, int index, boolean bHanja) { //Constructor for single syllable Walldoor

    fontSize = pFontSize;
    x = pX;
    y = pY;
    indices[0]=index;
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
      fill(255, 255, 0);
      text(""+hanja, x, y);
      text(""+hangul,  x + (int)random(-10, 10),  y + (int)random(-10, 10));
      pop();
    } else if (!collided || !door){
      push();
      textAlign(LEFT, CENTER);
      fill(fontColor);
      text(""+hangul, x, y);
      pop();
    }
    
  }

  boolean pointColCheck(float pX, float pY) { //Mouse test
    if (pX >= x &&
      pX <= x + dim_W &&
      pY >= y &&
      pY <= y + dim_H)
      return true;
    else
      return false;
  }

  boolean collision(float pX, float pY, float pRadius) { //Also added collision to Duck to check via Walldoor

    float checkX = pX;
    float checkY = pY;

    if (pX < x)              checkX = x;
    else if (pX > x+dim_W)   checkX = x + dim_W;

    if (pY < y)              checkY = y;
    else if (pY > y + dim_H) checkY = y + dim_H;

    float distX = pX - checkX;
    float distY = pY - checkY;
    float distance = sqrt((distX *distX)+(distY*distY));

    if (distance <= pRadius)
      return collided = true; // Sets and returns collided value
      
    return collided = false;

  }
}
