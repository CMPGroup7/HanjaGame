//class for popup window
PWindow win;
class PWindow extends PApplet {
  PFont f ;
  PTextHandler poptext = new PTextHandler();
  int index = 0;
  
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(640, 640);
  }

  void setup() {
    background(100);
    f = createFont("굴림", 20);
    textFont(f);
    textAlign(LEFT, CENTER);
    poptext.popHanja(index);
  }

  void draw() {
    background(100);
    
    text(poptext.word+" ("+poptext.wordMean+")", x, y);
    for (int j = 0; j<poptext.wordDef.size(); j++) {
      text(poptext.wordDef.get(j), x, y+30*(j+1));
      //println(poptext.wordDef.get(j));
    }
    for (int i = 0; i<poptext.subhanja.size(); i++) {
      text(poptext.subhanja.get(i), x, y+30*(i+poptext.wordDef.size()+2));
    }
    
  }

  void isCollision() {
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
