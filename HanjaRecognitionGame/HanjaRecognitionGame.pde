//v1.4 2021-10-20

float toH_ratio;
float toW_ratio;
int w, h;

float x = width/2;
float y = height/2;
float wallW = 100;
float wallH = 100;

float toDuckRatio = 1.786;

ArrayList<Walldoor> wallDoors;

boolean gameStart = false;

Walldoor wall, door;
Duck duck;
Level level;
Interface main, ending;

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

  win = new PWindow();
  level = new Level(w, h); //Adds Walldoor object and combines them with the text from a TextHandler object
  duck = new Duck(level.fontSize*toDuckRatio); //Calls Duck to be constructed with pW in width (s1 = pW)
  main = new Interface();
  ending = new Interface();
}

void draw() {

  background(100);

  if (gameStart == false) {
    main.main();
  }
  if (gameStart == true) {

    level.display();

    duck.display();

    for (Walldoor wd : level.walldoorObjs) {
      duck.collision(wd);
    }
  }
  if (duck.pos.y >= height*0.9){
    ending.ending();
  }

}

void mousePressed() {
}

void mouseReleased() {
}

void keyPressed() {
  //if(!duck.collided)
  keyCheck(keyCode, true);

  gameStart = true;
}

void keyReleased() {
  keyCheck(keyCode, false);
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
