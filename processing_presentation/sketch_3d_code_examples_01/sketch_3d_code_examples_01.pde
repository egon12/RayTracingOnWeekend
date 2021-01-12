void setup() {
  size(640, 480); 
}

void draw() {
  
  // s for square)
  PVector s[] = {
    new PVector(0, 0),
    new PVector(100, 0),
    new PVector(100, 100),
    new PVector(0, 100)
  };
  
  line(s[0].x, s[0].y, s[1].x, s[1].y);
  line(s[1].x, s[1].y, s[2].x, s[2].y);
  line(s[2].x, s[2].y, s[3].x, s[3].y);
  line(s[3].x, s[3].y, s[0].x, s[0].y);

}
