boolean showPerspective = false;

PShape house;

void setup() {
  size(600, 360, P3D);
  noFill();
  fill(255);
  noStroke();
  
  house = loadShape("LOD0_long_house.obj");
  house.scale(-3);
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
  shape(house);
}

void mousePressed() {
  showPerspective = !showPerspective;
}
