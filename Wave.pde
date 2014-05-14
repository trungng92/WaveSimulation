/**
  These are the individual waves of the ocean.
  
  this should have a variable that says mark for removal
**/
class Wave {
  public ArrayList<Wavelet> wavelets;
  public ArrayList<WaveCrash> wavePoints;
  public PImage crashWaveletImg;
  public float amp;
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
    Wavelet firstWavelet = new Wavelet(size, 0, color(0, 80, 80), color(0, 100, 100), 255); 
    firstWavelet.init();
    this.wavelets.add(firstWavelet);   
    
    this.crashWaveletImg = null;
    
    this.vel = vel;
    this.maxVel = maxVel;
    this.accel = accel;
    this.accelDecreaseRate = accelDecreaseRate;
    this.life = this.maxLife;
    this.amp = 0;
  }
  
  /**
    A bit of a misnomer because it doesn't actually Wavelet
    but it creates something very similar to a wavelet.
    It's just a PImage to display the last wavelet.
    
    The reason why I can't just have an alpha over the last wavelet
    is because the wavecrash could be in parts of multiple wavelets,
    and because the wavelet changes size, I would also have to constantly
    change the size of the alpha image to match with the Wavelet PImage
  **/
  public void generateCrashWavelet() {
    // multiply amp by 2 because when we generate the sin wave
    // we actually do amp * (1.2 + sin()). So the total amplitude is actually 2.2 * amp
    this.crashWaveletImg = new PImage(this.wavePoints.size(), (int) (this.amp * 2.2), ARGB);
    this.crashWaveletImg.loadPixels();
    for(int i = 0; i < this.wavePoints.size(); i++) {
      // find the wave crash for each column, and all the pixels above the wave crash
      // set to white, all below the wave crash, set to transparent
      int waveCrashLength = (int) this.wavePoints.get(i).y;
      for(int j = 0; j < waveCrashLength; j++) {
        this.crashWaveletImg.set(i, j, color(0, 200, 200));
      }
    }
    this.crashWaveletImg.updatePixels();
  }
  
  /**
    The amplitude can only be a maximum the size of maxWaveletLength
  **/
  public void generateSinWave(float amp, float offset) {
    this.amp = min(maxWaveletLength, amp);
    float freq = 2 * PI / wavePoints.size();
    
    for(int i = 0; i < this.wavePoints.size(); i++) {
      // make sure that all the parts of the wave are positive
      // the 1.2 guarantees that there is the wavecrash in all parts
      this.wavePoints.get(i).y = this.amp * (1.2 + sin(freq * i + offset));
    }
  }
  
  private void addWavelet() {
    if(this.wavelets.size() > 0) {
      Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1);
      if(getMinWave() - this.wavelets.size() * this.maxWaveletLength > 0) {
        lastWavelet.length = this.maxWaveletLength;
        float startY = this.wavelets.size() * this.maxWaveletLength;
        color startColor = lastWavelet.endColor;
        // how to calculate endColor?
        color endColor = color(0, green(startColor) + 20, blue(startColor) + 20);
        float alpha = lastWavelet.alpha * 92 / 100; // TODO DON'T NEED ALPHA ANYMORE? BECAUSE IT CORRESPONDS WITH THE WAVELETS.UPDATE()
        // WHICH IS COMMENTED
        
        // you can change the number of points the wavelets use with the first parameter
        // but you also have to change the first wave in the constructor
        Wavelet newWavelet = new Wavelet(this.wavePoints.size(), startY, startColor, endColor, alpha);
        newWavelet.init(lastWavelet);
        newWavelet.length = getMinWave() - (this.wavelets.size()) * this.maxWaveletLength;
        this.wavelets.add(newWavelet);
      }
    }
  }
  
  private void removeWavelet() {
    if(this.vel < 0 && this.wavelets.size() > 0) {
      Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1);
      if(getMinWave() - ((this.wavelets.size() - 1) * this.maxWaveletLength) < 0) {
        this.wavelets.remove(this.wavelets.size() - 1);
      }
    }
  }
  
  private void updateLastWavelet() {
    if(this.wavelets.size() > 0) {
      Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1);
      lastWavelet.length = getMinWave() - (this.wavelets.size() - 1) * this.maxWaveletLength;
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
          // not sure if linear growth looks better
          // or exponential growth
          crash.circleDiam += random(.2);
//          crash.circleDiam *= random(1, 1.05);
        }
      } else {
        for(WaveCrash crash : wavePoints) {
          crash.circleDiam -= random(.2);
//            crash.circleDiam *= random(.95, 1);
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
      wavelet.alpha = alpha * 4 * counter;
      wavelet.render();
      counter *= .9;
    }
    
    if(this.wavelets.size() > 0) {
      float crashWaveletY = (this.wavelets.size() - 1) * this.maxWaveletLength +
        this.wavelets.get(this.wavelets.size() - 1).length;
      tint(color(255, (this.wavelets.size() + 8) * 20, (this.wavelets.size() + 8) * 20), alpha * 4 * counter);
//      Wavelet lastWavelet = this.wavelets.get(this.wavelets.size() - 1);
//      crashWaveletImg.blend(lastWavelet.gradientImg, 0, (int) lastWavelet.startY, (int) lastWavelet.gradWidth, (int) lastWavelet.length, 
//        0, (int) crashWaveletY, this.wavePoints.size(), (int) (this.amp * 2.2), BLEND);
      image(crashWaveletImg, 0, crashWaveletY, width, this.amp * 2.2);
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
