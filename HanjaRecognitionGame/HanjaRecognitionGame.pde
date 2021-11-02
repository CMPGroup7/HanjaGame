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

boolean gameStart;
boolean tutorial;
boolean pause;
boolean end;
boolean ready;
boolean startGameEffect;
boolean restart;

int savedTime;
int passedTime;


SoundFile intro_sound;
SoundFile game_sound;
SoundFile click;
SoundFile ring;
SoundFile narration;
SoundFile ending_sound;
SoundFile readygo;
SoundFile goTop;

Duck duck;
Level level;
Interface Screen;



void setup() {

  gameStart = false;
  tutorial = false;
  pause = false;
  end = false;
  ready = false;
  startGameEffect = false;
  restart = false;

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

  tablePath = this.dataPath("dict_file.tsv"); //Problem with file path. Had to use initialize here instead of PWindow. Something with inheritance from PApplet sets path to install path.

  level = new Level(w, h); //Adds Walldoor objects and combines them with the text from a TextHandler object. Must be initialized first since PWindow needs it.
  duck = new Duck(level.fontSize*toDuckRatio); //Calls Duck to be constructed with pW in width (s1 = pW)
  Screen = new Interface();

  intro_sound = new SoundFile(this, "main_bgm.wav");
  intro_sound.loop();
  game_sound = new SoundFile(this, "game_bgm.wav");
  narration = new SoundFile(this, "narration.wav");
  ending_sound = new SoundFile(this, "ending_bgm.wav");

  click = new SoundFile(this, "click.wav");
  ring  = new SoundFile(this, "ring.wav");
  readygo = new SoundFile(this, "ready_go.wav");
  goTop = new SoundFile(this, "fail.wav");

  savedTime = millis();
}

void resetup() {

  gameStart = false;
  tutorial = false;
  pause = false;
  end = false;
  ready = false;
  startGameEffect = false;
  restart = false;


  tablePath = this.dataPath("dict_file.tsv"); //Problem with file path. Had to use initialize here instead of PWindow. Something with inheritance from PApplet sets path to install path.

  level=null;
  duck = null;
  Screen = null;
  
  level = new Level(w, h);
  duck = new Duck(level.fontSize*toDuckRatio); //Calls Duck to be constructed with pW in width (s1 = pW)
  Screen = new Interface();

  intro_sound.loop();
  
}

void draw() {

  background(100);

  if (gameStart == false) { //Game state checks
    Screen.startScreen();
  }

  if (gameStart == true) {
    Screen.setGameBackground();

    passedTime = millis()-savedTime;

    if (passedTime<2500) {
      if (ready == false) {
        readygo.play();
        ready = true;
      }
      Screen.setReady();
    } else if (passedTime<4500) {
      Screen.setGo();
    } else {
      if (startGameEffect==false) {
        //게임 사운드 스타트
        game_sound.loop();
        //팝업윈도우 이제 열기
        if (win==null) win = new PWindow(); //Initialized last to make sure it can retrieve values
        win.popup_back = loadImage("popup_background.png");
        //나레이션 실행하기
        narration.cue(0);
        narration.play();
        startGameEffect = true;
      }
      level.display();
      duck.display();
      level.collision(); //Collision is detected in the Walldoor objects which are handled by the Level class
    }
   
  }
  if (pause) {
    Screen.pauseScreen(); //Glitchy
    //noLoop();
  }

  if (gameStart==true && duck.pos.y >= height*0.9) {
    if (end==false) {
      end= true;
      Screen.main_background = loadImage("ending.png");
      game_sound.stop();
    }
    Screen.ending();
  }
  
  if(restart){
    if(!goTop.isPlaying()){
      goTop.play();
    }
    restart = false;
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
      
  case 78: //N key to restart narration
    if(pause==false){
      if(!narration.isPlaying()){
        narration.cue(0);
        narration.play();
      }
      return duck.interacting = b;
    } 
    
  case 77: //M key to mute narration
    if(!pause){
      narration.stop();
      return duck.interacting = b;
    } 
    
  case 8: //Backspace to pause //Uncomment for glitchy OurFilter. PLEASE FIX, I think manipulating an image is required. I'll ask the professor in the group as well
    if (b){
      Screen.pause_img = loadImage("pause.png");
      if(pause) narration.play();
      if(!pause) narration.pause();
      return pause = !pause;
    }

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
  if (pause==true) {
    if (mouseX>=116 && mouseX<=350 && mouseY >= 407 && mouseY<=465) {
      Screen.pause_img = loadImage("pause_continue.png");
    }
    if (mouseX>=113 && mouseX<=348 && mouseY >= 525 && mouseY<=581) {
      Screen.pause_img = loadImage("pause_quit.png");
    }
  }
}

void mouseReleased() {
  //println(mouseX+","+mouseY);
  if (gameStart == false&&tutorial == false) {
    if (mouseX>=111 && mouseX<=301 && mouseY >= 379 && mouseY<=465) {
      click.play();
      savedTime = millis();
      gameStart = true;
      //narration.play();
      //narration.loop();
      intro_sound.stop();
      Screen.main_background = loadImage("game_back.png");
      Screen.main_background.resize(width, 0);
    }
    if (mouseX>=494 && mouseX<=667 && mouseY >= 507 && mouseY<=588) {
      click.play();
      tutorial = true;
      Screen.main_background = loadImage("tutorial.png");
      Screen.main_background.resize(width, 0);
    }
  }

  //if (gameStart && pause && !tutorial) {
  //  if (mouseX>=111 && mouseX<=301 && mouseY >= 379 && mouseY<=465) {
  //    pause = !pause;
  //  }
  //  if (mouseX>=494 && mouseX<=667 && mouseY >= 507 && mouseY<=588) {
  //    exit();
  //  }
  //}

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
      resetup();
      Screen.main_background = loadImage("main_image.png");
      Screen.main_background.resize(width, 0);
    }
  }

  if (pause==true) {
    if (mouseX>=116 && mouseX<=350 && mouseY >= 407 && mouseY<=465) {
      click.play();
      pause = false;
      narration.play();
    }
    if (mouseX>=113 && mouseX<=348 && mouseY >= 525 && mouseY<=581) {
      click.play();
      game_sound.stop();
      narration.stop();
      resetup();
      Screen.main_background = loadImage("main_image.png");
      Screen.main_background.resize(width, 0);
    }
  }
}
