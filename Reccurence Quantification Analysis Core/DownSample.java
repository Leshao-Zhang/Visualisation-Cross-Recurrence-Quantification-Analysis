class DownSample{
  static LimitedQueue<float[]> go(LimitedQueue<float[]> ts, int rate){
    LimitedQueue<float[]> out=new LimitedQueue<float[]>(ts.size()/rate);
    for(int i=0;i<ts.size();i+=rate){
      out.add(ts.get(i));
    }
    return out;
  }
}
