
void setup() {
  size(480, 480);
  
  screen = new PVector(-100, -100, -50);
  eye = new PVector(0, 0, -100);
}

void draw() {
  
  PVector vs[] = {
    new PVector(-50, -50, 0),
    new PVector(50, -50, 0),
    new PVector(50, 50, 0),
    new PVector(-50, 50, 0)
  
  };
  
  ArrayList<PVector> projV = projArr(vs);
  
  fill(255, 200, 255);
  beginShape();
  for (PVector v: projV) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}

ArrayList<PVector> projArr(PVector vs[]) {
  ArrayList<PVector> result = new ArrayList();
  
  for (PVector v: vs) {
    PVector projV = proj(v);
    result.add(projV);
  }
  
  return result;
}

PVector proj(PVector in) {
  PVector out = new PVector();
  
  float a = (screen.z - in.z) * (eye.x - in.x) / (eye.z - in.z);
  out.x = in.x + a - screen.x; 
  
  a = (screen.z-in.z) * (eye.y - in.y) / (eye.z - in.z);
  out.y = in.y + a - screen.y;
  
  return out;
}

PVector screen;
PVector eye;
