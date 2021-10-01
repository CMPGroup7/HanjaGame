float x = width/2;
float y = height/2;
float wallW = 100;
float wallH = 100;
int v = 0;
boolean collided = false;

PFont font;
int fontS = 20;
String text;

RectWalldoor wall;
Duck duck;

TextHandler tHandle;

void setup(){
  
  duck = new Duck();
  wall = new RectWalldoor(x, y, wallW, wallH);

  size(640, 400);
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
