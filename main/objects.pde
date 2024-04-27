class Object{
  PShape mesh;
  PVector pos;
  PVector hitboxSize;
  Object(String shapeRoute, PVector newPos, PVector hbs){
    this.mesh = loadShape(shapeRoute);
    this.pos = newPos;
    this.hitboxSize = hbs;
  }
  Object(String shapeRoute){
    this.mesh = loadShape(shapeRoute);
    this.pos = new PVector(0,0,0);
    this.hitboxSize = new PVector(100,100,100);
  }
  void update(){
    print();
  }
  void print(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    shape(this.mesh);
    if(debug){
        noFill();
        stroke(00,255,00);
        box(hitboxSize.x, hitboxSize.y, hitboxSize.z);
     }
     popMatrix();
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
    this.hitboxSize = new PVector(100,100,100);
    //mesh.translate(pos.x,pos.y,pos.z);
  }
   physicsObject(String shapeRoute, PVector newPos,PVector newVel, float newMass, PVector hbs){
    super(shapeRoute);
    this.mesh = loadShape(shapeRoute);
    pos = newPos;
    speed = newVel;
    aceleration = new PVector(0.0,0.0,0.0);
    massa = newMass;
    force = new PVector(0.0,0,9.8f);
    this.hitboxSize = hbs;
  }
 void update(){
    aceleration.x = force.x/massa;
    aceleration.y = force.y/massa;
    aceleration.z = force.z/massa;
    speed.x += aceleration.x * deltaTime;
    speed.y += aceleration.y * deltaTime;
    speed.z += aceleration.z * deltaTime;
    pos.x += speed.x *deltaTime;
    pos.y += speed.y *deltaTime;
    pos.z += speed.z *deltaTime;
    pushMatrix();
      translate(pos.x,pos.y,pos.z);
      shape(this.mesh);
      if(debug){
        noFill();
        stroke(00,255,00);
        box(hitboxSize.x, hitboxSize.y, hitboxSize.z);
      }
    popMatrix();
  } 
}
boolean collision(Object o1, Object o2){
  return (
        (o1.pos.x + o1.hitboxSize.x > o2.pos.x && o1.pos.y + o1.hitboxSize.y > o2.pos.y && o1.pos.z + o1.hitboxSize.z > o2.pos.z) &&
        (o1.pos.x < o2.pos.x +o2.hitboxSize.x && o1.pos.y < o2.pos.y + o2.hitboxSize.y && o1.pos.z < o2.pos.z + o2.hitboxSize.z) 
   );
}
