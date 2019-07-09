class CoordinateSystem{
  private int x,y,z;  
  private String labelx,labely;
  private int dim;
  
  CoordinateSystem(int x, int y, int z){
    this.x=x;
    this.y=y;
    this.z=z;
    dim=3;
  }
  
  CoordinateSystem(int x,int y, String labelx,String labely){
    this.x=x;
    this.y=y;
    this.labelx=labelx;
    this.labely=labely;
    dim=2;
  }
  
  
  public void draw(){
    if(dim==2)draw2D();
    if(dim==3)draw3D();
  }  
  
  private void draw2D(){
    fill(0);
    strokeWeight(1);
    line(0,0,x,0);
    line(0,0,0,y);
    textSize(25);
    text(labelx,x,1);
    text(labely,1,y);
  }
  
  private void draw3D(){
    stroke(255,0,0);
    line(0,0,0,x,0,0);
    stroke(0,255,0);
    line(0,0,0,0,y,0);
    stroke(0,0,255);
    line(0,0,0,0,0,z);
  }
}
