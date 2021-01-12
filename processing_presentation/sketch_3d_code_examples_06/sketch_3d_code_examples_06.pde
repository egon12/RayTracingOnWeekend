
void setup() {
  size(640, 480);
  
  screen = new PVector(-width/2, -height/2, -200);
  eye = new PVector(0, 0, -350);
}

void draw() {
  background(255);
  
  PVector f1[] = {
    new PVector(-100, -100, -100),
    new PVector(100, -100, -100),
    new PVector(100, 100, -100),
    new PVector(-100, 100, -100)
  };
  
  PVector f2[] = {
    new PVector(-100, -100, -100),
    new PVector(-100, -100, 100),
    new PVector(-100, 100, 100),
    new PVector(-100, 100, -100)
  };
  
  PVector f3[] = {
    new PVector(-100, -100, -100),
    new PVector(100, -100, -100),
    new PVector(100, -100, 100),
    new PVector(-100, -100, 100)
  };
  
   PVector f4[] = {
    new PVector(-100, -100, 100),
    new PVector(100, -100, 100),
    new PVector(100, 100, 100),
    new PVector(-100, 100, 100)
  };
  
  PVector f5[] = {
    new PVector(100, -100, -100),
    new PVector(100, -100, 100),
    new PVector(100, 100, 100),
    new PVector(100, 100, -100)
  };
  
  PVector f6[] = {
    new PVector(-100, 100, -100),
    new PVector(100, 100, -100),
    new PVector(100, 100, 100),
    new PVector(-100, 100, 100)
  };
  
  float r = 0.01 * frameCount;
  
  f1 = tryRotate(f1, r);
  f2 = tryRotate(f2, r);
  f3 = tryRotate(f3, r);
  f4 = tryRotate(f4, r);
  f5 = tryRotate(f5, r);
  f6 = tryRotate(f6, r);
  
  ArrayList<PVector[]> shapes = new ArrayList();
  IntList colors = new IntList();
  
  shapes.add(f1);
  colors.append(color(255, 0, 0));
  
  shapes.add(f2);
  colors.append(color(0, 255, 0));
  
  shapes.add(f3);
  colors.append(color(0, 0, 255));
  
  //shapes.add(f4);
  //colors.append(color(255, 0, 255));
  
  //shapes.add(f5);
  //colors.append(color(0, 255, 255));
  
  //shapes.add(f6);
  //colors.append(color(255, 255, 0));
  
  IntList drawOrder = sortDrawOrder(shapes);
  
  for (int j=0; j<drawOrder.size(); j++) {
    int i = drawOrder.get(j);
    PVector s[] = shapes.get(i);
    ArrayList<PVector> projV = projShape(s);
    color c = color(colors.get(i));
    drawShape(projV, c);
  }
}

IntList sortDrawOrder(ArrayList<PVector[]> shapes) {
  
  FloatList first = new FloatList();
  for (PVector s[]: shapes) {
    first.push(averageZ(s));
  }
  
  IntList result = new IntList();
  while(result.size() < first.size()) {
    int idx = getMaxIndex(first, result);
    result.push(idx);
  }
  
  //return new IntList(2, 1, 0);
  return result;
}

PVector[] tryRotate(PVector in[], float radians) {
  
  //printArray(in);
  PVector[] result = new PVector[in.length];
  for (int i = 0; i < in.length; i++) {
   PVector v = in[i].copy();
   v.x = cos(radians) * in[i].x - sin(radians) * in[i].z;
   v.z = sin(radians) * in[i].x + cos(radians) * in[i].z;
   result[i] = v;
  }
  //printArray(result);
  return result;
}

float averageZ(PVector s[]) {
  float totalZ = 0;
  for (PVector v: s) {
    totalZ += v.z;
  }
  return totalZ / s.length;
  
}

float maxZ(PVector s[]) {
  float maxZ = -1000000;
  for (PVector v: s) {
    if (maxZ < v.z) {
      maxZ = v.z; 
    }
  }
  return maxZ;  
}

int getMaxIndex(FloatList list, IntList exclude) {
  
  float max = -100000;
  int idx = -1;
  for (int i=0; i<list.size(); i++) {
    if (exclude.hasValue(i)) {
      continue; 
    }
    if (list.get(i) > max) {
      max = list.get(i);
      idx = i;
    }
  }
  return idx;
}

void drawShape(ArrayList<PVector> projV, color c) {
  fill(c);
  beginShape();
  for (PVector v: projV) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}

ArrayList<PVector> projShape(PVector vs[]) {
  ArrayList<PVector> result = new ArrayList();
  
  for (PVector v: vs) {
    PVector projV = proj(v);
    result.add(projV);
  }
  
  return result;
}

PVector proj(PVector in) {
  return proj1(in);
  //return proj2(in);
}

PVector proj1(PVector in) {
  PVector out = new PVector();
  
  float a = (screen.z - in.z) * (eye.x - in.x) / (eye.z - in.z);
  out.x = in.x + a - screen.x; 
  
  a = (screen.z-in.z) * (eye.y - in.y) / (eye.z - in.z);
  out.y = in.y + a - screen.y;
  
  return out;
}

PVector proj2(PVector in) {
  PVector out = new PVector();
  out.x = ((in.x - eye.x) * ((screen.z - eye.z)/(in.z + 300))) + eye.x + width/2;
  out.y = ((in.y - eye.y) * ((screen.z - eye.z)/(in.z + 300))) + eye.y + height/2;
  return out;
}

PVector proj3(PVector in) {
  PVector out = new PVector();
  float z = in.z + 400;
  out.x = ((eye.x - in.x) * (screen.z - z) - (eye.z - z) * (screen.x - in.x)) / ( eye.z - z);
  out.y = ((eye.y - in.y + 300) * (screen.z - z) - (eye.z - z) * (screen.y - in.y + 300)) / ( eye.z - z);
  return out;
}

PVector proj4(PVector in) {
  // Got from Wikipedia
  PVector d = PVector.sub(in, eye);
  PVector out = new PVector();
  out.x = eye.z * d.x / d.z + eye.x;
  out.y = eye.z * d.y / d.z + eye.y;
  
  // make it center
  out.x += width/2;
  out.y += height/2;
  return out;
}


PVector screen;
PVector eye;
