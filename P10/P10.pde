PShader catShader, colorShader;
PImage catTexture;

float offset = -10;

void setup() {
  size(640, 640, P3D);
  noStroke();
  fill(204);
  
  catTexture = loadImage("data/dotaLogo1.png");
  catShader = loadShader("data/TextFrag.glsl", "data/TextVert.glsl");
  colorShader = loadShader("data/BasicFrag.glsl", "data/BasicVert.glsl");
}

float time = 0.0f;

void draw() {
  time += 0.1;
  
  background(0); 
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  if (mousePressed) 
    offset += (mouseX - pmouseX); /// float(width);
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  translate(width/2, height/2);
  
  // Picture in the background
  // Provided so that you can see "holes"
  // where the sphere is transparent, and have an
  // example of how to use textures with shaders
  shader(colorShader);
  noStroke();
  fill(#00FFAA);
  textureMode(NORMAL);
  beginShape();
    texture(catTexture);
    vertex(-300, -300, -200, 0,0);
    vertex( 300, -300, -200, 1,0);
    vertex( 300,  300, -200, 1,1);
    vertex(-300,  300, -200, 0,1);
  endShape();
  
  // Sphere
  //resetShader(); // replace resetShader() with a call to use your own shader
 // fill(#FFFFFF);
  //stroke(#FF0000);
  sphereDetail(32);
  sphere(120);
}
