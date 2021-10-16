class PTextHandler{
  String[] PtextLine;
  TextHandler hanja = new TextHandler();

  int wordLen;
  String word;
  String wordMean;
  ArrayList <String> wordDef;
  ArrayList <String> subhanja;  
 
  
  PTextHandler(){
    PtextLine = loadStrings("page1_hanja_definition.txt");
    wordDef = new ArrayList<String>();
    subhanja = new ArrayList<String>();
  }
  
  void reset(){
    subhanja.clear();
    wordDef.clear();
  }
  
  void popHanja(int index){
    for(int i = 0; i<PtextLine.length; i++){
      if(PtextLine[i].equals(hanja.hanjaArr.get(index))){
        word = PtextLine[i];
        wordLen = PtextLine[i].length();
        wordMean = PtextLine[i+1];
        int k = i+2;
        println(PtextLine[i].charAt(0));
        while(PtextLine[k].equals(" ") == false){
          wordDef.add(PtextLine[k]);
          k++;
        }
        if(wordLen>=2){
          int j = k+1;
          while(!PtextLine[j].equals(" ")){
            subhanja.add(PtextLine[j]);
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
