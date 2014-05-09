/**
  This is the wave crash part. i.e. the white part
  for when the wave crashes
**/
class WaveCrash {
  public float x;
  public float y;
  public float circleDiam;
  public color crashColor;
  public int alpha;
  
  public WaveCrash() {
    this(0);
  }
  
  public WaveCrash(float x) {
    this.x = x;
    this.y = 0;
    this.circleDiam = random(5, 20);
    this.crashColor = color(255);
    this.alpha = 255;
  }
  
  public void render() {
    fill(crashColor, alpha);
    noStroke();
    ellipse(this.x, this.y, circleDiam, circleDiam);
  }
}
