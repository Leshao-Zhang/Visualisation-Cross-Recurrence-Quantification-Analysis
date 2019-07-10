class Button{
  private int x,y;
  private int[] size={20,20};
  private String label;
  
  Button(int x,int y,String label){
    this.x=x;
    this.y=y;
    this.label=label;
  }
  
  void draw(){
    stroke(0);
    noFill();
    strokeWeight(1);
    ellipse(x, y, size[0], size[1]);
    textSize(size[0]+2);
    fill(0);
    text(label,x-size[1]/2+2,y+size[1]/2-2);  
  }
  
  boolean clicked(){
    if (mouseX>=x-size[0]&&mouseX<=x+size[0]+5&&mouseY>=y-size[0]&&mouseY<=y+size[1]+5) {
      return true;
    }
    return false;
  }
}
