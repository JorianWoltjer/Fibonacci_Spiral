// Controls: -------------------------
// - Left Click = +1 iIteration
// - Right Click = -1 Iteration
// - Scroll Wheel = Zoom
// - Space = Zoom animation to start


float[] begins = {-PI, -HALF_PI, 0, HALF_PI};
float[] ends   = {-HALF_PI, 0, HALF_PI, PI};
boolean leftTimer  = false;

// Change:
float size = 300;
int iterations = 1;
boolean autoZoom = true;

void setup() {
  size(640, 640);
  background(50);
  stroke(255);
  strokeWeight(1);
  textAlign(LEFT, BOTTOM);
  frameRate(30);
}

void draw() {  
  background(50);
  translate(width/2, height/2);
  noFill();

  // Drawing the Fibonacci Spiral: -------------------------
  int i = 0;
  int i1 = -2;
  int i2 = -2;
  while (i < iterations) {
    if (i % 2 == 0) {
      i1 = i2 + 1;
      i2 += 2;
      arc(size*function(i1)*mod(i2+2), size*function(i2-2)*mod(i2+1), size*fibonacci(i2+2), size*fibonacci(i2+2), begins[((i2/2)%2)*2], ends[((i2/2)%2)*2], PIE);
    } else {
      arc(size*function(i1)*mod(i2+3), size*function(i2)*mod(i2+2), size*fibonacci(i2+3), size*fibonacci(i2+3), begins[((i2/2)%2)*2+1], ends[((i2/2)%2)*2+1], PIE);
    }
    i++;
  }
  // i  = 0,1,2,3,4,5,6,7,8,9,10
  // i1 = 0,1,3,5,7,9,11
  // i2 = 0,2,4,6,8,10,12

  // The Text Displaying: -------------------------
  textSize(20);
  fill(255);
  text("Iterations: ", -width/2+10, -height/2+30);
  text("Size: ", -width/2+10, -height/2+60);
  textSize(30);
  fill(0, 128, 255);
  text(iterations, -width/2+110, -height/2+35);
  text(nf(1/size*300, 1, 1), -width/2+60, -height/2+65);

  // The Zoom Animation: -------------------------
  if (leftTimer) {
    if (size > 300) {
      leftTimer = false;
      size = 300;
    } else
      size *= 1.05;
  }
}

// The Folmulas: -------------------------
float function(int n) {
  // a(n) = a(n-1)+a(n-3)+a(n-4) 
  // a(0) = a(1) = a(2) = 1 
  // a(3) = 2
  if (n < 0)
    return 0;
  else if (n == 0 || n == 1 || n == 2) 
    return 0.5;
  else if (n == 3) 
    return 1;
  else 
  return function(n-1)+function(n-3)+function(n-4);
}
int mod(int n) {
  // a(n) = round(cos(n*PI/2)+sin(n*PI/2))
  return -round(cos(n*PI/2)+sin(n*PI/2));
}

int fibonacci(int n) {
  // F(n) = F(n-1) + F(n-2) 
  // F(0) = 0 
  // F(1) = 1

  if (n == 0)
    return 0;
  else if (n == 1)
    return 1;
  else
    return fibonacci(n-1) + fibonacci(n-2);
}

// The Control: -------------------------
void mousePressed() {
  if (mouseButton == RIGHT) {
    if (iterations > 0) {
      iterations--;
      if (autoZoom)
        size /= 0.61803398875;
    }
  } else if (mouseButton == LEFT) {
    iterations++;
    if (autoZoom)
      size *= 0.61803398875;
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() == -1) {
    if (size > 300)
      return;
    size /= 0.61803398875;
  } else 
  size *= 0.61803398875;
}

void keyPressed() {
  if (key == ' ')
    leftTimer = true;
}
