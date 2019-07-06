class LimitedQueueVector3 implements Iterable<float[]>{  
  private int size;
  private float[][] queue;
  private int start;
  private int end;
  private boolean full;
  
  LimitedQueueVector3(int size){
    this.size=size;
    queue=new float[size][3];
  }
  
  Iterator<float[]> iterator(){
    return new LimitedQueueVector3Iterator(this);
  }
  
  void add(float[] vector3){
    if(end>=size){
      end=0;
      full=true;
    }
    if(full){
      if(start>=size)start=0;
      start++;
    }
    queue[end++]=vector3;
  }
  
  float[] get(int index){
    index=start+index;
    if(index>=size)index-=size;
    return queue[index];
  }
  
  int size(){
    if(full)return size;
    return end;
  }
}
