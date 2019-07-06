import java.util.Iterator;

class LimitedQueueIterator<T> implements Iterator<T>{
  private LimitedQueue<T> queue;
  private int current;
  
  LimitedQueueIterator(LimitedQueue<T> queue){
    this.queue=queue;
  }
  
  boolean hasNext(){
    if(current<queue.size())return true;
    return false;
  }
  
  T next(){
    return queue.get(current++);
  }
}
