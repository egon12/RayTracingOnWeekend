void setup() {
  size(480, 480); 
}

int x, y;

void draw() {
  background(255);
  
  fill(255, 200, 255);
  rect(x, y, 10, 10);
  
  // screen
  int screenY = 200;
  line(0, screenY, width, screenY);
  
  
  // line sight
  int eyeX = width/2;
  int eyeY = 400;
  line(eyeX, eyeY, 0, 0);
  line(eyeX, eyeY, width, 0);
  fill(0);
  textSize(60);
  patternLine(0, eyeY, width, eyeY);
  text("Eye", eyeX + 10, eyeY +30);
  // left screen at
  // y = a * x + b
  // 400 = a & 240 + b
  // anggap b == 0
  // a = 400/240 = 10/6
  
  
  // most left screen = 200 = 10/6 * x ~ x = 200 * 6 / 10
  int mostLeft = 120;
  
  patternLine(x, y, x, eyeY);
  patternLine(x, y, eyeX, eyeY);
  
  // y/x to eye = y/x to screen
  // (400 - y)/(width/2 - x) = (200-y) / (a)
  // (x+a) * (400-y) / (width/2 -x) = 200 - y
  // x+a = (200-y) * (width/2-x) / (400 - y)
  // a = ((200 - y) * (width/2-x) / 400-y)
  int a = (screenY-y) * (eyeX - x) / (eyeY - y);
  int fromMostLeft = x + a - mostLeft;
  rect(mostLeft + fromMostLeft, screenY, 10, 10);
  textSize(30); 
  text(str(fromMostLeft), mostLeft + fromMostLeft + 20, 200 + 10);
}

void mousePressed() {
  x = mouseX;
  y = mouseY;
  
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
