import peasy.*;

PeasyCam cam;
LorenzAttractor lorenz;

void setup(){
  size(400,400,P3D);
  cam = new PeasyCam(this,100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  lorenz = new LorenzAttractor(10000);
}

void draw(){
  background(255);
  lorenz.run();
  stroke(0);
  strokeWeight(3);
  noFill();
  beginShape();
  for(float[] point:lorenz.getTrajectory()){
    vertex(point[0],point[1],point[2]);
  }
  endShape();
}
