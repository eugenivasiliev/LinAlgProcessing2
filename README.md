# Linear Algebra with Processing 2. Meteorite Strikes

This README is intended to be seen on github, at https://github.com/eugenivasiliev/LinAlgProcessing2

## Description

The project at hand was done as an assignment for a Linear Algebra class. As so, it serves as a demonstration of understanding and expertise with the following concepts:

- Homogenous Transformations/Matrices
- Isometric Perspective
- Line Equations
- LUTs
- Collisions

The project is in essence a destruction simulator, inspired by the Natural Disasters DLC from Cities Skylines. More information on it may be found in https://skylines.paradoxwikis.com/Natural_Disasters.

![image](https://github.com/eugenivasiliev/LinAlgProcessing2/assets/159423029/ae2f9eb4-e8b1-47eb-90ad-baa8cbfb201c)
(Credits for the image go to Paradox Interactive)

Additionally, the models follow a medieval aesthetic, although the models are quite simple due to the many polygons taking up a notable amount of processing. Nonetheless, the project follows thus two of the themes presented in the task.

### Homogenous Transformations/Matrices
To carry out all of the rendering and model positioning, homogenous transformations are used to properly treat the coordinates, angles, and scale of the objects. Since many instances of the use of these may be found around the code, we provide just one of many examples of its use:

```
pushMatrix();
translate(pos.x,pos.y,pos.z);
shape(this.mesh);
if(debug){
  noFill();
  stroke(00,255,00);
  box(hitboxSize.x, hitboxSize.y, hitboxSize.z);
}
popMatrix();
```

### Isometric Perspective
The project is performed entirely in Isometric Perspective. To achieve this effect, three homogenous transformations were performed. Firstly, a translation by $(\frac{width}2, \frac{height}2, 0)$ was made to center the origin and work with more simplified coordinates. Then, a 35.264 degree rotation is performed around the $X$ axis, and a 45 degree rotation is performed around the $Z$ axis. As such, an Isometric Perspective is achieved.

### Line Equations
Since the Isometric Perspective is implemented, the $XY$-plane coordinates of the mouse pointer become nontrivial. To find them, we consider a plane $\pi_0$ placed at the camera's position, with normal vector $(1, 1, 1)$ (non-normalised). From here, the mouse's position at $\pi_0$ is much simpler, and a point $P$ in the 3D space is obtained. Then, using the line $l\colon P + \alpha(1,1,1)$ one can find a point $P'$ in the $XY$-plane, corresponding to the mouse pointer. The final position would be:

```
(((mouseY-height/2)*1.05 + (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), ((mouseY-height/2)*1.05 - (mouseX-width/2)*cos(radians(30)))*cos(radians(35.264)), 0f)
```
An example of the procedure would be:
<p align="center">
  <img src="https://github.com/eugenivasiliev/LinAlgProcessing2/assets/159423029/9c9fbde6-f984-422d-8a57-4ce3721ad553" alt="Geometric construction of the point P'"/>
</p>

### LUTs
For the sprites and other images, a couple of LUT effects have been made use of. A prominent example is the texture used for the aiming function, likely the one texture the player will most see. In it, a small filter is performed so as to make it more transparent the further from the center a point is, so the player may properly see behind it and focus on the object destruction. The code for this effect is provided below. Additionally, the grass' texture may be changed using the q, w, e keys (for a red, green, and blue effect) and the s key for a reset. The effects can be combined for different colors too.

```
//LUT formatting for the aim texture, making it more opaque the closer to the center a pixel is
aim = loadImage("textures/aim.png");
aim.format = ARGB;
  
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
```

### Collisions
The collisions are handled using a Bounding Box approach, since a simplified collision is enough given the project's purposes. To do so, a separate Object class was created, and its bounding box is set so it follows the object's visuals. A collision function is then used to check for any collisions so the destruction can be done. The collision code is provided below.

```
boolean collision(Object o1, Object o2){
  return (
    (o1.pos.x + o1.hitboxSize.x > o2.pos.x && o1.pos.y + o1.hitboxSize.y > o2.pos.y && o1.pos.z + o1.hitboxSize.z > o2.pos.z) &&
    (o1.pos.x < o2.pos.x +o2.hitboxSize.x && o1.pos.y < o2.pos.y + o2.hitboxSize.y && o1.pos.z < o2.pos.z + o2.hitboxSize.z) 
  );
}
```
