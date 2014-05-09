/**
  These are what is going to make the ocean.
  First we're going to make something that is a width x 4 image
  and then when we stretch out the image, it should create a gradient
**/
class Wavelet {
  public PImage gradientImg;
  public float length;  // the wavelet starts from the top of the screen to where the wave starts
//  public color startWaveColor;
//  public color endWaveColor;
  public float alpha;

  public Wavelet() {
    gradientImg = null;
    this.length = 0;
    this.alpha = 255;
  }
  
  public void init() {
    int gradientHeight = 4;
    gradientImg = createImage(width, gradientHeight, ARGB);
    gradientImg.loadPixels();
    
    float startingG = 50;
    float startingB = 50;
    float currentG = startingG;
    float currentB = startingB;
    
    // set the first line of pixels
    for(int i = 0; i < gradientImg.pixels.length; i++) {
      // currentG should on average start at 50 and over the course of wavePixels.length
      // subtract startingG amount (i.e. 50), so at the end, the gradient should be near 0
      currentG += randGauss(-startingG / gradientImg.pixels.length, .5);
      currentG = max(0, currentG);
      currentG = min(255, currentG);
      // currentB should on average start at 50 and over the course of wavePixels.length
      // add startingB * 3 amount (i.e. 150), so at the end, the gradient should be near 200
      currentB += randGauss(3 * startingB / gradientImg.pixels.length, .25);
      currentB = max(0, currentB);
      currentB = min(255, currentB);
      
      gradientImg.pixels[i] = color(0, currentG, currentB);
    }
  }
  
  public void update() {
    this.alpha -= 2;
  }
  
  public void render() {
    tint(255, this.alpha);
    image(gradientImg, 0, 0, width, this.length);
//    fill(waveColor, alpha);
//    noStroke();
//    ellipse(this.x, this.y, circleDiam, circleDiam);
  }
}
