class Interface {
  PFont f1;
  PFont f2;

  Interface() {
    f1 = createFont("굴림", 50 );
    f2 = createFont("굴림", 20 );
  }

  void main() {
    f1 = createFont("굴림", 50 );
    f2 = createFont("굴림", 20 );
    textFont(f1);
    textAlign(CENTER, CENTER);
    text("한자어찾기  게임", width/2, height/2-100);
    textFont(f2);
    text("시작하려면 아무 키나 누르세요", width/2, height/2+100);
  }
}
