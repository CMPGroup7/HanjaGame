class PWindowText{
  String[] p_textLine;
  TextHandler hanja = new TextHandler();

  int wordLen;
  String word;
  String wordMean;
  ArrayList <String> wordDef;
  ArrayList <String> subhanja;  
 
  
  PWindowText(){
    p_textLine = loadStrings("page1_hanja_definition.txt");
    wordDef = new ArrayList<String>();
    subhanja = new ArrayList<String>();
  }
  
  void reset(){
    subhanja.clear();
    wordDef.clear();
  }
  
  void popHanja(int index){
    for(int i = 0; i<p_textLine.length; i++){
      if(p_textLine[i].equals(hanja.hanjaContainer.get(index))){
        word = p_textLine[i];
        wordLen = p_textLine[i].length();
        wordMean = p_textLine[i+1];
        int k = i+2;
        println(p_textLine[i].charAt(0));
        while(p_textLine[k].equals(" ") == false){
          wordDef.add(p_textLine[k]);
          k++;
        }
        if(wordLen>=2){
          int j = k+1;
          while(!p_textLine[j].equals(" ")){
            subhanja.add(p_textLine[j]);
            j++;
          }
        }
        println(word);
        println(wordMean);
        for(int l = 0; l<wordDef.size();l++){
          println(wordDef.get(l));
        }
        for(int t = 0; t<subhanja.size(); t++){
          println(subhanja.get(t));
        }
      }
    }
  }
}
