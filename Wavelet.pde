/**
  These are what is going to make the ocean.
  First we're going to make something that is a width x 4 image
  and then when we stretch out the image, it should create a gradient
**/
class Wavelet {
  public PImage gradientImg;
  public float startY;  // says where the wavelet should start on the screen
  public float length;  // the wavelet starts from the top of the screen to where the wave starts
  public color startColor;
  public color endColor;
  public float alpha;

  public Wavelet(float startY, color startColor, color endColor) {
    this.gradientImg = null;
    this.startY = startY;
    this.startColor = startColor;
    this.endColor = endColor;
    this.length = 0;
    this.alpha = 255;
  }
  
  public void init() {
    int gradientHeight = 2;
    this.gradientImg = createImage(width, gradientHeight, ARGB);
    this.gradientImg.loadPixels();
    
    float startG = green(this.startColor);
    float startB = blue(this.startColor);
    float endG = green(this.startColor);
    float endB = blue(this.startColor);
    
    // set the first line of pixels
    // this only works if gradientHeight == 2
    for(int i = 0; i < width; i++) {
      float currentG = startG + random(50) - 25;
      float currentB = startB + random(50) - 25;
      
      gradientImg.pixels[i] = color(0, currentG, currentB);
    }
    
    for(int i = width; i < 2 * width; i++) {
      float currentG = endG + 20 + random(50) - 25;
      float currentB = endB + 20 + random(50) - 25;
      
      gradientImg.pixels[i] = color(0, currentG, currentB);
    }
  }
  
  public void update() {
    this.alpha -= 2;
  }
  
  public void render() {
    tint(255, this.alpha);
    image(gradientImg, 0, this.startY, width, this.length);
  }
}
