PShader catShader, colorShader, colorShader2, specularShader;
PImage catTexture;

float offset = -10;
float time = 0.0f;
float shininess = 2.0f;

boolean color1 = false, color2 = false;

void setup() {
  size(640, 640, P3D);
  noStroke();
  fill(204);
  
  catTexture = loadImage("data/dotaLogo1.png");
  catShader = loadShader("data/TextFrag.glsl", "data/TextVert.glsl");
  colorShader = loadShader("data/BasicFrag.glsl", "data/BasicVert.glsl");
  colorShader2 = loadShader("data/2frag.glsl", "data/2vert.glsl");
  colorShader.set("time", time*(mouseX/100));
  colorShader.set("mouseY", (mouseY/200.0));
  colorShader2.set("mouseX", (mouseX-320)*120.);
  colorShader2.set("mouseY", (mouseY-320)*120.); 

}


void draw() {
  time += 0.1;
  colorShader.set("time", time*(mouseX/100)); 
  colorShader.set("mouseY", (mouseY/200.0));
  colorShader2.set("mouseX", ((mouseX-320)*120.)/320);
  colorShader2.set("mouseY", ((mouseY-320)*120.)/320); 
 

  background(0);
  
  if(color1){
    shader(colorShader);
  } else if(color2) {
    shader(colorShader2);
  } 
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
  
  sphere(120);
  if(color1){
    shader(colorShader); 
  } else if(color2) {
    shader(colorShader2);
  }

  fill(#FFFFFF);
  stroke(#FF0000);
  sphereDetail(32);      
}

void keyPressed(){
  if(key == '1'){
    if(color2){
      color2 = !color2;
    }
    color1 = !color1;
  } 
  if(key == '2'){
    if(color1){
      color1 = !color1;
    }
    color2 = !color2;
  } 
}
