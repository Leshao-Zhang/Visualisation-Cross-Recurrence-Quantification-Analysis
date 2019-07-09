import java.util.Iterator;

class LimitedQueue<T> implements Iterable<T>{  
  private int size;
  private T[] queue;
  private int start;
  private int end;
  private boolean full;
  
  public LimitedQueue(int size){
    this.size=size;
    queue=(T[])(new Object[size]);
  }
  
  public Iterator<T> iterator(){
    return new LimitedQueueIterator<T>(this);
  }
  
  public void add(T t){
    if(end>=size){
      end=0;
      full=true;
    }
    if(full){
      if(start>=size)start=0;
      start++;
    }
    queue[end++]=t;
  }
  
  public T get(int index){
    index=start+index;
    if(index>=size)index-=size;
    return queue[index];
  }
  
  public int size(){
    if(full)return size;
    return end;
  }
}
