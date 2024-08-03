int cols, rows;
int scl = 20; // Scale of each grid square
float w = 2000; // Width of the grid
float h = 2000; // Height of the grid
float flying = 0; // Control the movement
PFont font;

void setup() {
  size(800, 600, P3D); // Size of the window
  cols = int(w / scl);
  rows = int(h / scl);
  
  // Load and set the font
  font = createFont("CFLCD-Regular-48.vlw", 32); // Replace with your font name and size
  textFont(font);
  textSize(32); // Set the size of the text
  textAlign(CENTER, CENTER); // Align the text to the center
}

void draw() {
  background(0); // Black background

  // Add the text "Santodrome" on top of the view
  fill(255, 255, 255); // White color for the text
  //text("Santodrome", width / 2, 50); // Display the text at the top center

  flying -= 0.1; // Adjust this to control the speed of the movement
  float yoff = flying;

  translate(width / 2, height / 2 + 100);
  rotateX(PI / 9); // Rotate the grid 30 degrees
  rotateX(radians(70)); // Additional rotation to achieve the 70-degree effect

  stroke(0, 255, 255); // Azure color for the grid lines
  noFill();

  translate(-w / 2, -h / 2);

  for (int y = 0; y < rows; y++) {
    beginShape(TRIANGLE_STRIP);
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      float z = map(noise(xoff, yoff), 0, 1, -100, 100); // Optional: Adding noise for variation in grid height
      vertex(x * scl, y * scl, z);
      vertex(x * scl, (y + 1) * scl, z);
      xoff += 0.1;
    }
    endShape();
    yoff += 0.1;
  }
}
