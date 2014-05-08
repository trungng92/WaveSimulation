/**
  This is the overall result of multiple waves.
  
  If we needed to optimize this, then we might also want to write something
  that keeps track of which waves contribute to the overall wave?
**/
class OutputWave {
  public float[] wave;
  
  public OutputWave(int size) {
    wave = new float[size];
  }
  
  public void calculateOutputWave(ArrayList<Wave> waves) {
    for(int i = 0; i < this.wave.length; i++) {
      float maxWave = 0;
      for(Wave otherWave : waves) {
        maxWave = max(maxWave, otherWave.wave[i]);
      }
      this.wave[i] = maxWave;
    }
  }
  
  public void calculateOutputWave(Wave otherWave) {
    for(int i = 0; i < otherWave.wave.length; i++) {
      this.wave[i] = max(this.wave[i], otherWave.wave[i]);
    }
  }
  
  public void update() {
    
  }
  
  public void render() {
    stroke(255, 0, 0);
    strokeWeight(2);
    drawWave();
  }
  
  private void drawWave() {
    for(int i = 0; i < this.wave.length; i++) {
      float x = i;
      float y = this.wave[i];
      point(x, y);
    }
  }
}
