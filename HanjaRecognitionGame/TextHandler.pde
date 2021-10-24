class TextHandler {

  int cols, rows;
  String[] textLine;

  int wholeLen; //전체 텍스트의 길이
  String n;
  ArrayList<Character> text; //한자를 제외한 전체 텍스트를 담은 char형 arraylist
  ArrayList<Object> hanjaContainer; //각 음절이 한자어에 포함이 안되면 Object instance of Boolean type, 한자가 있으면 Object instance of Character type를 저장한다.

  boolean isHanja = false;
  int hanjaCnt = 0;

  TextHandler() {
    text = new ArrayList<Character>();
    hanjaContainer = new ArrayList<Object>();
    textLine = loadStrings("page1.txt"); //page1.txt에서 한줄씩 끊어서 chars 배열에 저장

    /*
     각 line을 순서대로 돌면서 모든 음절을 쪼갠다.
     Split all syllables by turning each line in order.
     */

    for (int i = 0; i<textLine.length; i++) {
      n = textLine[i];
      for (int j = 0; j < n.length(); j++) {

        text.add(n.charAt(j));
        hanjaContainer.add(false);
      }
      wholeLen += n.length();
    }

    /*
     Remove 한자 and parentheses from the 'text' array, and store 한자 words in hanjaContainer.
     hanjaContainer stores whether the letters of the index are included in 한자어,
     and if so, in which index of hanjaContainer is stored.
     (If it is a syllable included in 한자어 store 한자 as a char.
     If the syllable doesn't have 한자, default Object type is a Boolean with a value of false)
     */

    int indexStart = -1;
    int indexEnd =-1;
    int stEndDiff = 0;
    for (int i = 0; i<text.size(); i++) {

      if (text.get(i) == '(') {

        isHanja = true;
        indexStart= i;
        //println(indexStart);
        text.remove(i);// Removes at "i" so following hanja therefore starts at "i"
        hanjaContainer.remove(i);
        wholeLen--;
        i--;
      } else if (text.get(i) == ')') {

        isHanja = false;
        indexEnd = i-1;
        stEndDiff = indexEnd - indexStart;
        text.remove(i);
        hanjaContainer.remove(i);
        wholeLen--;
        i--;

        for (int j = indexEnd; j>indexStart; j--) {
          hanjaContainer.set(indexEnd-j, n.charAt(j)); //StringIndexOutOfBoundsException: index 45,length 34
        }

        hanjaContainer.subList(indexStart-stEndDiff, indexEnd-stEndDiff).clear(); //Removes hangul behind
        text.subList(indexStart, indexEnd).clear(); //Removes hanja in-front
        i-=stEndDiff; //Removes from loop i iteration value
        wholeLen-=stEndDiff; //Removes from whole length

        indexStart = -1; //Reset
        indexEnd = -1; //Reset
        hanjaCnt++; //Adds as one whole word to hanjaCnt
      }
    }
    for (int i = 0; i<hanjaCnt; i++) {
      println(hanjaContainer.get(i));
    }
    for (int i = 0; i<text.size(); i++) {
      print(text.get(i));
    }
  }
}
