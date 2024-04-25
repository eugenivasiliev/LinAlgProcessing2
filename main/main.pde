boolean showPerspective = false;
ArrayList<Object> objects = new ArrayList<Object>();
int FPS = 30;
float timeInc;
void setup() {
  size(600, 360, P3D);
  noFill();
  fill(255);
  noStroke();
  
  objects.add(new Object("LOD0_long_house.obj"));
  objects.get(0).mesh.scale(-3);
  objects.add((Object)new physicsObject("models/rock/rock_small.obj",new PVector(100,100,100),new PVector(0,1,0), 10.f));
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
  for(int i = 0 ; i < objects.size(); i++)
    objects.get(i).update();
}

void mousePressed() {
  showPerspective = !showPerspective;
}
