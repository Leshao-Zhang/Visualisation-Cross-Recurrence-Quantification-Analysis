class Switcher{
  private boolean On;
  private int x,y;
  private int[] size={20,20};
  private String label;
  
  Switcher(int x,int y,String label){
    this.x=x;
    this.y=y;
    this.label=label;
  }
  
  void draw(){
    if(On){
      fill(0);
    }else{
      noFill();
    }
    stroke(0);
    rect(x, y, size[0], size[1]);
    textSize(size[0]);
    fill(0);
    text(label,x+size[0]+5,y+size[1]/2+5);  
  }
  
  void toggle(){
    if (mouseX>=x&&mouseX<=x+size[0]&&mouseY>=y&&mouseY<=y+size[1]) {
      On=!On;
    }
  }
  
  boolean On(){
    return On;
  }
}
