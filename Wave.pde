/**
  These are the individual waves of the ocean.
  
  this should have a variable that says mark for removal
**/
class Wave {
  public ArrayList<Wavelet> wavelets;
//  public Wavelet wavelet;
  public ArrayList<WaveCrash> wavePoints;
  public float vel;
  public float maxVel;
  public float accel;
  public float accelDecreaseRate;
  public float life;
  public static final float maxLife = 100;
  public static final int maxWaveletLength = 50;
  
  public Wave(int size, float vel, float maxVel, float accel, float accelDecreaseRate) {
    this.wavePoints = new ArrayList<WaveCrash>(size);
    for(int i = 0; i < size; i++) {
      this.wavePoints.add(new WaveCrash(i * width / size));
    }
    
    this.wavelets = new ArrayList<Wavelet>();
    Wavelet firstWavelet = new Wavelet(0, color(0, 80, 80), color(0, 100, 100), 255); 
    firstWavelet.init();
    this.wavelets.add(firstWavelet);   
    
    this.vel = vel;
    this.maxVel = maxVel;
    this.accel = accel;
    this.accelDecreaseRate = accelDecreaseRate;
    this.life = this.maxLife;
  }
  
  /**
    The amplitude can only be a maximum the size of maxWaveletLength
  **/
  public void generateSinWave(float amp, float offset) {
    amp = min(maxWaveletLength, amp);
    float freq = 2 * PI / wavePoints.size();
    
    for(int i = 0; i < this.wavePoints.size(); i++) {
      // make sure that all the parts of the wave are positive
      this.wavePoints.get(i).y = amp * (1 + sin(freq * i + offset));
    }
  }
  
  private void addWavelet() {
    if(this.wavelets.size() > 0) {
      Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1);
      if(getMaxWave() - this.wavelets.size() * this.maxWaveletLength > 0) {
        lastWavelet.length = this.maxWaveletLength;
        float startY = this.wavelets.size() * this.maxWaveletLength;
        color startColor = lastWavelet.endColor;
        // how to calculate endColor?
        color endColor = color(0, green(startColor) + 20, blue(startColor) + 20);
        float alpha = lastWavelet.alpha * 92 / 100;
        Wavelet newWavelet = new Wavelet(startY, startColor, endColor, alpha);
        newWavelet.init();
        newWavelet.length = getMaxWave() - (this.wavelets.size()) * this.maxWaveletLength;
        this.wavelets.add(newWavelet);
      }
    }
  }
  
  private void removeWavelet() {
    if(this.vel < 0 && this.wavelets.size() > 0) {
      Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1);
      if(getMaxWave() - ((this.wavelets.size() - 1) * this.maxWaveletLength) < 0) {
        this.wavelets.remove(this.wavelets.size() - 1);
      }
    }
  }
  
  private void updateLastWavelet() {
    if(this.wavelets.size() > 0) {
      Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1); //<>//
      lastWavelet.length = getMaxWave() - (this.wavelets.size() - 1) * this.maxWaveletLength;
      lastWavelet.length = min(this.maxWaveletLength, lastWavelet.length);
      lastWavelet.length = max(0, lastWavelet.length);
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
    
    updateLastWavelet();
    addWavelet();
    removeWavelet();
    
    // right now since update only affects alpha
    // i only want the fade to affect when waves are receding
//    if(this.vel < 0) {
//      for(Wavelet wavelet : wavelets) {
//        wavelet.update();
//      }
//    }
        
    this.life -= random(2);
    this.life = max(this.life, 0);
  }
  
  public void render() {
    int alpha = (int) (255 * life / maxLife);
    // maybe change alpha for 20% of each wavelet on each iteration?
    // maybe using the fisher yates shuffle
    float counter = 1;
    for(Wavelet wavelet : wavelets) {
      wavelet.alpha = alpha * 2 * counter;
      wavelet.render();
      counter *= .8;
    }
    
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
  
  public float getMaxWave() {
    float max = this.wavePoints.get(0).y;
    for(int i = 1; i < wavePoints.size(); i++) {
      max = max(max, wavePoints.get(i).y);
    }
    return max;
  }
}
