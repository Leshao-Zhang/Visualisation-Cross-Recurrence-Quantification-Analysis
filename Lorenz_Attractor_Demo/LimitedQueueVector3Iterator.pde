import java.util.Iterator;

class LimitedQueueVector3Iterator implements Iterator<float[]>{
  private LimitedQueueVector3 queue;
  private int current;
  
  LimitedQueueVector3Iterator(LimitedQueueVector3 queue){
    this.queue=queue;
  }
  
  boolean hasNext(){
    if(current<queue.size())return true;
    return false;
  }
  
  float[] next(){
    return queue.get(current++);
  }
}
