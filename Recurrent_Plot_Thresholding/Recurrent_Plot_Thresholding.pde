CoordinateSystem X,dmc,rpc;
LorenzAttractor lorenz;
Switcher switcher;
RecurrentMatrix rm;
Button inc,dec;

final int lorenzSize=1000;
final int dim=3,lag=5;
int radius=3;
float rdx=0.4607969,rdy=-1.2607974;
final int rpScale=400;

void setup(){
  size(1000,650,P3D);
  X = new CoordinateSystem(400,-100,"t","x");
  dmc = new CoordinateSystem(300,300,300);
  rpc = new CoordinateSystem(rpScale,-rpScale,"","");
  lorenz = new LorenzAttractor(lorenzSize);
  switcher = new Switcher(30,180,"Diagonal Line");
  for(int i=0;i<1000;i++){
    lorenz.run(); 
  }
  rm = new RecurrentMatrix( DownSample.go(lorenz.getTrajectory(),5),dim,lag,radius);
  inc = new Button(390, 592, "+");
  dec = new Button(150, 592, "-");
}

void draw(){
  background(255);  
  switcher.draw();
  inc.draw();
  dec.draw();
  lorenzTimeSeriesPlot(30,150);
  distanceMatrixPlot(100,500,-100);
  recurrentPlot(550,600);
  text("Threshold = "+radius, 180,600);
  text("Recurrence Rate (REC)    = "+(float)round(rm.getRecurrentRate()*10000)/100,550,70);
  text("Max Line Length (LMAX) = " +rm.getLMAX(),550,110);
  text("Deterministic Rate (DET) = "+(float)round(rm.getDeterminist()*10000)/100,550,150);
}

void lorenzTimeSeriesPlot(int x, int y){
  pushMatrix();
  translate(x,y);
  X.draw();
  lorenzTimeSeries(lorenz.getTrajectory(),0,50);
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

void recurrentPlot(int x, int y){
  pushMatrix();
  translate(x,y);
  stroke(0);
  rpc.draw();
  strokeWeight(3);
  for(int i=0;i<rm.getRecurrentMatrix().length;i++){
    for(int j=0;j<rm.getRecurrentMatrix()[0].length;j++){
      if(i!=j||switcher.On())
        if(rm.getRecurrentMatrix()[i][j]==1)point(i*rpScale/rm.getRecurrentMatrix().length,(rm.getRecurrentMatrix()[0].length-j)*rpScale/rm.getRecurrentMatrix().length-rpScale);
    }
  }
  popMatrix();
}

void distanceMatrixPlot(int x,int y,int z){
  pushMatrix();
  translate(x,y,z);
  rotateX(rdx);
  rotateZ(rdy);
  dmc.draw();
  stroke(0,50);
  for(int i=0;i<rm.getDistanceMatrix().length;i++)
    for(int j=0;j<rm.getDistanceMatrix().length;j++)
      if(i!=j||switcher.On())
        line(i*1.5,j*1.5,0,i*1.5, j*1.5, rm.getDistanceMatrix()[i][j]*4);
  fill(0);
  translate(rm.getDistanceMatrix().length*1.5/2,rm.getDistanceMatrix()[0].length*1.5/2,radius*4-1);
  box((float)rm.getDistanceMatrix().length*1.5+20,(float)rm.getDistanceMatrix()[0].length*1.5+20,1);
  popMatrix();
}

void mouseDragged(){
    rdy+=(float)(pmouseX-mouseX)/100;
    rdx+=(float)(pmouseY-mouseY)/100;
}

void mouseClicked(){
  switcher.toggle();
  if(inc.clicked())rm.setRadius(++radius);
  if(dec.clicked())rm.setRadius(--radius);
}
