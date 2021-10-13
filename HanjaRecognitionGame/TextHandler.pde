class TextHandler {

  //Divide screen into grid(?) At least special characters like tab-indentations and line breaks "/n" should be saved.
  
  //The size of a single grid is textBound*textBound.
  //Automatically, the tab is replaced by a space, and the enter is not performed.
  
  int textBound = 30; //하나의 글자가 30*30을 차지한다.
  int cols, rows;
  String[] textLine;

  int ent = 2; // 텍스트 출력 전 위로 몇 칸 띄우는지
  int spa = 1; // 텍스트 출력 전 앞뒤로 몇 칸 띄우는지
  int road = 2; // line 사이의 간격 +1

  int wholeLen; //전체 텍스트의 길이
  String n;
  ArrayList<Character> text; //한자를 제외한 전체 텍스트를 담은 char형 arraylist
  ArrayList<Integer> hanjaOrder; //각 음절이 한자어에 포함이 안되면 -1, 한자가 있으면 저장된 arraylist의 index를 저장한다.
  ArrayList<String> hanjaArr; //한자가 저장된 string type 배열

  boolean isHanja = false;
  boolean hanjaStart = false;

  int hanjaCnt = 0;

  String word;

  PFont f;


  TextHandler() {
    text = new ArrayList<Character>();
    hanjaOrder = new ArrayList<Integer>();
    hanjaArr = new ArrayList<String>();
    textLine = loadStrings("page1.txt"); //page1.txt에서 한줄씩 끊어서 chars 배열에 저장

    /*
    각 line을 순서대로 돌면서 모든 음절을 쪼갠다. 
    Split all syllables by turning each line in order.
    */
    for (int i = 0; i<textLine.length; i++) { 
      n = textLine[i];
      for (int j = 0; j < n.length(); j++) {
        //println(n.charAt(j));
        text.add(n.charAt(j));
      }
      wholeLen += n.length();
    }

  /*
  text 배열에서 한자와 괄호를 제거하고, 한자 단어를 hanjaArr에 저장한다. 
  hanjaArr에는 해당 index의 글자가 한자어에 포함되는지, 
  한자어라면 hanjaArr의 몇 번째 index에 해당 한자가 저장되어있는지를 저장한다. 
  (한자어에 포함되는 음절이면, hanjaArr의 index 저장. 한자어에 포함되지 않는 음절이면 -1 저장)
  Remove 한자 and parentheses from the 'text' array, and store 한자 words in hanjaArr. 
  HanjaArr stores whether the letters of the index are included in 한자어, 
  and if so, in which index of HanjaArr is stored. 
  (If it is a syllable included in 한자어, store the index of hanjaArr. 
  If it's a syllable that's not included in 한자어, save -1)
  */
    for (int i = 0; i<wholeLen; i++) {
      hanjaOrder.add(-1);
    }

    for (int i = 0; i<text.size(); i++) {
      if (text.get(i) == '(') {
        isHanja = true;
        hanjaStart = true;
        text.remove(i);
        hanjaOrder.remove(i);
        wholeLen--;
        //i--;
      }
      if (text.get(i) == ')') {
        isHanja = false;
        text.remove(i);
        hanjaOrder.remove(i);
        wholeLen--;

        int count = word.length();
        for (int j = count; j>0; j--) {
          hanjaOrder.set(i-j, hanjaCnt);
        }
        hanjaArr.add(word);
        hanjaCnt++;
        i--;
      }

      if (isHanja == true) {
        if (hanjaStart == true) {
          word = text.get(i).toString();
          hanjaStart = false;
          text.remove(i);
          hanjaOrder.remove(i);
          wholeLen--;
          i--;
        } else {
          word+=text.get(i);
          text.remove(i);
          hanjaOrder.remove(i);
          wholeLen--;
          i--;
        }
      }
    }
    for (int i = 0; i<hanjaCnt; i++) {
      println(hanjaArr.get(i));
    }
    for (int i = 0; i<text.size(); i++) {
      print(text.get(i));
    }
    //println(wholeLen+","+text.size()+","+hanjaOrder.size());
    //println(hanjaOrder.get(41));
    //println(hanjaArr.get(hanjaOrder.get(41)));

    /*
    그리드의 column개수와 row개수를 계산한다.
    Calculate the number of columns and rows of the grid.
    */
    cols = width/textBound;
    rows = height/textBound;
    f = createFont("굴림", 30);
  }

  void showText() {  // A function that shows the text in the window
    int charcount = 0;
    /*
    ent-1의 값만큼 위의 공백을 만들고, spa 값 만큼 좌우 공백을 만들어 텍스트를 보여줄 범위를 지정한다.
    지정한 범위 내에서 텍스트를 보여준다.
    Create the above space as much as the value of the ent-1, 
    and create the left and right spaces as much as the spa value to specify the range to show the text.
    It shows the text within the specified range.
    */
    for (int j = ent; j<rows; j+=road) {
      for (int i = spa; i<cols-spa; i++) {
        int x = i*textBound;
        int y = j*textBound;

        color c = 255;

        textFont(f);
        fill(c);

        text(text.get(charcount), x, y);
        charcount = charcount+1;
        if (charcount >= wholeLen) break;
      }
      if (charcount>=wholeLen) break;
    }
  }
}
