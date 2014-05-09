/**
  These are the individual waves of the ocean.
  
  this should have a variable that says mark for removal
**/
class Wave {
  public ArrayList<Wavelet> wavelets;
  public ArrayList<WaveCrash> wavePoints;
  public float vel;
  public float maxVel;
   float accel;
  public float accelDecreaseRate;
  public float life;
  public static final float maxLife = 100;
  
  public Wave(int size, float vel, float maxVel, float accel, float accelDecreaseRate) {
    this.wavePoints = new ArrayList<WaveCrash>(size);
    for(int i = 0; i < size; i++) {
      this.wavePoints.add(new WaveCrash(i * width / size));
    }
    
    this.wavelets = new ArrayList<Wavelet>();
    
    this.vel = vel;
    this.maxVel = maxVel;
    this.accel = accel;
    this.accelDecreaseRate = accelDecreaseRate;
    this.life = this.maxLife;
  }
  
  public void generateSinWave(float amp, float offset) {
    float freq = 2 * PI / wavePoints.size();
    
    for(int i = 0; i < this.wavePoints.size(); i++) {
      // make sure that all the parts of the wave are positive
      this.wavePoints.get(i).y = amp * (1 + sin(freq * i + offset));
    }
  }
  
  public void update() {
    this.accel -= this.accelDecreaseRate;
    if(abs(this.vel) >= this.maxVel) {
      // this line just makes sure that abs(vel) is less than maxVel
      this.vel *= 1 / abs(this.vel) * this.maxVel;
      
      if(this.vel > 0) {
        for(WaveCrash crash : wavePoints) {
          crash.circleDiam += random(.1);
        }
      } else {
        for(WaveCrash crash : wavePoints) {
          crash.circleDiam -= random(.1);
        }
      }
    }

    this.vel += this.accel;
    for(Wavelet wavelet : this.wavelets) {
      wavelet.y += this.vel + random(this.vel);
    }
    
    for(int i = 0; i < this.wavePoints.size(); i++) { 
      this.wavePoints.get(i).y += this.vel + random(this.vel);
    }
    
    // have a 5% chance that a wavelet will spawn for each row
    for(int i = 0; i < this.wavePoints.size(); i++) {
      if(random(100) < 1) {
        Wavelet wavelet = new Wavelet(this.wavePoints.get(i).x);
        wavelet.y = random(this.wavePoints.get(i).y);
        this.wavelets.add(wavelet);
      }
    }
    
    for(Wavelet wavelet : this.wavelets) {
      wavelet.update();
    }
    
    this.life -= random(2);
    this.life = max(this.life, 0);
    
  }
  
  public void render() {
    int alpha = (int) (255 * life / maxLife);
    for(Wavelet wavelet : this.wavelets) {
//      wavelet.alpha = alpha;
      wavelet.render();
    }
    for(int i = 0; i < wavePoints.size(); i++) {
      wavePoints.get(i).alpha = alpha;
      wavePoints.get(i).render();
    }
  }
}
