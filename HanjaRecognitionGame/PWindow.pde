//class for popup window
class PWindow extends PApplet {
  PFont f ;
  PWindowText popText;
  Table sprSheet;
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
    popText = new PWindowText();
    pwX = level.fontSize;
    pwY = level.fontSize;
  }

  void draw() {
    background(100);
    if (popText.index > -1) {
      text(popText.expHanja, pwX, pwY);
      text(popText.expHangul, pwX, pwY+(level.fontSize*2));//NullPointerException //IndexOutOfBounds 0 out of length 0
      text(popText.expDef, pwX, pwY*4);
    }
  }

  void popIt(int p_index) {

    popText =  new PWindowText(sprSheet.getRow(p_index), p_index);  //Send TableRow and index of that row for storing in PWindowText

  }

  void reset() { //Re-initializes popText so index is -1
    popText = new PWindowText();
  }

  //code for testing whether all hanja definition is saved and represent well.
  //void mousePressed() {
  //  if (index<popText.hanja.hanjaArr.size()-1) {
  //    index++;
  //    poptext.reset();
  //    poptext.popHanja(index);
  //  }
  //}
}
