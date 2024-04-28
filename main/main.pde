import processing.sound.*;
SoundFile bgMusic, soundFX;

boolean showPerspective = false;
int lastTime = 0;
float deltaTime; 
boolean debug = false;

PImage img = createImage(200, 200, ARGB);
PImage aim;
PImage grass;

final float camDist = 100f;

ArrayList<Object> buildings = new ArrayList<Object>();
ArrayList<Object> meteorites = new ArrayList<Object>();
int FPS = 30;
float timeInc;

void setup() {
  size(1080, 720, P3D);
  noFill();
  fill(255);
  noStroke();
  rectMode(CENTER);
  imageMode(CENTER);
  ortho();
  
  //LUT formatting for the aim texture, making it more opaque the closer to the center a pixel is
  aim = loadImage("textures/aim.png");
  aim.format = ARGB;
  bgMusic = new SoundFile(this,"sounds/skyloft.mp3");
  soundFX = new SoundFile(this,"sounds/rock.mp3");
  bgMusic.play();
  bgMusic.loop();
  for(int i = 0; i < aim.width; i++) {
    for(int j = 0; j < aim.height; j++){
      color aimPixel = aim.get(i, j);
      if((i - aim.width/2)*(i - aim.width/2) + (j - aim.height/2)*(j - aim.height/2) > aim.width * aim.width / 4)
        aimPixel = color(red(aimPixel), green(aimPixel), blue(aimPixel), 0);
      else if((i - aim.width/2)*(i - aim.width/2) + (j - aim.height/2)*(j - aim.height/2) > aim.width * aim.width / 8)
        aimPixel = color(red(aimPixel), green(aimPixel), blue(aimPixel), 96);
      else if((i - aim.width/2)*(i - aim.width/2) + (j - aim.height/2)*(j - aim.height/2) > aim.width * aim.width / 16)
        aimPixel = color(red(aimPixel), green(aimPixel), blue(aimPixel), 160);
        else if((i - aim.width/2)*(i - aim.width/2) + (j - aim.height/2)*(j - aim.height/2) > aim.width * aim.width / 32)
        aimPixel = color(red(aimPixel), green(aimPixel), blue(aimPixel), 220);
      else
        aimPixel = color(red(aimPixel), green(aimPixel), blue(aimPixel), 255);
      aim.set(i, j, aimPixel);
    }
  }
  
  aim.updatePixels();
   
   grass = loadImage("textures/grass.jpg");
  
  pushMatrix();
  
  //Isometric perspective transforms
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateZ(PI/4);
  int addedcount = 0;
  for(int i = 0; i < 5; i ++)
  {
    for(int j = 0 ; j < 5 ; j++){
        int building = int(random(3))%3;
        if(building == 0){
           buildings.add(new Object("models/house1/Cynthia's Family's House.obj",new PVector(((i+1)*150)-450,((j+1)*150)-450,100), new PVector(100,100,100)));
           buildings.get(addedcount).mesh.setTexture(loadImage("models/house1/t5_s01_lm4.png"));
        }
        else if(building == 1){
          buildings.add(new Object("models/house2/Solaceon Town House.obj",new PVector(((i+1)*150)-450,((j+1)*150)-450,100), new PVector(100,100,100)));
           buildings.get(addedcount).mesh.setTexture(loadImage("models/house2/t4_h01_a.png"));
        }
        else{
          buildings.add(new Object("models/castle/hat_toride_model.obj",new PVector(((i+1)*150)-450,((j+1)*150)-450,100), new PVector(100,100,100)));
           buildings.get(addedcount).mesh.setTexture(loadImage("models/castle/hat_toride_color.png"));
        }
        buildings.get(addedcount).mesh.rotateX(1.5);
        buildings.get(addedcount).mesh.rotateZ(1.5);
       addedcount++;
    }
  }
 popMatrix();
  meteorites.add((Object)new physicsObject("models/rock/rock_small.obj",new PVector(0,0,500),new PVector(0,0,1), 10.f, new PVector(100,100,100)));
  if(collision(buildings.get(0), buildings.get(1)))
    println("collied");
  else
    println("no collied");
}

