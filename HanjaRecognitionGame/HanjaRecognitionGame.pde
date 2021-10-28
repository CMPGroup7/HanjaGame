//v1.5 2021-10-25
import processing.sound.*;

PWindow win;
float toH_ratio;
float toW_ratio;
int w, h;

float x = width/2;
float y = height/2;
float wallW = 100;
float wallH = 100;

float toDuckRatio = 1.25;

boolean gameStart = false;
boolean tutorial = false;

SoundFile intro_sound;
SoundFile click;

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
  

  intro_sound = new SoundFile(this, "main_bgm.wav");
  intro_sound.loop();

  click = new SoundFile(this, "click.wav");
}

void draw() {

  background(100);

  if (gameStart == false) { //Game state checks
    startScreen.startScreen();
  }
  if (tutorial == true) {
    startScreen.tutorial();
  }
  if (gameStart == true) {
    //startScreen.setGameBackground();
    level.display();
    duck.display();
    level.collision(); //Collision is detected in the Walldoor objects which are handled by the Level class
  }
  if (duck.pos.y >= height*0.9) {
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
 // println(k); //Uncomment to check keyCode
  switch(k) {

  case UP:
    return duck.up = b;

  case DOWN:
    return duck.down = b;

  case RIGHT:
    return duck.right = b;

  case LEFT:
    return duck.left = b;
    
  case 69:
    return duck.interacting = b;

  default :
    return b;
  }
}

void mousePressed() {
  if (mouseX>=111 && mouseX<=301 && mouseY >= 379 && mouseY<=465) {
    if (gameStart==false&&tutorial == false) {
      startScreen.main_background = loadImage("main_image_start.png");
    }
  }

  if (mouseX>=494 && mouseX<=667 && mouseY >= 507 && mouseY<=588) {
    if (gameStart==false&&tutorial == false) {
      startScreen.main_background = loadImage("main_image_tutorial.png");
    }
  }

  if (mouseX>=266 && mouseX<=431 && mouseY >= 877 && mouseY<=947) {
    if (gameStart==false&&tutorial == true) {
      startScreen.main_background = loadImage("tutorial_1_click.png");
    }
  }
}
void mouseReleased() {
  println(mouseX+","+mouseY);
  if (mouseX>=111 && mouseX<=301 && mouseY >= 379 && mouseY<=465) {
    if (gameStart == false&&tutorial == false) {
      click.play();
      gameStart = true;
      intro_sound.stop();
       startScreen.main_background = loadImage("game_back.png");
      win = new PWindow(); //Initialized last to make sure it can retrieve values
    }
  }

  if (mouseX>=494 && mouseX<=667 && mouseY >= 507 && mouseY<=588) {
    if (gameStart==false&&tutorial == false) {
      click.play();
      tutorial = true;
      startScreen.main_background = loadImage("tutorial_1.png");
    }
  }

  if (mouseX>=266 && mouseX<=431 && mouseY >= 877 && mouseY<=947) {
    if (gameStart==false&&tutorial == true) {
      click.play();
      tutorial = false;
      startScreen.main_background = loadImage("main_image.png");
    }
  }
}
