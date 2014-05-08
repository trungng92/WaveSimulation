/**
  These are the individual waves of the ocean.
**/
class Wave {
  public float[] wave;
  public float vel;
  public float maxVel;
   float accel;
  public float accelDecreaseRate;
  public float life;
  public static final float maxLife = 100;
  
  public Wave(int size, float vel, float maxVel, float accel, float accelDecreaseRate) {
    this.wave = new float[size];
    this.vel = vel;
    this.maxVel = maxVel;
    this.accel = accel;
    this.accelDecreaseRate = accelDecreaseRate;
    this.life = this.maxLife;
  }
  
  public void generateSinWave(float amp, float offset) {
    float freq = 2 * PI / wave.length;
    
    for(int i = 0; i < this.wave.length; i++) {
      // make sure that all the parts of the wave are positive
      this.wave[i] = amp * (1 + sin(freq * i + offset));
      //System.out.println("wave " + i + " is " + wave[i]);
    }
  }
  
  public void update() {
    this.accel -= this.accelDecreaseRate;
    if(abs(this.vel) >= this.maxVel) {
      this.vel *= 1 / abs(this.vel) * this.maxVel;
    }
//    System.out.println("vel " + this.vel);
//    System.out.println("max vel " + this.maxVel);
    
    this.vel += this.accel;
    
    for(int i = 0; i < this.wave.length; i++) { 
      this.wave[i] += this.vel;
    }
    
    this.life -= random(2);
    this.life = max(this.life, 0);
  }
  
  public void render() {
    int alpha = (int) (255 * life / maxLife);
    System.out.println("alpha is " + alpha);
    stroke(0, alpha);
    strokeWeight(4);
    for(int i = 0; i < wave.length; i++) {
      float x = i;
      float y = wave[i];
      point(x, y);
    }
  }
}
