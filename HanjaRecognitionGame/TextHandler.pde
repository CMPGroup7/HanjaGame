class TextHandler {

  int cols, rows;
  String[] textLine;

  int wholeLen; //전체 텍스트의 길이
  String n;
  ArrayList<Character> text; //한자를 제외한 전체 텍스트를 담은 char형 arraylist
  ArrayList<Integer> hanjaIndex; //각 음절이 한자어에 포함이 안되면 -1, 한자가 있으면 저장된 arraylist의 index를 저장한다.
  ArrayList<String> hanjaArr; //한자가 저장된 string type 배열

  boolean isHanja = false;
  boolean hanjaStart = false;

  int hanjaCnt = 0;
  String word;

  TextHandler() {
    text = new ArrayList<Character>();
    hanjaIndex = new ArrayList<Integer>();
    hanjaArr = new ArrayList<String>();

    textLine = loadStrings("page1.txt"); //page1.txt에서 한줄씩 끊어서 chars 배열에 저장

    /*
     각 line을 순서대로 돌면서 모든 음절을 쪼갠다.
     Split all syllables by turning each line in order.
     */
    for (int i = 0; i<textLine.length; i++) {
      n = textLine[i];
      for (int j = 0; j < n.length(); j++) {

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
     hanjaArr stores whether the letters of the index are included in 한자어,
     and if so, in which index of hanjaArr is stored.
     (If it is a syllable included in 한자어, store the index of hanjaArr.
     If it's a syllable that's not included in 한자어, save -1)
     */
    for (int i = 0; i<wholeLen; i++) {
      hanjaIndex.add(-1);
    }

    for (int i = 0; i<text.size(); i++) {
      if (text.get(i) == '(') {
        isHanja = true;
        hanjaStart = true;
        text.remove(i);
        hanjaIndex.remove(i);
        wholeLen--;
        //i--;
      }
      if (text.get(i) == ')') {
        isHanja = false;
        text.remove(i);
        hanjaIndex.remove(i);
        wholeLen--;

        int count = word.length();
        for (int j = count; j>0; j--) {
          hanjaIndex.set(i-j, hanjaCnt);
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
          hanjaIndex.remove(i);
          wholeLen--;
          i--;
        } else {
          word+=text.get(i);
          text.remove(i);
          hanjaIndex.remove(i);
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

  }

  //text shakes and chages color when duck is around
  // if ((Math.abs(duck.getXpos() - x) <= (duck.duckW/2 + textBound/2) )&&(Math.abs(duck.getYpos() - y) <= (duck.duckH/2 + textBound/2) )) {

  //  x = x + (int) random(-10, 10);
  //   y = y + (int) random(-10, 10);
  //   fill(255, 255, 0);
  //   text(text.get(charcount), x, y);
}
