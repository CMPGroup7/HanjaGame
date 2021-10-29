class OurFilter {
 
  color rgba = 0;
  float r, g, b, a = 0;

  float videoBr = 0;
  float averageBr = 0;
  float totalBr = 0;

  float distX, distY, distC;
  float radius = 180;

  OurFilter(){

  }

  void maskPixel(PImage pPi, float pX, float pY){
    pPi.loadPixels();
    
    for (int i = 0; i < pPi.pixels.length; i++) {
      
      float cubeSize = random(10, 20);
      //int p = int(random(pPi.pixels.length));
      //float x = p%int(width);
      int x = int(random(pPi.width));
      int y = int(random(pPi.height));
      int p = x + y*pPi.width;
      
      distX = pX - x;
      distY = pY - y;
      distC = sqrt((distX*distX)+(distY*distY));

      if(distC <= radius){
      float r = pPi.pixels[p] >> 16 & 0xFF; //Shift to color you want to get
      float g = pPi.pixels[p] >> 8 & 0xFF;
      float b = pPi.pixels[p] & 0xFF;
      float a = pPi.pixels[p] >> 24 & 0xFF;

      fill(color(r, g, b, a));
      rect(x, y, cubeSize, cubeSize);
      }
    }
  }
  
}
