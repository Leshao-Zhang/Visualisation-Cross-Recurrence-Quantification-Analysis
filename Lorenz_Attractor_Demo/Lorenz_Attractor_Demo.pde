import peasy.*;

PeasyCam cam;
LorenzAttractor lorenz;
boolean trajectory;

void setup(){
  size(400,400,P3D);
  cam = new PeasyCam(this,100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  lorenz = new LorenzAttractor(1000);
}

void draw(){
  background(255);
  lorenz.run();
  stroke(0);
  noFill();
  if(trajectory){
    beginShape();
    strokeWeight(3);
    for(float[] point:lorenz.getTrajectory()){
      vertex(point[0],point[1],point[2]);
    }
    endShape();
  }else{
    strokeWeight(5);
    float[] point=lorenz.getPoint();
    point(point[0],point[1],point[2]);
  }
  cam.beginHUD();
  button();
  cam.endHUD();
}

void button(){
  strokeWeight(3);
  if(trajectory){
    fill(0);
  }else{
    noFill();
  }
  rect(10, 10, 25, 25);
  textSize(25);
  fill(0);
  text("Trajectory",38,32);  
}

void mouseClicked(){
  if (mouseX>=10&&mouseX<=35&&mouseY>=10&&mouseY<=35) {
    trajectory=!trajectory;
  }
}
