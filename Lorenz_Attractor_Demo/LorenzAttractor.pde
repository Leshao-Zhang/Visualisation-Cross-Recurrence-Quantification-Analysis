import java.util.LinkedList;

class LorenzAttractor{
  
  private float sigma=10;
  private float beta=8/3;
  private float rho=28;
  private float dt=0.01;
  private int size=1000;
  private float[] xyz = {1,1,1};
  private LimitedQueueVector3 trajectory;
  
  LorenzAttractor(){
    trajectory=new LimitedQueueVector3(size);
  }
  
  LorenzAttractor(int size){
    this.size=size;
    trajectory=new LimitedQueueVector3(size);
  }
  
  LorenzAttractor(float[] xyz, float sigma,float beta,float rho,float dt,int size){
    this.xyz=xyz;
    this.sigma=sigma;
    this.beta=beta;
    this.rho=rho;
    this.dt=dt;
    this.size=size;
    trajectory=new LimitedQueueVector3(size);
  }
  
  void run(){
    float dx=(sigma*(xyz[1]-xyz[0]))*dt;
    float dy=(xyz[0]*(rho-xyz[2])-xyz[1])*dt;
    float dz=(xyz[0]*xyz[1]-beta*xyz[2])*dt;
    xyz[0]+=dx;
    xyz[1]+=dy;
    xyz[2]+=dz;
    trajectory.add(xyz.clone());    
  }

  float[] getPoint(){
    return xyz;
  }
  
  LimitedQueueVector3 getTrajectory(){
    return trajectory; //<>//
  }
}
