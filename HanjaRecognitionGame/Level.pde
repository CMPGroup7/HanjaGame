class Level {

  TextHandler textObjs;
  ArrayList<Walldoor> walldoorObjs;
  int fontSize = 30;
  int initLinePos = 2; // 텍스트 출력 전 위로 몇 칸 띄우는지
  int spaceW = 1; // 텍스트 출력 전 앞뒤로 몇 칸 띄우는지
  int lineSpacing = 2; // line 사이의 간격 +1
  int cols;
  int rows;

  Level(int w, int h) {
    textObjs = new TextHandler();
    walldoorObjs = new ArrayList<Walldoor>();
    cols = w/fontSize;
    rows = h/fontSize;
    
    int curSyl = 0; //Initialize index to check textObjs.text with
    for (int y = initLinePos; y < textObjs.text.size(); y++) {
      for (int x = spaceW; x <cols-spaceW; x++) { //Same idea as TextHandler.showText()
        
        float sylX = x*fontSize;
        float sylY = y*fontSize;
        boolean isHanja = false;
        
        for (int hanjaSyllable : textObjs.hanjaIndex.subList(curSyl, textObjs.hanjaIndex.size())) {
          if (curSyl == hanjaSyllable) {
            isHanja = true;
            break;
          }
        }
        
        if(isHanja)
           walldoorObjs.add(new Walldoor(textObjs.text.get(curSyl), sylX, sylY, fontSize, curSyl, true));
        else if (!isHanja)
           walldoorObjs.add(new Walldoor(textObjs.text.get(curSyl), sylX, sylY, fontSize, curSyl, true)); 
        
        curSyl++;
        
        if(curSyl>=textObjs.text.size())
           break;
      }
    if(curSyl>=textObjs.text.size())
      break;
    }

    //for (int i = ind_st; i<=ind_end; i++)
    // sText+=""+textObj.text.get(i);
  }
  
  void display(){
    for(Walldoor walldoors : walldoorObjs)
      walldoors.display();
  }
  
}
