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
    Wavelet firstWavelet = new Wavelet(0, color(0, 80, 80), color(0, 100, 100)); 
    firstWavelet.init();
    this.wavelets.add(firstWavelet);   
    
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
  
  private void addWavelet() {
    Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1);
    System.out.println("LAST WAVELET LENGTH " + lastWavelet.length);
    System.out.println("CHECK SIZE " + this.wavelets.size());
    System.out.println("CHECK WAVELET SIZE " + (this.wavelets.size() * this.maxWaveletLength));
    System.out.println("CHECK MAX WAVE " + getMaxWave());
    if(getMaxWave() - this.wavelets.size() * this.maxWaveletLength > 0) {
//    if(getMaxWave() - ((this.wavelets.size() - 1) * this.maxWaveletLength + lastWavelet.length) > 0) {
      lastWavelet.length = this.maxWaveletLength;
      float startY = this.wavelets.size() * this.maxWaveletLength;
//      System.out.println("starting at " + startY);
      color startColor = lastWavelet.endColor;
      // how to calculate endColor?
      color endColor = color(0, green(startColor) + 20, blue(startColor) + 20);
      Wavelet newWavelet = new Wavelet(startY, startColor, endColor);
      newWavelet.init();
      newWavelet.length = getMaxWave() - (this.wavelets.size()) * this.maxWaveletLength;
      System.out.println("NEW WAVELET LENGTH " + newWavelet.length);
      this.wavelets.add(newWavelet);
    }
  }
  
  private void removeWavelet() {
    
  }
  
  private void updateLastWavelet() {
    Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1); //<>//
    lastWavelet.length = getMaxWave() - (this.wavelets.size() - 1) * this.maxWaveletLength;
    lastWavelet.length = min(this.maxWaveletLength, lastWavelet.length);
    lastWavelet.length = max(0, lastWavelet.length);
//    System.out.println("last wavelet length " + lastWavelet.length);
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
 //<>//
    this.vel += this.accel;
    
    for(int i = 0; i < this.wavePoints.size(); i++) { 
      this.wavePoints.get(i).y += this.vel + random(this.vel);
    }
    
    updateLastWavelet();
    addWavelet();
        
    this.life -= random(2);
    this.life = max(this.life, 0);
  }
  
  public void render() {
    int alpha = (int) (255 * life / maxLife);
//    this.wavelets.alpha = alpha * 2;
//    this.wavelet.length = getMinWave();
    for(Wavelet wavelet : wavelets) {
      wavelet.render();
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
