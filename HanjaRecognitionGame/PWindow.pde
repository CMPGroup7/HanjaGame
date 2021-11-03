/*
 Pwindow : Class for popup window
 - load .tsv file which contains hanja and it's meaning
 - set size of pwindow
 - set the position of showing hanja and it's meaning & show them in pwindow.
 - Takes index of row, being hanjaGroupIndex
 - Close only popup window when the game is endd.
 */
class PWindow extends PApplet {

  PFont f ;
  PWindowText popText; //Use PWindowText object for displaying text(definition of hanja words)
  PImage popup_back; // background image for popup window

  Table sprSheet;
  //String data
  float sXY;

  float pwX, pwY; //starting position of representing hanja word on popup window
  float mpwX, mpwY; //starting position of representing syllables and it's meaning on popup window
  float spacing;
  float repeatSpacing;


  PWindow() { //constructor for pwindow
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() { //set size for pwindow
    size(640, 640);
  }

  void setup() {
    sprSheet = loadTable(tablePath, "header"); // load "dict_file.tsv" file which stores hanja and it's meaning

    background(100);

    f = createFont("굴림", 20);
    textFont(f);
    textAlign(LEFT, CENTER);
    popText = new PWindowText();

    //Set the position of showing hanja(pwX, pwY) and it's meaning(mpwX, mpwY)
    pwX = level.fontSize*2;
    pwY = level.fontSize;
    mpwX = level.fontSize*2;
    mpwY = level.fontSize *12;
  }

  void draw() {
    background(#004221);

    //Checks so that PWindowText
    if (popText.index > -1) {
      imageMode(CENTER);
      image(popup_back, width/2, height/2);
      textAlign(LEFT);

      //Shows the meaning of the Sino-korean words which the character passed through
      //and the meaning of the syllabul that make up each syllable.
      text("\n\n"+popText.expHanja+"    ["+ popText.expHangul+"]\n\n"+ popText.expDef, pwX, pwY);
      text(popText.subHanja.get(0)+"    " +popText.subHanjaDef.get(0)+"\n\n"
        +popText.subHanja.get(1)+"    " +popText.subHanjaDef.get(1), mpwX, mpwY);
    }
  }

  /* Takes index of row, being hanjaGroupIndex */
  void popIt(int p_index) {
    popText =  new PWindowText(sprSheet.getRow(p_index), p_index);  //Send TableRow and index of that row for storing in PWindowText object (popText)
  }

  /* Re-initializes popText so index is -1, */
  void reset() {
    popText = new PWindowText();
  }

  /* Close only popup window when game is over */
  void closeWindow() {
    Frame frame = ( (SmoothCanvas) ((PSurfaceAWT)surface).getNative()).getFrame();
    frame.dispose();
  };
}
