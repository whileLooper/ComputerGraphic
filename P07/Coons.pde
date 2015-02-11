/******** Editor of an Animated Coons Patch

Implementation steps:
**<01 Manual control of (u,v) parameters. 
**<02 Draw 4 boundary curves CT(u), CB(u), SL(v), CR(v) using proportional Neville
**<03 Compute and show Coons point C(u,v)
**<04 Display quads filed one-by-one for the animated Coons patch
**<05 Compute and show normal at C(u,v) and a ball ON the patch

*/
//**<01: mouseMoved; 'v', draw: uvShow()
float u=0, v=0, a = 0, b=0, c=0, d=0; 
pt[] left, right, top, bottom;
pts polyloop;

void uvShow() { 
  fill(red);
  if(keyPressed && key=='v')  text("u="+u+", v="+v,10,30);
  noStroke(); fill(blue); ellipse(u*width,v*height,5,5); 
  }


pts drawBorders(pt[] P, float e){ 
  top = new pt[]{P[0], P[1], P[2], P[3]};
  right = new pt[]{P[3], P[4], P[5], P[6]};
  bottom = new pt[]{P[6], P[7], P[8], P[9]};
  left = new pt[]{P[9], P[10], P[11], P[0]};
  
  polyloop = new pts();
  polyloop.declare();
  
  for(float i = 0f; i < 1f; i +=e) polyloop.addPt(computeABCD(top, i));
  for(float i = 0f; i < 1f; i +=e) polyloop.addPt(computeABCD(right, i));
  for(float i = 0f; i < 1f; i +=e) polyloop.addPt(computeABCD(bottom, i));
  for(float i = 0f; i < 1f; i +=e) polyloop.addPt(computeABCD(left, i));
  polyloop.drawClosedCurveAsRods(4);
  return polyloop;
}  

pt computeABCD(pt[] P, float t){
  a = 0;
  b = d(P[0], P[1]);
  c = b + d(P[1], P[2]);
  d = c + d(P[2], P[3]);
  b = b/d; c = c/d; d = 1;
  return N(a, P[0], b, P[1], c, P[2], d, P[3], t);
}

/*
0 1 2 3 
11    4
10    5
9 8 7 6
*/
void shadeSurface(pt[] P, float e){ 
  for(float s=0; s<1.001-e; s+=e) for(float t=0; t<1.001-e; t+=e) 
  {beginShape(); v(coons(P,s,t)); v(coons(P,s+e,t)); v(coons(P,s+e,t+e)); v(coons(P,s,t+e)); endShape(CLOSE);}
  }
  
pt coons(pt[] P, float s, float t){

  pt Lst = L(L(P[0], s, P[9]), t, L(P[3], s, P[6]));
  pt Lt = L(leftCurve(P, s), t, rightCurve(P, s));
  pt Ls = L(topCurve(P, t), s, downCurve(P, t));
  pt x = P(Lt.x+Ls.x-Lst.x, Lt.y+Ls.y-Lst.y, Lt.z+Ls.z-Lst.z); 
  return x;
}

pt leftCurve(pt[] P, float s){
  //(P[4], P[3], P[2], P[1], P[0], s);
  return computeABCD(new pt[]{P[0], P[11], P[10], P[9]}, s);
}

pt rightCurve(pt[] P, float s){
  //pt Lt = B(P[7], P[8], P[9], P[10], P[11], s);
  return computeABCD(new pt[]{P[3], P[4], P[5], P[6]}, s);
}

pt topCurve(pt[] P, float s){
  //pt Ls = N(0, P[4], 0.33, P[5], 0.66, P[6], 1.0, P[7], t);
  return computeABCD(new pt[]{P[0], P[1], P[2], P[3]}, s);
}

pt downCurve(pt[] P, float s){
  //pt Ls = N(0, P[0], 0.33, P[13], 0.66, P[12], 1.0, P[11], t);
  return computeABCD(new pt[]{P[9], P[8], P[7], P[6]}, s);
}

//**************************** Neville ****************************
pt N(float a, pt A, float b, pt B, float t){
   float scalar = (t-a)/(b-a);
   return L(A, scalar, B);
}
pt N(float a, pt A, float b, pt B, float c, pt C, float t){
  return N(a, N(a, A, b, B, t), c, N(b, B, c, C, t), t);
}
pt N(float a, pt A, float b, pt B, float c, pt C, float d, pt D, float t){
  return N(a, N(a, A, b, B, c, C, t), d, N(b, B, c, C, d, D, t), t);
}
