CoordinateSystem co,X,x[];
LorenzAttractor lorenz;
Switcher switcher;

final int lorenzSize=3000;
final int dim=3,lag=5;
LimitedQueue<float[]> reconstructLorenz;  
float rx=-4.329999,ry=5.9999957;

void setup(){
  size(1000,650,P3D);
  co = new CoordinateSystem(50,50,50);
  X = new CoordinateSystem(400,-100,"t","x");
  x = new CoordinateSystem[3];
  x[0] = new CoordinateSystem(400,-100,"t","x1=x(t)");
  x[1] = new CoordinateSystem(400,-100,"t","x2=x(t+lag)");
  x[2] = new CoordinateSystem(400,-100,"t","x3=x(t+2lag)");
  lorenz = new LorenzAttractor(lorenzSize);
  switcher = new Switcher(850,5,"Trajectory");
}

void draw(){
  background(255); 
  lorenz.run();    
  lorenz3D(lorenz.getTrajectory(),750,300,"Original");
  lorenz3D(reconstructLorenz,750,500,"Reconstructed");
  lorenzTimeSeriesPlot();
  switcher.draw();
}

void lorenzTimeSeriesPlot(){
  pushMatrix();
  translate(30,150);
  X.draw();
  lorenzTimeSeries(lorenz.getTrajectory(),0,50);
  reconstructLorenz = phaseSpaceReconstruct(lorenz.getTrajectory(), dim, lag);
  for(int i=0;i<3;i++){
    translate(0,150);
    x[i].draw();
    lorenzTimeSeries(reconstructLorenz,i,50);
  }
  popMatrix();
}

LimitedQueue<float[]> phaseSpaceReconstruct(LimitedQueue<float[]> ts, int dim, int lag){
  LimitedQueue<float[]> reconstruct = new LimitedQueue<float[]>(lorenzSize);
  for(int t=0;t+dim*lag<ts.size();t++){
    float[] point=new float[dim];
    for(int i=0;i<dim;i++){
      point[i]=ts.get(t+i*lag)[0];      
    }
    reconstruct.add(point);
  }
  return reconstruct;
}

void lorenzTimeSeries(LimitedQueue<float[]> ts,int i,int offsetY){
    float x=0;
    beginShape();
    strokeWeight(2);
    for(float[] point:ts){
      vertex(x,point[i]*2-offsetY);
      x+=0.13;
    }
    endShape();
}

void lorenz3D(LimitedQueue<float[]> ts,int x,int y, String label){
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
  if(switcher.On()){
    beginShape();
    strokeWeight(3);
    for(float[] point:ts){
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
