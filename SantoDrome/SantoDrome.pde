int cols, rows;
int scl = 20; // Scale of each grid square
float w = 2000; // Width of the grid
float h = 2000; // Height of the grid
float flying = 0; // Control the movement
float highwayOffset = 0; // Control the movement of the highway lines
float highwaySpeed = 1; // Speed of the highway lines
PFont font;
float angle = 0; // Rotation angle for the sphere

void setup() {
  fullScreen(P3D); // Make the window fullscreen
  cols = int(w / scl);
  rows = int(h / scl);
  
  // Load and set the font
  font = createFont("DS-DIGIT.TTF", 32); // Replace with your font name and size
  textFont(font);
  textSize(32); // Set the size of the text
  textAlign(CENTER, CENTER); // Align the text to the center
}

void draw() {
  background(0); // Black background

  // Add the text "Santodrome" on top of the view
  fill(255, 255, 255); // White color for the text
  text("Santodrome", width / 2, 50); // Display the text at the top center

  // Display the current time
  String currentTime = nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2);
  text(currentTime, width / 2, 100); // Display the time below the title

  flying -= 0.1; // Adjust this to control the speed of the movement
  highwayOffset -= highwaySpeed; // Adjust this to control the speed of the highway lines
  if (highwayOffset < -scl) {
    highwayOffset = 0; // Reset the offset to create a looping effect
  }
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
      float z = 0;
      // Create a gap in the middle for the highway
      if (x < cols / 2 - 2 || x > cols / 2 + 2) {
        z = map(noise(xoff, yoff), 0, 1, -100, 100); // Adding noise for variation in grid height
      }
      vertex(x * scl, y * scl, z);
      vertex(x * scl, (y + 1) * scl, z);
      xoff += 0.3;
    }
    endShape();
    yoff += 0.1;
  }

  // Draw highway lines
  stroke(0, 0, 0); // Color for the highway lines
  for (int y = 0; y < rows; y++) {
    float x1 = (cols / 2 - 2) * scl;
    float x2 = (cols / 2 + 2) * scl;
    float y1 = y * scl + highwayOffset;
    float y2 = (y + 1) * scl + highwayOffset;
    line(x1, y1, 0, x2, y1, 0);
    line(x1, y2, 0, x2, y2, 0);
  }

  // Draw 3D ball made of triangles at the center, moved up along the z-axis
  pushMatrix();
  translate(width / 2.5, height / 2, 350); // Move the ball up along the z-axis
  rotateY(angle);
  rotateX(angle * 0.5);
  fill(200, 200, 25); // Blue color for the ball
  stroke(255); // White stroke for the ball edges
  int detail = 24;
  float r = 100; // Radius of the ball
  for (int i = 0; i < detail; i++) {
    float theta1 = map(i, 0, detail, 0, PI);
    float theta2 = map(i + 1, 0, detail, 0, PI);
    for (int j = 0; j < detail; j++) {
      float phi1 = map(j, 0, detail, 0, TWO_PI);
      float phi2 = map(j + 1, 0, detail, 0, TWO_PI);
      beginShape(TRIANGLES);
      vertex(r * sin(theta1) * cos(phi1), r * sin(theta1) * sin(phi1), r * cos(theta1));
      vertex(r * sin(theta2) * cos(phi1), r * sin(theta2) * sin(phi1), r * cos(theta2));
      vertex(r * sin(theta1) * cos(phi2), r * sin(theta1) * sin(phi2), r * cos(theta1));
      vertex(r * sin(theta2) * cos(phi1), r * sin(theta2) * sin(phi1), r * cos(theta2));
      vertex(r * sin(theta2) * cos(phi2), r * sin(theta2) * sin(phi2), r * cos(theta2));
      vertex(r * sin(theta1) * cos(phi2), r * sin(theta1) * sin(phi2), r * cos(theta1));
      endShape();
    }
  }
  popMatrix();

  angle += 0.01; // Increment the rotation angle for the sphere
}
