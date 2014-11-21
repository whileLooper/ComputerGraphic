// Fragment shader
// The fragment shader is run once for every /pixel/ (not vertex!)
// It can change the color and transparency of the fragment.
/Users/bochen/Documents/CS3451/P10/data/TextVert.glsl
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

// Set in Processing
uniform sampler2D texture;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;

void main() {
	float intensity;
	vec4 color;
	intensity = max(0.0, dot(vertLightDir, vertNormal));
	
	if (intensity > 0.95){
		color = vec4(vec3(1.0), 1.0);
		} else if (intensity > 0.5){
			color = vec4(vec3(0.6), 1.0);
		} eles if (intensity > 0.25){
			color = vec4(vec3(0.3), 1.0);
		} else {
			color = vec4(vec3(0.0), 1.0);
		}	  
  gl_FragColor = color * vertColor;
}