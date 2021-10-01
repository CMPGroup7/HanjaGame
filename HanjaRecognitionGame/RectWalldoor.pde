class RectWalldoor{

float x = 0;
float y = 0;
float dim_W = 10;
float dim_H = 10;
int r, g, b;
int v = 0;
int strokeV = 0;

PShape rectObj;

RectWalldoor(){
  
  rectObj = createShape(RECT, x, y, dim_W, dim_H);
  
}

RectWalldoor(float pX, float pY, float pW, float pH){
  
  x = pX;
  y = pY;
  dim_W = pW;
  dim_H = pH;
  rectObj = createShape(RECT, x, y, dim_W, dim_H);
  
}

RectWalldoor(float pX, float pY, float pW, float pH, int pV){
  
  x = pX;
  y = pY;
  dim_W = pW;
  dim_H = pH;
  v = pV;
  rectObj = createShape(RECT, x, y, dim_W, dim_H);
  rectObj.setStroke(v);
  rectObj.setFill(v);
  
}

void display(){
  shape(rectObj);
  push();
  rectObj.setStroke(strokeV);
  rectObj.setFill(v);
  pop();
}

boolean pointColCheck(float pX, float pY){
  if(pX >= x &&
     pX <= x + dim_W &&
     pY >= y &&
     pY <= y + dim_H)
        return true;
  else     
  return false;
}

}
