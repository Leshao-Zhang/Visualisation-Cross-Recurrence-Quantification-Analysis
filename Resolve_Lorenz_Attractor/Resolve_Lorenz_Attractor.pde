CoordinateSystem co,X,Y,Z;
LorenzAttractor lorenz;
Switcher switcher;

float rx=-2.16,ry=6.33;

void setup(){
  size(1000,500,P3D);
  co = new CoordinateSystem(50,50,50);
  X = new CoordinateSystem(400,-100,"t","x(1)");
  Y = new CoordinateSystem(400,-100,"t","x(2)");
  Z = new CoordinateSystem(400,-100,"t","x(3)");
  lorenz = new LorenzAttractor(3000);
  switcher = new Switcher(850,5,"Trajectory");
}

void draw(){
  background(255); 
  lorenz.run();    
  lorenz3D();
  lorenzTimeSeriesPlot();
  switcher.draw();
}

void lorenzTimeSeriesPlot(){
  pushMatrix();
  translate(30,150);
  X.draw();
  lorenzTimeSeries(0,50);
  translate(0,150);
  Y.draw();
  lorenzTimeSeries(1,50);
  translate(0,150);
  Z.draw();
  lorenzTimeSeries(2,100);
  popMatrix();
}

void lorenzTimeSeries(int i,int offsetY){
    float x=0;
    beginShape();
    strokeWeight(2);
    for(float[] point:lorenz.getTrajectory()){
      vertex(x,point[i]*2-offsetY);
      x+=0.13;
    }
    endShape();
}

void lorenz3D(){
  pushMatrix();
  translate(750,300,0);
  rotateX(rx);
  rotateY(ry);
  strokeWeight(1);
  co.draw();
  stroke(0);
  noFill();
  if(switcher.On()){
    beginShape();
    strokeWeight(3);
    for(float[] point:lorenz.getTrajectory()){
      vertex(point[0]*5,point[1]*5,point[2]*5);
    }
    endShape();
  }else{
    strokeWeight(5);
    float[] point=lorenz.getPoint();
    point(point[0],point[1],point[2]);
  }
  popMatrix();
}

void mouseDragged(){
  ry+=(float)(pmouseX-mouseX)/100;
  rx+=(float)(pmouseY-mouseY)/100;
}

void mouseClicked(){
  switcher.toggle();
}
