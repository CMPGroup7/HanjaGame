class Walldoor {
  // Will take a Texthandler object and make a Rectwalldoor object which can or cannot be opened

  boolean door = false; //Usually a wall
  boolean collided = false;
  float x = 0;
  float y = 0;
  float dim_W = 10;
  float dim_H = 10;
  color c = 0;
  int strokeC = 0;
  int[] indices = {-1, -1};

  color fontColor = 255;
  int fontSize;

  PShape rectObj;
  String sText = "Default"; // For testing

  Walldoor() {
    rectObj = createShape(RECT, x, y, dim_W, dim_H);
  }

  Walldoor(String pS_text, float pX, float pY, int pFontSize, int ind_st, int ind_end, boolean bHanja) {

    sText = "";
    fontSize = pFontSize;
    x = pX;
    y = pY;
    indices[0]=ind_st;
    indices[1]=ind_end;
    dim_W = ind_end - ind_st * fontSize;
    door = bHanja;
    sText = pS_text;
    rectObj = createShape(RECT, x, y, dim_W, dim_H);
  }

  Walldoor(char c, float pX, float pY, int pFontSize, int index, boolean bHanja) { //Single syllable walldoor

    sText = "";
    fontSize = pFontSize;
    x = pX;
    y = pY;
    indices[0]=index;
    dim_W = fontSize;
    door = bHanja;
    sText = ""+c;
    rectObj = createShape(RECT, x, y, dim_W, dim_H);
    
  }

  Walldoor(boolean type, float pX, float pY, float pW, float pH) {

    x = pX;
    y = pY;
    dim_W = pW;
    dim_H = pH;
    rectObj = createShape(RECT, x, y, dim_W, dim_H);
    door = type;
  }

  Walldoor(boolean type, float pX, float pY, float pW, float pH, color pC) {

    x = pX;
    y = pY;
    dim_W = pW;
    dim_H = pH;
    c = pC;
    rectObj = createShape(RECT, x, y, dim_W, dim_H);
    rectObj.setStroke(v);
    rectObj.setFill(v);
    door = type;
  }

  void display() {
    push();
    rectObj.setStroke(strokeC);
    rectObj.setFill(v);
    shape(rectObj);
    pop();

    push();
    fill(fontColor);
    text(sText, x, y);
    pop();
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
    else if (pX > x+dim_W)  checkX = x + dim_W;

    if (pY < y)              checkY = y;
    else if (pY > y + dim_H) checkY = y + dim_H;

    float distX = pX - checkX;
    float distY = pY - checkY;
    float distance = sqrt((distX *distX)+(distY*distY));

    if (distance <= pRadius)
      return collided = true; // Sets and returns collided value
    return collided = false;
  }
  //Walldoor shakes and chages color when duck is around
  //  x = x + (int) random(-10, 10);
  //   y = y + (int) random(-10, 10);
  //   fill(255, 255, 0);
  //   text(text.get(charcount), x, y);
}
