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
  void update(){
    print();
  }
  void print(){
    shape(this.mesh);
  }
} 
class physicsObject extends Object{
  PVector pos;
  PVector speed;
  PVector aceleration;
  float massa;
  float size;
  color colour;
  PVector force;
  
  physicsObject(String shapeRoute, PVector newPos,PVector newVel, float newMass, float newSize){
    super(shapeRoute);
    this.mesh = loadShape(shapeRoute);
    pos = newPos;
    speed = newVel;
    aceleration = new PVector(0.0,0.0,0.0);
    massa = newMass;
    size = newSize;
    force = new PVector(0.0,9.8,0.0);
  }
 void update(){
    aceleration.x = force.x/massa;
    aceleration.y = force.y/massa;
    aceleration.y = force.z/massa;
    speed.x += aceleration.x * timeInc;
    speed.y += aceleration.y * timeInc;
    speed.z += aceleration.z * timeInc;
    pos.x += speed.x *timeInc;
    pos.y += speed.y *timeInc;
    pos.z += speed.z *timeInc;
    print();
  } 
  void print(){
    //this.mesh.resetMatrix();
    this.mesh.translate(pos.x,pos.y,pos.z);
    shape(this.mesh);
  }
}
