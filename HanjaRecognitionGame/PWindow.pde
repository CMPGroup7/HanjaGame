//class for popup window
class PWindow extends PApplet {
  PFont f ;
  ArrayList<PWindowText> popText;
  PWindowText displayText;
  Table sprSheet;
  ArrayList<Integer> poppedIndices;
  String tablePath;
  float pwX, pwY;
  
  
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(640, 640);
    tablePath = "D:\\Documents\\ProcessingProjects\\HanjaGame\\HanjaRecognitionGame\\dict_file.tsv"; //Problem with file path. Had to use whole path
  }

  void setup() {
    sprSheet = loadTable(tablePath);
    background(100);
    f = createFont("굴림", 20);
    textFont(f);
    textAlign(LEFT, CENTER);
    popText = new ArrayList<PWindowText>();
    displayText = new PWindowText();
    pwX = level.fontSize; 
    pwY = level.fontSize;
  }

  void draw() {
    background(100);  
    if(popText.size()>0){
      text(displayText.expHanja, pwX, pwY);
      text(displayText.expHangul, pwX, pwY+(level.fontSize*2));
      text(displayText.expDef, pwX, pwY*4);
   }
  }

  void popIt(int p_index) {
    
    PWindowText pwText = new PWindowText();
    boolean popped = false;
    
    for(int i = 0; i < popText.size(); i++){
      pwText = popText.get(i); 
      if (pwText.index == p_index){
        popped = true;
        break;
      }  
    }
    
    if(popText.size() > 0 && !popped){
        popText.add(new PWindowText(sprSheet.getRow(p_index), p_index)); 
    }else if(popText.size() > 0 && popped)
        popText.get(p_index);
    
    //detect which 한자어 does duck collide with and find index number of hanjaArr matching with that 한자어.
    //if this method is implemented well, delete 'poptext.popHanja(index);' in setup().

    //index = save index number;
    //poptext.reset();
    //poptext.popHanja(index);
  }

  //code for testing whether all hanja definition is saved and represent well.
  //void mousePressed() {
  //  if (index<poptext.hanja.hanjaArr.size()-1) {
  //    index++;
  //    poptext.reset();
  //    poptext.popHanja(index);
  //  }
  //}
}
