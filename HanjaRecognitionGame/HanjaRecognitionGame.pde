//v1.5 2021-10-25
PWindow win;
float toH_ratio;
float toW_ratio;
int w, h;

float x = width/2;
float y = height/2;
float wallW = 100;
float wallH = 100;

float toDuckRatio = 1.786;

boolean gameStart = false;

Duck duck;
Level level;
Interface startScreen, ending;

void setup() {

  size(100, 720);
  w = width;
  h = height;

  //Use one of the two
  toW_ratio = 0.70708; //Height:Width
  toH_ratio = 1.4142; //Width:Height

  if (displayHeight > 1000) {//Checks display size and resizes if necessary
    h = 1000;
    w = int(h*toW_ratio);
  } else if (displayHeight > 720) {
    h = 720;
    w = int(h*toW_ratio);
  } else if (displayHeight < 720) {
    h = 500;
    w = int(h*toW_ratio);
  }

  surface.setSize(w, h);
  background(100);

  level = new Level(w, h); //Adds Walldoor objects and combines them with the text from a TextHandler object. Must be initialized first since PWindow needs it.
  duck = new Duck(level.fontSize*toDuckRatio); //Calls Duck to be constructed with pW in width (s1 = pW)
  startScreen = new Interface();
  ending = new Interface();
  win = new PWindow(); //Initialized last to make sure it can retrieve values
}

void draw() {

  background(100);

  if (gameStart == false) { //Game state checks
    startScreen.startScreen();
  }
  if (gameStart == true) {

    level.display();

    duck.display();
    
    level.collision(); //Collision is detected in the Walldoor objects which are handled by the Level class
    
  }
  if (duck.pos.y >= height*0.9){
    ending.ending();
  }

}

void keyPressed() {
  //if(!duck.collided)
  keyCheck(keyCode, true); //Sets values

  gameStart = true;
}

void keyReleased() {
  keyCheck(keyCode, false); //Resets values
}

boolean keyCheck(int k, boolean b) {
  //println(k); //Uncomment to check keyCode
  switch(k) {

  case UP:
    return duck.up = b;

  case DOWN:
    return duck.down = b;

  case RIGHT:
    return duck.right = b;

  case LEFT:
    return duck.left = b;

  default :
    return b;
  }
}
