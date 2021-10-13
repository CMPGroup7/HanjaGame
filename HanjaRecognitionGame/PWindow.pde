//class for popup window
PWindow win;
class PWindow extends PApplet {
  PFont f ;
  TextHandler hanja = new TextHandler();

  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(640, 360);
  }

  void setup() {
    background(100);
    f = createFont("Batang", fontS);
    textFont(f);
    textAlign(LEFT, CENTER);
  }

  void draw() {

    text(hanja.hanjaArr.get(0), x, y);
 
  }
}
