CoordinateSystem co,X1,X2,dmc;
LorenzAttractor lorenz, lorenz2;
Switcher switcher;

final int lorenzSize=1000;
final int dim=3,lag=5;
float[][] dm; //distance Matrix
LimitedQueue<float[]> reconstructLorenz,reconstructLorenz2;  
float rx=-4.329999,ry=5.9999957,rdx=PI/2,rdy=-PI/2;
int p1,p2;

void setup(){
  size(1000,650,P3D);
  co = new CoordinateSystem(50,50,50);
  X1 = new CoordinateSystem(400,-100,"t","x");
  X2 = new CoordinateSystem(400,-100,"t","x");
  dmc = new CoordinateSystem(300,300,250);
  lorenz = new LorenzAttractor(lorenzSize);
  lorenz2 = new LorenzAttractor(lorenzSize);
  switcher = new Switcher(30,330,"Diagonal Line");
  for(int i=0;i<1000;i++){
    lorenz.run(); 
    lorenz2.run();
    lorenz2.run();
  }
  reconstructLorenz = DownSample.go(PhaseSpaceReconstruct.go(lorenz.getTrajectory(), dim, lag),5);
  reconstructLorenz2 = DownSample.go(PhaseSpaceReconstruct.go(lorenz2.getTrajectory(), dim, lag),5);
  dm = new float[reconstructLorenz.size()][reconstructLorenz.size()];
}

void draw(){
  background(255);  
  switcher.draw();
  if(p1>=dm.length){
    p1-=dm.length;
    p2++;
  }
  if(p2>=dm.length)p2-=dm.length;
  lorenz3D(reconstructLorenz,reconstructLorenz2,750,200,"Trajectory",true, p1, p2);
  dm[p1][p2]=lorenz3D(reconstructLorenz,reconstructLorenz2,750,500,"Distance",false, p1, p2);
  lorenzTimeSeriesPlot();
  distanceMatrixPlot();
  p1++;
}

void lorenzTimeSeriesPlot(){
  pushMatrix();
  translate(30,150);
  X1.draw();
  lorenzTimeSeries(lorenz.getTrajectory(),0,50);
  translate(0,150);
  X2.draw();
  stroke(0,255,0);
  lorenzTimeSeries(lorenz2.getTrajectory(),0,50);
  popMatrix();
}

void lorenzTimeSeries(LimitedQueue<float[]> ts,int i,int offsetY){
    float x=0;
    beginShape();
    strokeWeight(2);
    noFill();
    for(float[] point:ts){
      vertex(x,point[i]*2-offsetY);
      x+=0.4;
    }
    endShape();
}

void distanceMatrixPlot(){
  pushMatrix();
  translate(0,650,-100);
  rotateX(rdx);
  rotateZ(rdy);
  dmc.draw();
  stroke(0,50);
  for(int i=0;i<dm.length;i++)
    for(int j=0;j<dm.length;j++)
      if(i!=j||switcher.On())
        line(i*2,j*2,0,i*2, j*2, dm[i][j]*5);
  popMatrix();
}

float lorenz3D(LimitedQueue<float[]> ts1,LimitedQueue<float[]> ts2,int x,int y, String label, boolean trajectory, int p1, int p2){
  pushMatrix();
  translate(x-250,y-150,0);
  text(label,0,0);
  popMatrix();
  pushMatrix();
  translate(x,y,0);
  rotateX(rx);
  rotateY(ry);
  strokeWeight(1);
  co.draw();
  stroke(0);
  noFill();
  if(trajectory){
    beginShape();
    strokeWeight(1);
    for(float[] point:ts1){
      vertex(point[0]*5,point[1]*5,point[2]*5);
    }
    endShape();
    stroke(0,255,0);
    beginShape();
    for(float[] point:ts2){
      vertex(point[0]*5,point[1]*5,point[2]*5);
    }
    endShape();
  }
  strokeWeight(8);
  stroke(0);
  float[] point=ts1.get(p1);
  point(point[0]*5,point[1]*5,point[2]*5);
  float[] point2=ts2.get(p2);
  stroke(0,255,0);
  point(point2[0]*5,point2[1]*5,point2[2]*5);
  if(!trajectory){
    stroke(0);
    strokeWeight(2);
    line(point[0]*5,point[1]*5,point[2]*5,point2[0]*5,point2[1]*5,point2[2]*5);
    popMatrix();
    return dist(point[0],point[1],point[2],point2[0],point2[1],point2[2]);
  }
  popMatrix();  
  return 0;
}

void mouseDragged(){
  if(mouseX>width/2){
    ry+=(float)(pmouseX-mouseX)/100;
    rx+=(float)(pmouseY-mouseY)/100;
  }
  if(mouseX<width/2){
    rdy+=(float)(pmouseX-mouseX)/100;
    rdx+=(float)(pmouseY-mouseY)/100;
  }
}

void mouseClicked(){
  switcher.toggle();
}
