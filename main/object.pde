public class Vector3{
  float x, y, z;
  Vector3(){
    x = 0;
    y = 0;
    z = 0;
  }
  Vector3(float newX, float newY, float newZ){
    x = newX;
    y = newY;
    z = newZ;
  }
}
public class Transform{
  Vector3 pos, rotation, scale;
  Transform(){
    pos = new Vector3();
    rotation = new Vector3();
    scale = new Vector3();
  }
  Transform(Vector3 newPos,Vector3 newRot,Vector3 newSize){
    pos = newPos;
    rotation = newRot;
    scale = newSize;
  }
}
