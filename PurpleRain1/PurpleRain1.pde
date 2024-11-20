int numDrops = 800;
float[] xPositions = new float[numDrops];
float[] yPositions = new float[numDrops];
float[] speeds = new float[numDrops];
float noiseScale = 0.02;

void setup() {
  size(800, 600);
  background(0);
  for (int i = 0; i < numDrops; i++) {
    xPositions[i] = random(width);
    yPositions[i] = random(-500, height);
    speeds[i] = random(2, 5);
  }
  noStroke();
}

void draw() {
  // Draw background with a fade for trails
  fill(0, 10); // Use a low alpha for a trailing effect
  rect(0, 0, width, height);
  
  // Draw rain drops
  for (int i = 0; i < numDrops; i++) {
    float noiseVal = noise(xPositions[i] * noiseScale, yPositions[i] * noiseScale);
    float xOffset = map(noiseVal, 0, 1, -1, 1);
    
    fill(128, 0, 128, 150); // Purple color
    ellipse(xPositions[i] + xOffset * 10, yPositions[i], 2, 10);
    
    yPositions[i] += speeds[i];
    
    if (yPositions[i] > height) {
      yPositions[i] = random(-50, 0);
      xPositions[i] = random(width);
    }
  }
  
  // Apply CRT effect
  applyCRTEffect();
}

void applyCRTEffect() {
  loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int index = x + y * width;
      color c = pixels[index];
      
      // Simulate scanlines
      if (y % 2 == 0) {
        float darken = 0.85;
        pixels[index] = color(red(c) * darken, green(c) * darken, blue(c) * darken);
      }
      
      // Simulate screen curvature with color distortion
      float distX = (float)x / width - 0.5;
      float distY = (float)y / height - 0.5;
      float distort = (distX * distX + distY * distY) * 0.1;
      
      float r = red(c) * (1 - distort) + 10 * distort;
      float g = green(c) * (1 - distort);
      float b = blue(c) * (1 - distort) + 20 * distort;
      
      pixels[index] = color(r, g, b);
    }
  }
  updatePixels();
}
