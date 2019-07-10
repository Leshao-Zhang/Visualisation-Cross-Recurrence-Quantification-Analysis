class LorenzAttractor{
  
  private float sigma=10f;
  private float beta=8/3f;
  private float rho=28f;
  private float dt=0.01f;
  private int size=1000;
  private float[] xyz = {1f,1f,1f};
  private LimitedQueue<float[]> trajectory;
  
  public LorenzAttractor(){
    trajectory=new LimitedQueue<float[]>(size);
  }
  
  public LorenzAttractor(int size){
    this.size=size;
    trajectory=new LimitedQueue<float[]>(size);
  }
  
  public LorenzAttractor(float[] xyz, float sigma,float beta,float rho,float dt,int size){
    this.xyz=xyz;
    this.sigma=sigma;
    this.beta=beta;
    this.rho=rho;
    this.dt=dt;
    this.size=size;
    trajectory=new LimitedQueue<float[]>(size);
  }
  
  public void run(){
    float dx=(sigma*(xyz[1]-xyz[0]))*dt;
    float dy=(xyz[0]*(rho-xyz[2])-xyz[1])*dt;
    float dz=(xyz[0]*xyz[1]-beta*xyz[2])*dt;
    xyz[0]+=dx;
    xyz[1]+=dy;
    xyz[2]+=dz;
    trajectory.add(xyz.clone());    
  }

  public float[] getPoint(){
    return xyz;
  }
  
  public LimitedQueue<float[]> getTrajectory(){
    return trajectory; //<>//
  }
}
