//class for popup window
class PWindow extends PApplet {
 
  PFont f ;
  PWindowText popText;
  
  Table sprSheet;
  String tablePath;
  float sXY;
  float pwX, pwY;
  float spacing;
  float repeatSpacing;

  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(640, 640);
    tablePath = "D:\\Documents\\ProcessingProjects\\HanjaGame\\HanjaRecognitionGame\\dict_file.tsv"; //Problem with file path. Had to use whole path
  }

  void setup() {
    sprSheet = loadTable(tablePath, "header");
    background(100);
    f = createFont("굴림", 20);
    textFont(f);
    textAlign(LEFT, CENTER);
    popText = new PWindowText();
  
    pwX = level.fontSize;
    pwY = level.fontSize;
    spacing = level.lineSpacing;
   
  }

  void draw() {
    background(100);
    if (popText.index > -1) { //Checks so that PWindowText
   
      textAlign(LEFT);
      text(popText.expHanja+"    ["+ popText.expHangul+"]\n"+ popText.expDef+"\n\n"+popText.subHanja.get(0)+"\n"+ popText.subHanjaDef.get(0), pwX, pwY);
 
    }
  }

  void popIt(int p_index) { //Takes index of row, being hanjaGroupIndex

    popText =  new PWindowText(sprSheet.getRow(p_index), p_index);  //Send TableRow and index of that row for storing in PWindowText object (popText)

  }

  void reset() { //Re-initializes popText so index is -1,
    popText = new PWindowText();
  }

}
