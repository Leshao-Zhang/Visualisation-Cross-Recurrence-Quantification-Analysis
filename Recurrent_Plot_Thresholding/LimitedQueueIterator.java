import java.util.Iterator;

class LimitedQueueIterator<T> implements Iterator<T>{
  private LimitedQueue<T> queue;
  private int current;
  
  public LimitedQueueIterator(LimitedQueue<T> queue){
    this.queue=queue;
  }
  
  public boolean hasNext(){
    if(current<queue.size())return true;
    return false;
  }
  
  public T next(){
    return queue.get(current++);
  }
}
