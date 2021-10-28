class Level {

  TextHandler textObjs;
  ArrayList<Walldoor> walldoorObjs;

  // initLinePos-1의 값만큼 위의 공백을 만들고, spaceW 값 만큼 좌우 공백을 만들어 텍스트를 보여줄 범위를 지정한다.
  //   지정한 범위 내에서 텍스트를 보여준다.
  public int fontSize = 30; //하나의 글자가 30*30을 차지한다. The size of a single syllabl is fontSize*fontSize.
  public int initLinePos = 2; // 텍스트 출력 전 위로 몇 칸 띄우는지
  public int spaceW = 1; // 텍스트 출력 전 앞뒤로 몇 칸 띄우는지 Tab is replaced by spaces
  public int lineSpacing = fontSize/10; // line 사이의 간격 +1
  int cols;
  int rows;
  PFont f;
  public int score = 0;
  public int totalHanja;
  int totCol = 0;
  

  Level(int w, int h) {
    f = createFont("굴림", fontSize);
    textObjs = new TextHandler();
    walldoorObjs = new ArrayList<Walldoor>();

    // 그리드의 column개수와 row개수를 계산한다.
    // Calculate the number of columns and rows of the grid.
    cols = w/fontSize;
    rows = h/fontSize;

    boolean[] prevHanja = {false, false};
    boolean isHanja= false;

    int curSyl = 0; //Initialize index to check textObjs.text with
    for (int rowY = initLinePos; curSyl < textObjs.text.size(); rowY+= lineSpacing) {
      for (int colX = spaceW; colX < cols-spaceW; colX++) { //Same idea as previous TextHandler.showText()

        float sylX = colX*fontSize;
        float sylY = rowY*fontSize;
        
        if(isHanja){
          prevHanja[curSyl % prevHanja.length] = true;
        }
        
        if (textObjs.hanjaContainer.get(curSyl) instanceof Character) {
          isHanja = true;
        }else{
          isHanja = false;
        }

        if (isHanja){
          totalHanja++;
          walldoorObjs.add(new Walldoor(textObjs.text.get(curSyl), textObjs.hanjaContainer.get(curSyl).toString().charAt(0), sylX, sylY, fontSize, curSyl, textObjs.hanjaGroupIndex.get(curSyl), true));
        }else if (!isHanja)
          walldoorObjs.add(new Walldoor(textObjs.text.get(curSyl), ' ', sylX, sylY, fontSize, curSyl, -1, false));  //Constructor explained in Walldoor

        if(isHanja && !prevHanja[0] && prevHanja[1]){
          walldoorObjs.get(curSyl-1).excPass = true;
          walldoorObjs.get(curSyl-2).excPass = true;
        }
       
        curSyl++;

        if (curSyl>=textObjs.text.size())
          break;
      }
      if (curSyl>=textObjs.text.size())
        break;
    }
  }


  void display() {
    textFont(f);
    score = totCol;
    totCol = 0;
    for (Walldoor walldoor : walldoorObjs){
      walldoor.display();
      if(walldoor.collidedOnce == true && walldoor.door){
        totCol++;
      }
    }
    //score += totCol; //Forever and ever
    rectMode(CENTER);
    noStroke();
    fill(255);
    textAlign(CENTER);
    rect(width/2, height*0.9, width, 5);//finish line
    text("도착 到着", width/2, height*0.93);
    textAlign(RIGHT);
    text("Found Hanja: "+score+"/"+totalHanja+"", width, height*0.98);
    
  }

  void collision() {
    
    for (int i = 0; i < walldoorObjs.size(); i++) {
      Walldoor wd = walldoorObjs.get(i);
      duck.collision(wd); //Sends every Walldoor object to Duck object to return a float to duck.pos.y depending on if it collided or not

      if (wd.door && wd.collided && wd.interaction)
         win.popIt(wd.indices[1]); //Pops Sino-korean word if door and collided is true and stores it as a PWindowText object in PWindow
      
    }
  }
}
