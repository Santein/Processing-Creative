int numDrops = 500; // Number of raindrops
float[] xPositions = new float[numDrops]; // X positions of raindrops
float[] yPositions = new float[numDrops]; // Y positions of raindrops
float[] speeds = new float[numDrops]; // Speeds of raindrops

void setup() {
  fullScreen();
  size(800, 600); // Canvas size
  background(0); // Background color
  for (int i = 0; i < numDrops; i++) {
    xPositions[i] = random(width); // Initialize random x position
    yPositions[i] = random(-500, height); // Initialize random y position
    speeds[i] = random(2, 5); // Random speed for each raindrop
  }
  noStroke(); // Disable stroke for smoother raindrops
}

void draw() {
  // Draw background with a fade for trails
  fill(0, 10); // Use a low alpha for a trailing effect
  rect(0, 0, width, height);

  // Draw rain drops
  background(random(20));
  for (int i = 0; i < numDrops; i++) {
    fill(128, 0, 128, 150); // Purple color with alpha
    ellipse(xPositions[i], yPositions[i], 5, 20); // Raindrop shape

    yPositions[i] += speeds[i]; // Move raindrop down

    // Reset raindrop if it falls below the screen
    if (yPositions[i] > height) {
      yPositions[i] = random(-50, 0); // Reset position above the screen
      xPositions[i] = random(width); // Randomize x position
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
