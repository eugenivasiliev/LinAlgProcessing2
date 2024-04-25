boolean showPerspective = false;
int lastTime = 0;
float deltaTime; 
//PShape house;

final float camDist = 100f;

ArrayList<Object> objects = new ArrayList<Object>();
int FPS = 30;
float timeInc;

void setup() {
  size(600, 360, P3D);
  noFill();
  fill(255);
  noStroke();
  rectMode(CENTER);
  ortho();
  
  objects.add(new Object("LOD0_long_house.obj"));
  objects.get(0).mesh.scale(-3);
  objects.add((Object)new physicsObject("models/rock/rock_small.obj",new PVector(100,100,100),new PVector(0,1,0), 10.f));
}

void draw() {
  deltaTime = deltaTime();
  lights();
  background(0);
  pushMatrix();
  //Isometric perspective transforms
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateZ(PI/4);
  
  stroke(color(255, 0, 0));
  line(0, 0, 0, 100, 0, 0);
  stroke(color(0, 255, 0));
  line(0, 0, 0, 0, 100, 0);
  stroke(color(0, 0, 255));
  line(0, 0, 0, 0, 0, 100);
  stroke(0);
  rect(0, 0, 1000, 1000);
  
  pushMatrix();
  
  //Find pos on plane from mouse position
  translate(((mouseY-height/2)*1.05 + (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), ((mouseY-height/2)*1.05 - (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), 0.1f);
  fill(color(255, 0, 0));
  circle(0, 0, 40);
  fill(255);
  
  popMatrix();
  
  pushMatrix();
  
  translate(camDist, camDist, camDist);
  
  
  //rect(0, 0, 1000, 1000);
  rotateX(-PI/2);
  rotateY(PI/2);
  //shape(house);
  popMatrix();
  popMatrix();
}

void keyPressed() {
  rotateX(-PI/6);
  rotateY(PI/3);
  for(int i = 0 ; i < objects.size(); i++)
    objects.get(i).update();
}

void mousePressed() {
  
}
float deltaTime() { //Scale speed and other physics computations wrt frame duration
  int delta;
  float deltaTime;
  delta = millis() - lastTime;
  lastTime = millis();
  deltaTime = delta*FPS/1000.0f;
  return deltaTime;
}
