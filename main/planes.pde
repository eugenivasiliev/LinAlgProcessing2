class Plane {
  PVector normal;
  float offset;
  //Thus plane equation would be normal*(x, y, z) + offset = 0
  
  Plane(PVector normal, float offset) {
    this.normal = normal;
    this.normal.normalize();
    this.offset = offset;
  }
  
  void drawPlane() {
    pushMatrix();
    translate(0, 0, -offset);
    rotateZ(acos(normal.y));
    rotateX(acos(normal.z));
    rectMode(CENTER);
    rect(0, 0, 1000, 1000);
    popMatrix();
  }
}
