//v1.5 2021-10-25
import processing.sound.*;

PWindow win;
String tablePath;
float toH_ratio;
float toW_ratio;
int w, h;

float x = width/2;
float y = height/2;
float wallW = 100;
float wallH = 100;

float toDuckRatio = 1.0;

boolean gameStart = false;
boolean tutorial = false;
boolean pause = false;
boolean end = false;

SoundFile intro_sound;
SoundFile click;
SoundFile ring;
SoundFile narration;
SoundFile ending_sound;

Duck duck;
Level level;
Interface Screen;

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
  tablePath = this.dataPath("dict_file.tsv"); //Problem with file path. Had to use initialize here instead of PWindow. Something with inheritance from PApplet sets path to install path.

  level = new Level(w, h); //Adds Walldoor objects and combines them with the text from a TextHandler object. Must be initialized first since PWindow needs it.
  duck = new Duck(level.fontSize*toDuckRatio); //Calls Duck to be constructed with pW in width (s1 = pW)
  Screen = new Interface();
  //ending = new Interface();

  intro_sound = new SoundFile(this, "main_bgm.wav");
  intro_sound.loop();
  narration = new SoundFile(this, "narration.wav");
  ending_sound = new SoundFile(this, "ending_bgm.wav");

  click = new SoundFile(this, "click.wav");
  ring  = new SoundFile(this, "ring.wav");
  
  
}

void draw() {

  background(100);

  if (gameStart == false) { //Game state checks
    Screen.startScreen();
  }
  //if (tutorial == true) {
  //  startScreen.tutorial();
  //}

  if (gameStart == true) {
    Screen.setGameBackground();
    level.display();
    duck.display();
    level.collision(); //Collision is detected in the Walldoor objects which are handled by the Level class
  }
  if (pause) {
    Screen.pauseScreen(); //Glitchy
    //noLoop();
  }

  if (gameStart==true && duck.pos.y >= height*0.9) {
    if(end==false){
      end= true;
      Screen.main_background = loadImage("ending.png");
    }
    Screen.ending();
  }
}

void keyPressed() {

  keyCheck(keyCode, true); //Sets values

  gameStart = true;
}

void keyReleased() {
  if (!pause)
    keyCheck(keyCode, false); //Resets values
}

boolean keyCheck(int k, boolean b) {
  //  println(k); //Uncomment to check keyCode
  switch(k) {

  case UP:
    if (!pause)
      return duck.up = b;

  case DOWN:
    if (!pause)
      return duck.down = b;

  case RIGHT:
    if (!pause)
      return duck.right = b;

  case LEFT:
    if (!pause)
      return duck.left = b;

  case 69: //E key
    if (!pause)
      return duck.interacting = b;

  case 8: //Backspace to pause //Uncomment for glitchy OurFilter. PLEASE FIX, I think manipulating an image is required. I'll ask the professor in the group as well
    if (b)
      return pause = !pause;

  default :
    return b;
  }
}

void mousePressed() {
  println(mouseX+","+mouseY);
  if (gameStart==false&&tutorial == false) {
    if (mouseX>=111 && mouseX<=301 && mouseY >= 379 && mouseY<=465) {
      Screen.main_background = loadImage("main_image_start.png");
      Screen.main_background.resize(width, 0);
    }
  }
  if (gameStart==false&&tutorial == false) {
    if (mouseX>=494 && mouseX<=667 && mouseY >= 507 && mouseY<=588) {
      Screen.main_background = loadImage("main_image_tutorial.png");
      Screen.main_background.resize(width, 0);
    }
  }
  if (gameStart==false&&tutorial == true) {
    if (mouseX>=232 && mouseX<=466 && mouseY >= 876 && mouseY<=947) {
      Screen.main_background = loadImage("tutorial_click.png");
      Screen.main_background.resize(width, 0);
    }
  }
  if (end==true&&gameStart==true) {
    if (mouseX>=256 && mouseX<=451 && mouseY >= 656 && mouseY<=714) {
      Screen.main_background = loadImage("ending_click.png");
      Screen.main_background.resize(width, 0);
    }
  }
}

void mouseReleased() {
  //println(mouseX+","+mouseY);
  if (gameStart == false&&tutorial == false) {
    if (mouseX>=111 && mouseX<=301 && mouseY >= 379 && mouseY<=465) {
      click.play();
      gameStart = true;
      narration.play();
      //narration.loop();
      Screen.main_background = loadImage("game_back.png");
      Screen.main_background.resize(width, 0);
      if(win==null) win = new PWindow(); //Initialized last to make sure it can retrieve values
      win.popup_back = loadImage("popup_background.png");
    }
    if (mouseX>=494 && mouseX<=667 && mouseY >= 507 && mouseY<=588) {
      click.play();
      tutorial = true;
      Screen.main_background = loadImage("tutorial.png");
      Screen.main_background.resize(width, 0);
    }
  }

  if (gameStart && pause && !tutorial) {
    if (mouseX>=111 && mouseX<=301 && mouseY >= 379 && mouseY<=465) {
      pause = !pause;
    }
    if (mouseX>=494 && mouseX<=667 && mouseY >= 507 && mouseY<=588) {
      exit();
    }
  }

  if (gameStart==false&&tutorial == true) {
    if (mouseX>=232 && mouseX<=466 && mouseY >= 876 && mouseY<=947) {
      click.play();
      tutorial = false;
      Screen.main_background = loadImage("main_image.png");
      Screen.main_background.resize(width, 0);
    }
  }
  if (end==true&&gameStart==true) {
    if (mouseX>=256 && mouseX<=451 && mouseY >= 656 && mouseY<=714) {
      click.play();
      intro_sound.loop();
      duck.pos = new PVector(width / 2, 10);
      end =false;
      gameStart=false;
      tutorial = false;
      Screen.main_background = loadImage("main_image.png");
      Screen.main_background.resize(width, 0);
    }
  }
}
