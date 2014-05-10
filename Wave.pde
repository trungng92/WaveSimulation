/**
  These are the individual waves of the ocean.
  
  this should have a variable that says mark for removal
**/
class Wave {
//  public ArrayList<Wavelet> wavelets;
  public Wavelet wavelet;
  public ArrayList<WaveCrash> wavePoints;
  public float vel;
  public float maxVel;
  public float accel;
  public float accelDecreaseRate;
  public float life;
  public static final float maxLife = 100;
  
  public Wave(int size, float vel, float maxVel, float accel, float accelDecreaseRate) {
    this.wavePoints = new ArrayList<WaveCrash>(size);
    for(int i = 0; i < size; i++) {
      this.wavePoints.add(new WaveCrash(i * width / size));
    }
    
    this.wavelet = new Wavelet();
    this.wavelet.init();
    
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
    
    for(int i = 0; i < this.wavePoints.size(); i++) { 
      this.wavePoints.get(i).y += this.vel + random(this.vel);
    }
    
//    this.wavelet.update();
    
    this.life -= random(2);
    this.life = max(this.life, 0);
    
  }
  
  public void render() {
    int alpha = (int) (255 * life / maxLife);
    this.wavelet.alpha = alpha * 2;
    this.wavelet.length = getMinWave();
    this.wavelet.render();
    
    for(int i = 0; i < this.wavePoints.size(); i++) {
      this.wavePoints.get(i).alpha = alpha;
      this.wavePoints.get(i).render();
    }
  }
  
  public float getMinWave() {
    float min = this.wavePoints.get(0).y;
    for(int i = 1; i < wavePoints.size(); i++) {
      min = min(min, wavePoints.get(i).y);
    }
    return min;
  }
}
