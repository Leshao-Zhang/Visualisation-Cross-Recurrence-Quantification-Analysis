class PhaseSpaceReconstruct{
  static LimitedQueue<float[]> go(LimitedQueue<float[]> ts, int dim, int lag){
    LimitedQueue<float[]> reconstruct = new LimitedQueue<float[]>(ts.size()-dim*lag);
    for(int t=0;t+dim*lag<ts.size();t++){
      float[] point=new float[dim];
      for(int i=0;i<dim;i++){
        point[i]=ts.get(t+i*lag)[0];      
      }
      reconstruct.add(point);
    }
    return reconstruct;
  }
}
