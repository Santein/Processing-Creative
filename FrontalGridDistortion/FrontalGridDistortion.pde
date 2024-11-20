void setup() {
  size(600, 600);
  background(0);
  stroke(255);
  strokeWeight(1);
}

void draw() {
  background(0);
  
  float speed = 0.5; // Adjust speed as needed
  float gridSize = 50;
  
  // Draw vertical lines
  for (float x = 0; x < width; x += gridSize) {
    float length = map(sin(x * 0.02 + frameCount * speed), -1, 1, 0, height);
    line(x, height/2 - length/2, x, height/2 + length/2);
  }
  
  // Draw horizontal lines
  for (float y = 0; y < height; y += gridSize) {
    float length = map(cos(y * 0.02 + frameCount * speed), -1, 1, 0, width);
    line(width/2 - length/2, y, width/2 + length/2, y);
  }
}
