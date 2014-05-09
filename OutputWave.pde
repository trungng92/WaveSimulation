/**
  This is the overall result of multiple waves.
  
  If we needed to optimize this, then we might also want to write something
  that keeps track of which waves contribute to the overall wave?
**/
class OutputWave {
  public WaveCrash[] outputWaves;
  public ArrayList<Wave> inputWaves;
  private float currentNoise;
  private float crashMultiplier; // crashes should get bigger when velocity is positive
  private boolean positiveVel; // true if the wave is going towards the beach
  public OutputWave(int size, ArrayList<Wave> inputWaves) {
    this.outputWaves = new WaveCrash[size];
    for(int i = 0; i < outputWaves.length; i++) {
      this.outputWaves[i] = new WaveCrash(i * width / outputWaves.length);
    }
    this.crashMultiplier = 1;
    currentNoise = 0;
    this.inputWaves = inputWaves;
    positiveVel = false;
  }
  
  public void calculateOutputWave() {
    positiveVel = false;
    for(int i = 0; i < this.outputWaves.length; i++) {
      float maxWave = 0;
      for(Wave inputWave : inputWaves) {
        if(inputWave.wavePoints[i].y > maxWave) {
          maxWave = inputWave.wavePoints[i].y;
          positiveVel = true;
        }
      }
      this.outputWaves[i].y = maxWave;
    }
  }
  
  public void update() {
    calculateOutputWave();
    this.crashMultiplier += (positiveVel ? .01 : -.01);
  }
  
  public void render() {
    drawWave();
  }
  
  private void drawWave() {
    fill(255);
    for(int i = 0; i < this.outputWaves.length; i++) {
      this.outputWaves[i].render();
    }
  }
}
