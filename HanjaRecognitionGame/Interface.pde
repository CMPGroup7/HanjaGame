class Interface {
  PFont f1;
  PFont f2;
  PImage main_background;


  Interface() {
    f1 = createFont("굴림", 50 );
    f2 = createFont("굴림", 20 );
    main_background = loadImage("main_image.png");
  }

  void startScreen() {
    background(100);
    imageMode(CENTER);
    image(main_background, width/2, height/2, width, height);
    f1 = createFont("굴림", 50 );
    f2 = createFont("굴림", 20 );
    //textFont(f1);
    //textAlign(CENTER, CENTER);
    //text("한자어찾기", width/2, height/2-100);
    //textFont(f2);
    //text("시작하려면 아무 키나 누르세요", width/2, height/2+100);
  }

  void setGameBackground() {
    imageMode(CENTER);
    image(main_background, width/2, height/2, width, height);
  }

  void ending() {
    background(100);
    fill(255);
    narration.stop();
    intro_sound.stop();
//    ending_sound.play();    the sound cracks on my computer for some reason..

    textAlign(CENTER);
    textFont(f2);
    text(level.score+"개의 한자어를 찾았습니다!", width/2, height/2);
  }

  void tutorial() {
  }
}
