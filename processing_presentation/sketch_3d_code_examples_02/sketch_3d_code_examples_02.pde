
void setup() {
  size(640, 480);
}



void draw(){
  // s for square
  PVector s[] = {
    new PVector(10, 10, 0),
    new PVector(100, 0, 0),
    new PVector(100, 100, 0),
    new PVector(0, 100, 0),
  };
  
  beginShape();

  fill(255, 200, 255);
  vertex(s[0].x, s[0].y);
  vertex(s[1].x, s[1].y);
  vertex(s[2].x, s[2].y);
  vertex(s[3].x, s[3].y);

/*
  for (PVector v: s) {
    vertex(v.x, v.y);

  }
*/
  endShape(CLOSE);


}
