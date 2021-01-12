void setup() {
  size(720, 480);
}

int x1, y1;
int x2, y2;
boolean first;

void mousePressed() {
  if (first) {
    x1 = mouseX;
    y1 = mouseY;
  } else {
    x2 = mouseX;
    y2 = mouseY;   
  }
  first = !first;
}


void draw() {
  background(255);
  drawFromAbove();
  
  stroke(0);
  strokeWeight(1);
  fill(255);
  rect(480, 0, 240, 480);
  
  int projX1 = proj(x1, y1);
  int projX2 = proj(x2, y2);

  PShape a = createShape();
  a.beginShape();
  a.stroke(255, 0, 0);
  a.strokeWeight(5);
  a.vertex(projX1, height/2);
  a.vertex(projX2, height/2);
  a.endShape();
  shape(a, 480, 0);
}

void drawFromAbove() {
  drawEye();

  fill(255, 200, 255);
  rect(x1, y1, 10, 10);
  rect(x2, y2, 10, 10);
  
  drawLineSight(x1, y1);
  drawLineSight(x2, y2);

  int projX1 = proj(x1, y1);
  int projX2 = proj(x2, y2);

  stroke(255, 0, 0);
  strokeWeight(5);
  line(mostLeft + projX1, screenY, mostLeft + projX2, screenY);
}

int mostLeft = 120;
int eyeX = 240;
int eyeY = 400;
int screenY = 200;

int proj(int x, int y) {
  int a = (screenY-y) * (eyeX - x) / (eyeY - y);
  int projX = x + a - mostLeft;
  if (projX < 0) return 0;
  return projX;
}

void drawLineSight(int x, int y) {
  patternLine(x, y, x, eyeY);
  patternLine(x, y, eyeX, eyeY); 
}

void drawEye() {
  stroke(0);
  strokeWeight(1);
  
  //screen
  line(0, screenY, 480, screenY);

  // line sight
  line(eyeX, eyeY, 0, 0);
  line(eyeX, eyeY, 480, 0);
  fill(0);
  textSize(60);
  patternLine(0, eyeY, 480, eyeY);
  text("Eye", eyeX + 10, eyeY +30);
}





void patternLine(int xStart, int yStart, int xEnd, int yEnd) {
  int linePattern = 0x5555;

  int lineScale = 10;
  int temp, yStep, x, y;
  int pattern = linePattern;
  int carry;
  int count = lineScale;

  boolean steep = (abs(yEnd - yStart) > abs(xEnd - xStart));
  if (steep == true) {
    temp = xStart;
    xStart = yStart;
    yStart = temp;
    temp = xEnd;
    xEnd = yEnd;
    yEnd = temp;
  }    
  if (xStart > xEnd) {
    temp = xStart;
    xStart = xEnd;
    xEnd = temp;
    temp = yStart;
    yStart = yEnd;
    yEnd = temp;
  }
  int deltaX = xEnd - xStart;
  int deltaY = abs(yEnd - yStart);
  int error = - (deltaX + 1) / 2;

  y = yStart;
  if (yStart < yEnd) {
    yStep = 1;
  } else {
    yStep = -1;
  }
  for (x = xStart; x <= xEnd; x++) {
    if ((pattern & 1) == 1) {
      if (steep == true) {
        point(y, x);
      } else {
        point(x, y);
      }
      carry = 0x8000;
    } else {
      carry = 0;
    }  
    count--;
    if (count <= 0) {
      pattern = (pattern >> 1) + carry;
      count = lineScale;
    }

    error += deltaY;
    if (error >= 0) {
      y += yStep;
      error -= deltaX;
    }
  }
}
