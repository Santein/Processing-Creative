int numRings = 30;
int numShapes = 20;
float angleOffset = 0;
float colorShift = 0;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  noStroke();
}

void draw() {
  background(0);
  translate(width / 2, height / 2);

  float time = millis() / 1000.0;

  for (int i = 0; i < numRings; i++) {
    float baseRadius = map(i, 0, numRings, 0, width * 0.5);
    float pulsate = sin(time + i * 0.2) * 30;
    float radius = baseRadius + pulsate;
    float hue = map(i, 0, numRings, colorShift, 360 + colorShift) % 360;

    for (int j = 0; j < numShapes; j++) {
      float angle = map(j, 0, numShapes, 0, TWO_PI) + angleOffset;
      float x = radius * cos(angle);
      float y = radius * sin(angle);
      float size = map(i, 0, numRings, 20, 5) + 5 * sin(time + i);

      // Create the CRT color shift effect
      // Red channel
      fill(hue, 80, 100);
      ellipse(x - 2, y, size, size);

      // Green channel
      fill((hue + 15) % 360, 80, 100);
      ellipse(x, y, size, size);

      // Blue channel
      fill((hue + 30) % 360, 80, 100);
      ellipse(x + 2, y, size, size);
    }
  }

  angleOffset += 0.01;
  colorShift += 0.2;

  // Draw horizontal lines to simulate scan lines
  stroke(0, 0, 0, 50);
  for (int y = 0; y < height; y += 3) {
    line(-550, y, width, y);
    line(-550, -y, width, -y);
  }
  
  // Add a vignette effect
  addVignette();
}

// Helper function to add a vignette effect
void addVignette() {
  PGraphics vignette = createGraphics(width, height);
  vignette.beginDraw();
  vignette.noStroke();
  vignette.fill(0, 50);
  vignette.ellipse(width / 2, height / 2, width * 1.5, height * 1.5);
  vignette.endDraw();
  blend(vignette, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
}
