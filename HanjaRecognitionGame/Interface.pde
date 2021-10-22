class Interface {
  PFont f1;
  PFont f2;

  Interface() {
    f1 = createFont("굴림", 50 );
    f2 = createFont("굴림", 20 );
  }

  void main() {
    background(100);

    f1 = createFont("굴림", 50 );
    f2 = createFont("굴림", 20 );
    textFont(f1);
    textAlign(CENTER, CENTER);
    text("한자어찾기", width/2, height/2-100);
    textFont(f2);
    text("시작하려면 아무 키나 누르세요", width/2, height/2+100);
  }

  void ending() {
    background(100);
    fill(255);

    textFont(f2);
    text("0개의 한자어를 찾았습니다!", width/2, height/2);
  }
}
