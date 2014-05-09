/**
  These are the individual waves of the ocean.
**/
class Wave {
  public WaveCrash[] wavePoints;
  public float vel;
  public float maxVel;
   float accel;
  public float accelDecreaseRate;
  public float life;
  public static final float maxLife = 100;
  
  public Wave(int size, float vel, float maxVel, float accel, float accelDecreaseRate) {
    this.wavePoints = new WaveCrash[size];
    for(int i = 0; i < this.wavePoints.length; i++) {
      this.wavePoints[i] = new WaveCrash(i * width / wavePoints.length);
    }
    
    this.vel = vel;
    this.maxVel = maxVel;
    this.accel = accel;
    this.accelDecreaseRate = accelDecreaseRate;
    this.life = this.maxLife;
  }
  
  public void generateSinWave(float amp, float offset) {
    float freq = 2 * PI / wavePoints.length;
    
    for(int i = 0; i < this.wavePoints.length; i++) {
      // make sure that all the parts of the wave are positive
      this.wavePoints[i].y = amp * (1 + sin(freq * i + offset));
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
    
    for(int i = 0; i < this.wavePoints.length; i++) { 
      this.wavePoints[i].y += this.vel + random(this.vel);
    }
    
    this.life -= random(2);
    this.life = max(this.life, 0);
  }
  
  public void render() {
    int alpha = (int) (255 * life / maxLife);
    for(int i = 0; i < wavePoints.length; i++) {
      wavePoints[i].alpha = alpha;
      wavePoints[i].render();
    }
  }
}
