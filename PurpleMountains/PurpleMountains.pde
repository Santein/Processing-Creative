int cols, rows;
int scl = 20;
float w = 1600;
float h = 900;
float[][] z;

void setup() {
  size(800, 600, P3D);
  cols = int(w / scl);
  rows = int(h / scl);
  z = new float[cols][rows];
}

void draw() {
  background(0);
  stroke(255, 0, 255);  // Retrowave pink grid lines
  noFill();
  translate(width/2, height/2 + 100);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  
  float yoff = frameCount * 0.05;
  for (int y = 0; y < rows; y++) {
    float xoff = frameCount * 0.05;
    for (int x = 0; x < cols; x++) {
      z[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, z[x][y]);
      vertex(x*scl, (y+1)*scl, z[x][y+1]);
    }
    endShape();
  }
}
