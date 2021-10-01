float toH_ratio;
float toW_ratio;
int w, h;

float x = width/2;
float y = height/2;
float wallW = 100;
float wallH = 100;

int v = 0;
boolean collided = false;

PFont font;
int fontS = 28;
String text;
float toDuckRatio = 1.786;

RectWalldoor wall;
Duck duck;

TextHandler tHandle;

void setup(){
 
  size(100,720);
  w = width;
  h = height;
   //Use one of the two
  toW_ratio = 0.70708; //Height:Width
  toH_ratio = 1.4142; //Width:Height
  
  if(displayHeight > 1000) {//Checks display size and resizes if necessary
    h = 1000;
    w = int(h*toW_ratio);
  } else if(displayHeight > 720) {
    h = 720;
    w = int(h*toW_ratio);
  } else if(displayHeight < 720) {
    h = 500;
    w = int(h*toW_ratio);
  }
  
  surface.setSize(w, h);
  background(100);
  
  duck = new Duck(fontS*toDuckRatio); //Calls Duck to be constructed with pW in width (s1 = pW)
  wall = new RectWalldoor(x, y, wallW, wallH);
  
  font = createFont("Batang", fontS); // setup font size for easier loading
  textFont(font); 
  //text = new String("가나다라마바사 文");
  tHandle = new TextHandler();
  
}

void draw(){
  background(100);
  wall.display();
  duck.display();
 
  
  textSize(fontS);
  textAlign(LEFT,CENTER);
  
  for(int i = 0; i < tHandle.represent.length; i++){
    text(tHandle.represent[i],x,y+(80*i)); 
  }

  collided = wall.pointColCheck(mouseX, mouseY);
  
}

void mousePressed(){

if(wall.pointColCheck(mouseX, mouseY))
  wall.strokeV = 255;

}

void mouseReleased(){

if(wall.pointColCheck(mouseX, mouseY) || !collided)
  wall.strokeV = wall.v;

}

void keyPressed() {
  if (keyCode == UP)duck.moveUp();
  if (keyCode == DOWN)duck.moveDown();
  if (keyCode == RIGHT)duck.moveRight();
  if (keyCode == LEFT) duck.moveLeft();
}
