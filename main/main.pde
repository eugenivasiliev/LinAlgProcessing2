boolean showPerspective = false;

class Object{
  String id;
  PShape mesh;
  Object(String newId, String shapeRoute){
    this.id = newId;
    this.mesh = loadShape(shapeRoute);
  }
  Object(String shapeRoute){
    this.mesh = loadShape(shapeRoute);
  }
  void print(){
    shape(this.mesh);
  }
} 
ArrayList<Object> objects = new ArrayList<Object>();

void setup() {
  size(600, 360, P3D);
  noFill();
  fill(255);
  noStroke();
  
  objects.add(new Object("LOD0_long_house.obj"));
  objects.get(0).mesh.scale(-3);
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
    objects.get(i).print();
}

void mousePressed() {
  showPerspective = !showPerspective;
}
