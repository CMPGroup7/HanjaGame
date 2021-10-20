//v1.3 2021-10-08

float toH_ratio;
float toW_ratio;
int w, h;

float x = width/2;
float y = height/2;
float wallW = 100;
float wallH = 100;

int v = 0;
//boolean collided = false;

int fontS = 28; // 28
float toDuckRatio = 1.786;

ArrayList<Walldoor> wallDoors;

Walldoor wall, door;
Duck duck;
Level level;

TextHandler tHandle; //Texthandler should break up text into  syllables
//with 한자 and without. All spaces and syllables should be saved, but no parentheses.
// These will only be used to seperate 한자 and non-한자 words + their syllables
// Syllable = 음절 /한마디. 예를 들면 "사장님"라고 쓰면 음절이 세개입니다.

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

  duck = new Duck(fontS*toDuckRatio); //Calls Duck to be constructed with pW in width (s1 = pW)
  //wall = new Walldoor(false, x, y, wallW, wallH);
  //door = new Walldoor(true, x, y+200, wallW, wallH); // Duck will not be stopped

  //wallDoors = new ArrayList<Walldoor>();
  //wallDoors.add(wall);
  //wallDoors.add(door);

  tHandle = new TextHandler();

  win = new PWindow();
  
  level = new Level(width, height); //Adds Walldoor object and combines them with the text from a TextHandler object
}

void draw() {

  background(100);

  level.display();
  //for (Walldoor wd : wallDoors)
   // wd.display();

  duck.display();

  //tHandle.showText();
  for (Walldoor wd :level.walldoorObjs) {
    if (duck.collision(wd) && !wd.door) {
      duck.ypos = duck.ypos -1; // bounce back, or glide if on the side. Maybe check which if top side is collided or not
      duck.xpos = duck.xpos;
    }
  }
}

void mousePressed() {

  if (wall.pointColCheck(mouseX, mouseY))
    wall.strokeC = 255;
}

void mouseReleased() {

  if (wall.pointColCheck(mouseX, mouseY) || !wall.collided)
    wall.strokeC = wall.c;
}

void keyPressed() {
  if (keyCode == UP)duck.moveUp();
  if (keyCode == DOWN)duck.moveDown();
  if (keyCode == RIGHT)duck.moveRight();
  if (keyCode == LEFT) duck.moveLeft();
}
