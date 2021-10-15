class Walldoor{ 
  // Will take a Texthandler object and make a Rectwalldoor object which can or cannot be opened

boolean door = false; //Usually a wall
boolean collided = false;
float x = 0;
float y = 0;
float dim_W = 10;
float dim_H = 10;
int r, g, b;
int v = 0;
int strokeV = 0;

PShape rectObj;

Walldoor(){
  
  rectObj = createShape(RECT, x, y, dim_W, dim_H);
  
}

Walldoor(boolean type, float pX, float pY, float pW, float pH){
  
  x = pX;
  y = pY;
  dim_W = pW;
  dim_H = pH;
  rectObj = createShape(RECT, x, y, dim_W, dim_H);
  door = type;
  
}

Walldoor(boolean type, float pX, float pY, float pW, float pH, int pV){
  
  x = pX;
  y = pY;
  dim_W = pW;
  dim_H = pH;
  v = pV;
  rectObj = createShape(RECT, x, y, dim_W, dim_H);
  rectObj.setStroke(v);
  rectObj.setFill(v);
  door = type;
  
}

void display(){
  shape(rectObj);
  push();
  rectObj.setStroke(strokeV);
  rectObj.setFill(v);
  pop();
}

boolean pointColCheck(float pX, float pY){ //Mouse test
  if(pX >= x &&
     pX <= x + dim_W &&
     pY >= y &&
     pY <= y + dim_H)
        return true;
  else     
  return false;
}

boolean collision(float pX, float pY, float pRadius){ //Also added collision to Duck to check via Walldoor
  
  float checkX = pX;
  float checkY = pY;
  
  if(pX < x)              checkX = x;
  else if (pX > x+dim_W)  checkX = x + dim_W;
  
  if(pY < y)              checkY = y;
  else if(pY > y + dim_H) checkY = y + dim_H;
  
  float distX = pX - checkX;
  float distY = pY - checkY;
  float distance = sqrt((distX *distX)+(distY*distY));
  
  if (distance <= pRadius)
    return collided = true; // Sets and returns collided value
  return collided = false;
  
}

}
