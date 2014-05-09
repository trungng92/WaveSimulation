/**
  These are what is going to make the ocean.
  They're basically just going to be circles that appear behind the ocean
**/
class Wavelet {
  public float x;
  public float y;
  public float circleDiam;
  public color waveColor;
  public float alpha;
  
  public Wavelet() {
    this(0);
  }
  
  public Wavelet(float x) {
    this.x = x;
    this.y = 0;
    this.circleDiam = random(40, 80);
    this.waveColor = color(0, random(50, 150), random(200, 255));
    this.alpha = 255;
  }
  
  public void update() {
    this.alpha -= 5;
  }
  public void render() {
    fill(waveColor, alpha);
    noStroke();
    ellipse(this.x, this.y, circleDiam, circleDiam);
  }
}
