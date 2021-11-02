//class for popup window

class PWindow extends PApplet {

  PFont f ;
  PWindowText popText;
  PImage popup_back;

  Table sprSheet;
  //String data
  float sXY;
  float pwX, pwY;
  float mpwX, mpwY;
  float spacing;
  float repeatSpacing;

  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
   
  }

  void settings() {
    size(640, 640);
    
  }

  void setup() {
    sprSheet = loadTable(tablePath, "header");
    background(100);
    f = createFont("굴림", 20);
    textFont(f);
    textAlign(LEFT, CENTER);
    popText = new PWindowText();

    pwX = level.fontSize*2;
    pwY = level.fontSize;


    mpwX = level.fontSize*2;
    mpwY = level.fontSize *12;
  }

  void draw() {
    background(200);
    this.imageMode(CENTER);
    this.image(popup_back, width/2, height/2);
    
    if (popText.index > -1) { //Checks so that PWindowText

      textAlign(LEFT);
      text("\n\n"+popText.expHanja+"    ["+ popText.expHangul+"]\n\n"+ popText.expDef, pwX, pwY);
      text(popText.subHanja.get(0)+"    " +popText.subHanjaDef.get(0)+"\n\n"
        +popText.subHanja.get(1)+"    " +popText.subHanjaDef.get(1), mpwX, mpwY);
    }
  }

  void popIt(int p_index) { //Takes index of row, being hanjaGroupIndex

    popText =  new PWindowText(sprSheet.getRow(p_index), p_index);  //Send TableRow and index of that row for storing in PWindowText object (popText)
  }

  void reset() { //Re-initializes popText so index is -1,
    popText = new PWindowText();
  }
}
