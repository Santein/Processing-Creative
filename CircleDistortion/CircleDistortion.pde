int numPoints = 1000; // Number of points in the spiral
float angleOffset = 0; // Initial angle offset
float angleIncrement = TWO_PI / numPoints; // Angle increment for each point
float radiusIncrement = 0.2; // Radius increment for the spiral
float baseRadius = 0; // Initial radius
color[] colors; // Array of colors

void setup() {
  fullScreen();
  //size(800, 800);
  colors = new color[6]; // Array to hold colors
  colors[0] = color(255, 0, 0); // Red
  colors[1] = color(0, 255, 0); // Green
  colors[2] = color(0, 0, 255); // Blue
  colors[3] = color(255, 255, 0); // Yellow
  colors[4] = color(255, 0, 255); // Magenta
  colors[5] = color(0, 255, 255); // Cyan
  background(0); // Set background to black
}

void draw() {
  translate(width / 2, height / 2); // Move origin to center
  float radius = baseRadius; // Initialize radius
  int colorIndex = 0; // Initialize color index

  for (int i = 0; i < numPoints; i++) {
    float x = radius * cos(i * angleIncrement + angleOffset);
    float y = radius * sin(i * angleIncrement + angleOffset);

    stroke(colors[colorIndex]); // Set stroke color
    strokeWeight(3); // Set stroke weight
    point(x, y); // Draw point

    radius += radiusIncrement; // Increase radius

    // Change color every 20 points
    if (i % 20 == 0) {
      colorIndex = (colorIndex + 1) % colors.length;
    }
  }

  angleOffset += 0.02; // Increment angle offset for rotation
  baseRadius += 0.5; // Increment base radius for spiral effect

  // Reset baseRadius to create a continuous loop effect
  if (baseRadius > sqrt(sq(width) + sq(height)) / 2) {
    baseRadius = 0;
    background(0); // Clear screen
  }
}
