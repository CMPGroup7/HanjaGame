class TextHandler {
  
  //Divide screen into grid(?) At least special characters like tab-indentations and line breaks "/n" should be saved.
  
  int count = 0;  //number of hanja words
  String[] textLine = loadStrings("page1.txt");  //input text with hanja
  String[] represent;  //input text without hanja
  String[] words;  // buffer for parsing hanja and hangul words
  ArrayList<String>Hangul = new ArrayList<>();  // arraylist for storing hangul words
  ArrayList<String>Hanja = new ArrayList<>();   // arraylist for storing hanja words
  
  ArrayList<String>[] syllables; //Contained syllables in text containing Hanja. Psuedo-code showing idea: syllables[count]

  TextHandler() {
    /*Parse Hangul and Hanja from the string 'data' and save them in each array list(Hangul, Hanja).*/
    for (int i = 0; i < textLine.length; i++) {
      words = textLine[i].split(" ");
      for (int j = 0; j<words.length; j++) {
        if (words[j].contains("(")) {
          String hangul = words[j].split("\\(")[0];
          Hangul.add(hangul);
          String hanja = words[j].split("\\(|\\)")[1];
          Hanja.add(hanja);
          count++;
        }
      } 
    }

    for(int i = 0; i<count; i++){
      println(Hangul.get(i)+", "+Hanja.get(i));
    }
    /*Save strings except Hanja in a string list 'represent'.*/
    represent = textLine;

    for (int i = 0; i<represent.length; i++) {
      represent[i] = represent[i].replaceAll("\\(|\\)", "");
      for (int j = 0; j<count; j++) {
        if (represent[i].contains(Hanja.get(j))) {
          represent[i] = represent[i].replaceAll(Hanja.get(j), "");
        }
      }
    }

    //for (int k = 0; k<represent.length; k++) {
    //  println(represent[k]);
    //  println("\n");
    //}
  }
}
