boolean showPerspective = false;

void setup() {
  size(600, 360, P3D);
  noFill();
  fill(255);
  noStroke();
}

void draw() {
  lights();
  background(0);
  if (showPerspective == true) {
    perspective();
  } else {
    ortho();
  }
  translate(width/2, height/2, 0);
  rotateX(-PI/6);
  rotateY(PI/3);
  box(180);
}

void mousePressed() {
  showPerspective = !showPerspective;
}
