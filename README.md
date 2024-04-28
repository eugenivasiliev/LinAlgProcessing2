# Linear Algebra with Processing 2. Meteorite Strikes

## Description

The project at hand was done as an assignment for a Linear Algebra class. As so, it serves as a demonstration of understanding and expertise with the following concepts:

- Matrices
- Isometric Perspective
- Line Equations
- LUTs
- Collisions

The project is in essence a destruction simulator, inspired by the Natural Disasters DLC from Cities Skylines. More information on it may be found in https://skylines.paradoxwikis.com/Natural_Disasters.

![image](https://github.com/eugenivasiliev/LinAlgProcessing2/assets/159423029/ae2f9eb4-e8b1-47eb-90ad-baa8cbfb201c)
(Credits for the image go to Paradox Interactive)

### Matrices
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