void draw() {
  deltaTime = deltaTime();
  lights();
  background(0);
  fill(255);
  
  
  pushMatrix();
  
  //Isometric perspective transforms
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateZ(PI/4);
  
  if(debug){
    //Show axes
    stroke(color(255, 0, 0));
    line(0, 0, 0, 100, 0, 0);
    stroke(color(0, 255, 0));
    line(0, 0, 0, 0, 100, 0);
    stroke(color(0, 0, 255));
    line(0, 0, 0, 0, 0, 100);
    stroke(0);
  }
  
  image(grass,0,0,1000,1000);
  pushMatrix();
  
  //Find pos on plane from mouse position, according to the line equation from a plane at camDist from (0, 0, 0) with normal vector (1, 1, 1) and the XY-plane.
  translate(((mouseY-height/2)*1.05 + (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), ((mouseY-height/2)*1.05 - (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), 1f);
  fill(color(255, 0, 0));
  //image(img, 0, 0);
  image(aim, 0, 0,50,50);
  //circle(0, 0, 40);
  fill(255);
  
  popMatrix();
  
  pushMatrix();
  popMatrix();
  for(int i = 0 ; i < buildings.size(); i++) {
    buildings.get(i).update();
    if(buildings.get(i).pos.z < -1f) buildings.remove(i);
    for(int j = 0 ; j < meteorites.size(); j++) {
      if(collision(buildings.get(i), meteorites.get(j))) {
        buildings.remove(i);
        meteorites.remove(j);
        soundFX.play();
        if(buildings.size() == 0)
          exit();
      }
    }
  }
  
  for(int i = 0 ; i < meteorites.size(); i++) {
    meteorites.get(i).update();
    if(meteorites.get(i).pos.z < -1f){
      meteorites.remove(i);
      soundFX.play();
    }
  }
  
  popMatrix();
}
int rotationx, rotationy, rotationz;
void keyPressed() {
  if(key == 'a')rotateZ(0.1);
  if(key == 'd') rotateZ(0.1);
  if(key == 's'){
     grass = loadImage("textures/grass.jpg");
  }
  if(key == 'q'){
    for(int i = 0; i < grass.width; i++) {
      for(int j = 0; j < grass.height; j++){
        color grassPixel = grass.get(i, j);
        grassPixel = color(255, green(grassPixel), blue(grassPixel), 255);
        grass.set(i, j, grassPixel);
      }
    }
  }
  if(key == 'w'){
    for(int i = 0; i < grass.width; i++) {
      for(int j = 0; j < grass.height; j++){
        color grassPixel = grass.get(i, j);
        grassPixel = color(red(grassPixel), 255, blue(grassPixel), 255);
        grass.set(i, j, grassPixel);
      }
    }
  }
  if(key == 'e'){
    for(int i = 0; i < grass.width; i++) {
      for(int j = 0; j < grass.height; j++){
        color grassPixel = grass.get(i, j);
        grassPixel = color(red(grassPixel), green(grassPixel), 255, 255);
        grass.set(i, j, grassPixel);
      }
    }
  }
}

void mousePressed() {
  meteorites.add((Object)(new physicsObject("models/rock/rock_small.obj",
  new PVector(((mouseY-height/2)*1.05 + (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), ((mouseY-height/2)*1.05 - (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), 500f),
  new PVector(0,0,0), 
  10.f, 
  new PVector(60,60,50))));
}
float deltaTime() { //Scale speed and other physics computations wrt frame duration
  int delta;
  float deltaTime;
  delta = millis() - lastTime;
  lastTime = millis();
  deltaTime = delta*FPS/1000.0f;
  return deltaTime;
}
