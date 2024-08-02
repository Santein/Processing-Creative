int cols = 100; // number of columns in the grid
int rows = 100; // number of rows in the grid
float spacing = 80; // spacing between the lines

void setup() {
  size(800, 800, P3D);
  background(0);
  stroke(0, 255, 255);
  strokeWeight(2);
  drawGrid();
}

void drawGrid() {
  translate(width / 2, height); // Move origin to bottom center of the screen
  rotateX(PI / 3.0); // Tilt the grid to create perspective
  rotateX(radians(75));
  
  // Draw the vertical lines
  for (int i = -cols / 2; i <= cols / 2; i++) {
    beginShape();
    for (int j = 0; j <= rows; j++) {
      float x = i * spacing;
      float y = -j * spacing;
      float z = j * spacing;
      vertex(x, y, z);
    }
    endShape();
  }
  
  // Draw the horizontal lines
  for (int j = 0; j <= rows; j++) {
    beginShape();
    for (int i = -cols / 2; i <= cols / 2; i++) {
      float x = i * spacing;
      float y = -j * spacing;
      float z = j * spacing;
      vertex(x, y, z);
    }
    endShape();
  }
}

void draw() {
//background(random(0, 50)); // Slightly vary the background color for flickering effect
  stroke(random(0, 255), random(200, 255), random(200, 255)); // Slightly vary the grid color for flickering effect
  drawGrid();
}
