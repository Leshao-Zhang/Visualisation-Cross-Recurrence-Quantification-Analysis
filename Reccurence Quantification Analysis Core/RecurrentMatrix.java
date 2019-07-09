import java.lang.Math;  
import java.util.HashMap;

class RecurrentMatrix{
  private float[][] distanceMatrix;
  private float[][] recurrentMatrix;
  private float recurrentRate;
  private int lineMax;
  private float deterministic;
  private HashMap<Integer,Integer> lineHist;
  
  RecurrentMatrix(LimitedQueue<float[]> ts,int dim,int lag, int radius){
    LimitedQueue<float[]> reconstruct = PhaseSpaceReconstruct.go(ts, dim, lag);
    distanceMatrix = new float[reconstruct.size()][reconstruct.size()];
    for(int p1=0;p1<distanceMatrix.length;p1++){
      for(int p2=0;p2<distanceMatrix[0].length;p2++){
        distanceMatrix[p1][p2]=euclideanDistance(reconstruct.get(p1),reconstruct.get(p2));
      }
    }
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
  
  public float[][] getRecurrentMatrix(){
    return recurrentMatrix;
  }
  
  public void setRadius(int radius){
    float recurrent=0;
    recurrentMatrix = new float[distanceMatrix.length][distanceMatrix[0].length];
    for(int i=0;i<distanceMatrix.length;i++){
      for(int j=0;j<distanceMatrix[0].length;j++){
        if(distanceMatrix[i][j]<=radius){
          recurrentMatrix[i][j]=1;
          recurrent++;
        }
      }
    }
    recurrentRate=recurrent/(distanceMatrix.length*distanceMatrix[0].length);
    lineHist = new HashMap<Integer,Integer>();
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
    int line=0;
    for(int x=0;x<recurrentMatrix.length;x++){
      for(int y=0;x+y<recurrentMatrix.length;y++){
        if(recurrentMatrix[x+y][y]==1){
          line++;
        }else{
          if(!lineHist.containsKey(line)){
            lineHist.put(line,1);
          }else{
            lineHist.put(line,lineHist.get(line)+1);
          }
          line=0;
        }
      }
    }
    line=0;
    for(int y=1;y<recurrentMatrix[0].length;y++){
      for(int x=0;x+y<recurrentMatrix[0].length;x++){
        if(recurrentMatrix[x][x+y]==1){
          line++;
        }else{
          Integer old=lineHist.get(line);
          if(old==null){
            lineHist.put(line,1);
          }else{
            lineHist.put(line,old+1);
          }
          line=0;
        }
      }
    }
    float totalLine=0;
    for(int l:lineHist.keySet()){
      if(l>lineMax)lineMax=l;
      if(l>1)totalLine+=l*lineHist.get(l);
    }
    deterministic=totalLine/(recurrentMatrix.length*recurrentMatrix[0].length);
  }
  
}
