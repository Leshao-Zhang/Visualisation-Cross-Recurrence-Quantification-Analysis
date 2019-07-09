import java.lang.Math;  
import java.util.HashMap;

class RecurrentMatrix{
  private float[][] distanceMatrix;
  private float[][] recurrentMatrix;
  private float recurrentRate;
  private int lineMax;
  private float deterministic;
  private HashMap<Integer,Integer> lineHist;
  private boolean diagonal;
  private int radius;
  
  RecurrentMatrix(LimitedQueue<float[]> ts,int dim,int lag, int radius){
    LimitedQueue<float[]> reconstruct = PhaseSpaceReconstruct.go(ts, dim, lag);
    distanceMatrix = new float[reconstruct.size()][reconstruct.size()];
    for(int p1=0;p1<distanceMatrix.length;p1++){
      for(int p2=0;p2<distanceMatrix[0].length;p2++){
        distanceMatrix[p1][p2]=euclideanDistance(reconstruct.get(p1),reconstruct.get(p2));
      }
    }
    this.radius=radius;
    setRadius(radius);    
  }
  
  private float euclideanDistance(float[] p1,float[] p2){
    double sum=0;
    for(int dim=0;dim<p1.length;dim++){
      sum+=(p1[dim]-p2[dim])*(p1[dim]-p2[dim]);
    }
    return (float)Math.sqrt(sum);
  }
  
  public float[][] getDistanceMatrix(){
    return distanceMatrix;
  }
  
  public void diagonal(boolean On){
    diagonal=On;
    setRadius(radius);
  }
  
  public float[][] getRecurrentMatrix(){
    return recurrentMatrix;
  }
  
  public void setRadius(int radius){
    this.radius=radius;
    float recurrent=0;
    recurrentMatrix = new float[distanceMatrix.length][distanceMatrix[0].length];
    for(int i=0;i<distanceMatrix.length;i++){
      for(int j=0;j<distanceMatrix[0].length;j++){
        if(diagonal||i!=j)
          if(distanceMatrix[i][j]<=radius){
            recurrentMatrix[i][j]=1;
            recurrent++;
          }
      }
    }
    recurrentRate=recurrent/(distanceMatrix.length*distanceMatrix[0].length);
    lineHistogram();
  }
  
  public float getRecurrentRate(){
    return recurrentRate;
  }
  
  public int getLMAX(){
    return lineMax;
  }
  
  public float getDeterminist(){
    return deterministic;
  }
  
  private void lineHistogram(){
    lineHist = new HashMap<Integer,Integer>();
    int line=0;
    for(int x=0;x<recurrentMatrix.length;x++){
      for(int d=0;x+d<recurrentMatrix.length;d++){
          if(recurrentMatrix[x+d][d]==1){
            line++;
          }else{
            increase(lineHist,line);
            line=0;
          }
      }
      if(line!=0)increase(lineHist,line);
      line=0;
    }
    line=0;
    for(int y=1;y<recurrentMatrix[0].length;y++){
      for(int d=0;d+y<recurrentMatrix[0].length;d++){
          if(recurrentMatrix[d][y+d]==1){
            line++;
          }else{
            increase(lineHist,line);
            line=0;
          }
      }
      if(line!=0)increase(lineHist,line);
      line=0;
    }
    float totalLine=0;
    lineMax=0;
    float totalPoint=0;
    for(int l:lineHist.keySet()){
      if(l>lineMax)lineMax=l;
      if(l>1)totalLine+=l*lineHist.get(l);
      totalPoint+=l*lineHist.get(l);
    }
    deterministic=totalLine/totalPoint;
  }
  
  private void increase(HashMap<Integer,Integer> hm, int k){
    if(!hm.containsKey(k)){
      hm.put(k,1);
    }else{
      hm.put(k,hm.get(k)+1);
    }
  }
  
}
