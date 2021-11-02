class Interface {
  PFont f1;
  PFont f2;
  PImage main_background;
  PImage ready;
  PImage go;
  PImage pause_img;
  OurFilter filter;

  PVector[] buttonPos;
  PVector[] buttonDim;


  Interface() {
    f1 = createFont("굴림", 50 );
    f2 = createFont("굴림", 20 );
    main_background = loadImage("main_image.png");
    main_background.resize(width, 0);
    filter = new OurFilter();
    pause_img = loadImage("pause.png");
    ready = loadImage("ready.png");
    go = loadImage("go.png");

    //buttonPos = new PVector[]{new PVector(width/3.5, height/2.4), new PVector(width/3.5+380, height/2.4+130), new PVector(266, 877)};
    //buttonDim = new PVector[]{new PVector(180, 50), new PVector(150, 60), new PVector(165, 70)}; //Start/Continue?, Tutorial/Quit? and Next buttons. Pos for position in XY, Dim for dimensions in XY(WH)
  }

  void startScreen() {
    background(100);
    imageMode(CENTER);
    image(main_background, width/2, height/2);
    f1 = createFont("굴림", 50 );
    f2 = createFont("굴림", 30 );
  }
  
  void setReady(){
    imageMode(CENTER);
    image(ready, width/2, height/2);
  }
  
  void setGo(){
    imageMode(CENTER);
    image(go, width/2, height/2);
  }

  void pauseScreen() {
    //background(100);
    imageMode(CENTER);
    image(pause_img, width/2, height/2);
    
    
  }

  void setGameBackground() {
    imageMode(CENTER);
    image(main_background, width/2, height/2);
  }

  void ending() {
    background(100);
    fill(255);

    imageMode(CENTER);
    image(main_background, width/2, height/2);

    textAlign(CENTER);
    textFont(f2);
    text(level.score+"개의 한자어를 찾았습니다!",width/2, height/2-10);
  }

  void tutorial() {
  }

  /*
  boolean buttonCheck(float px, float py) {
   
   if (mouseX>=111 && mouseX<=301 && mouseY >= 379 && mouseY<=465)
   print();
   if (mouseX>=494 && mouseX<=667 && mouseY >= 507 && mouseY<=588)
   print();
   if (mouseX>=266 && mouseX<=431 && mouseY >= 877 && mouseY<=947)
   print();
   
   }
   
   */
}
