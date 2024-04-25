class Object{
  String id;
  PShape mesh;
  PVector pos;
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
  
  PVector speed;
  PVector aceleration;
  float massa;
  float size;
  color colour;
  PVector force;
  
  physicsObject(String shapeRoute, PVector newPos,PVector newVel, float newMass){
    super(shapeRoute);
    this.mesh = loadShape(shapeRoute);
    pos = newPos;
    speed = newVel;
    aceleration = new PVector(0.0,0.0,0.0);
    massa = newMass;
    force = new PVector(0.0,9.8f,0.0);
    //mesh.translate(pos.x,pos.y,pos.z);
  }
 void update(){
    aceleration.x = force.x/massa;
    aceleration.y = force.y/massa;
    aceleration.z = force.z/massa;
    speed.x += aceleration.x * deltaTime;
    speed.y += aceleration.y * deltaTime;
    speed.z += aceleration.z * deltaTime;
    //PVector tanslationValue = pos; 
    pos.x += speed.x *deltaTime;
    pos.y += speed.y *deltaTime;
    pos.z += speed.z *deltaTime;
    //tanslationValue.sub(pos);
    //mesh.translate(tanslationValue.x,tanslationValue.y,tanslationValue.z);
    
    pushMatrix();
      translate(pos.x,pos.y,pos.z);
      shape(this.mesh);
    popMatrix();
  } 
 
}
