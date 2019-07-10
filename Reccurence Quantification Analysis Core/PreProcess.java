abstract class PreProcess{
  
  public static LimitedQueue<Float> downSample(LimitedQueue<Float> ts, int rate){
    LimitedQueue<Float> out=new LimitedQueue<Float>(ts.size()/rate);
    for(int i=0;i<ts.size();i+=rate){
      out.add(ts.get(i));
    }
    return out;
  }
  
  public static LimitedQueue<Float> dimension(LimitedQueue<float[]> ts, int dim){
    LimitedQueue<Float> out=new LimitedQueue<Float>(ts.size());
    for(int i=0;i<ts.size();i++){
      out.add(ts.get(i)[dim]);
    }
    return out;
  }
   
}
