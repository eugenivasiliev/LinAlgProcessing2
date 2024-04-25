boolean showPerspective = false;

PShape house;

final float camDist = 100f;

void setup() {
  size(600, 360, P3D);
  noFill();
  fill(255);
  noStroke();
  rectMode(CENTER);
  
  house = loadShape("LOD0_long_house.obj");
  house.scale(-3);
}

void draw() {
  lights();
  background(0);
  //if (showPerspective == true) {
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateZ(PI/4);
  //  perspective();
  //} else {
  //  ortho();
  //}
  //pushMatrix();
  
  //translate(((mouseY-height/2)*sin(radians(30)) + (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), ((mouseY-height/2)*sin(radians(30)) - (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), 0);
  //box(10);
  
  //popMatrix();
  
  pushMatrix();
  
  translate(camDist, camDist, camDist);
  
  
  //rect(0, 0, 1000, 1000);
  rotateX(-PI/2);
  rotateY(PI/2);
  shape(house);
  popMatrix();
}

void keyPressed() {
  if (key == 'p') showPerspective = !showPerspective;
}

void mousePressed() {
  
}
