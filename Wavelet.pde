/**
  These are what is going to make the ocean.
  First we're going to make something that is a width x 2 image
  and then when we stretch out the image, it should create a gradient
**/
class Wavelet {
  public PImage gradientImg;
  public int gradWidth;
  public float startY;  // says where the wavelet should start on the screen
  public float length;  // the wavelet starts from the top of the screen to where the wave starts
  public color startColor;
  public color endColor;
  public float alpha;

  public Wavelet(int gradWidth, float startY, color startColor, color endColor, float alpha) {
    this.gradWidth = gradWidth;
    int gradientHeight = 2;
    this.gradientImg = createImage(this.gradWidth, gradientHeight, ARGB);

    this.startY = startY;
    this.startColor = startColor;
    this.endColor = endColor;
    this.length = 0;
    this.alpha = alpha;
  }
  
  public void init() {
//    int gradientHeight = 2;
//    this.gradientImg = createImage(width, gradientHeight, ARGB);
    this.gradientImg.loadPixels();
    
    float startG = green(this.startColor);
    float startB = blue(this.startColor);
    float endG = green(this.endColor);
    float endB = blue(this.endColor);
    
    // set the first line of pixels
    // this only works if gradientHeight == 2
    for(int i = 0; i < this.gradWidth; i++) {
      float currentG = startG + random(10) - 5;
      float currentB = startB + random(10) - 5;
      
      this.gradientImg.pixels[i] = color(0, currentG, currentB);
    }
    
    for(int i = this.gradWidth; i < 2 * this.gradWidth; i++) {
      float currentG = endG + noise(i) * 10;//random(20) - 10;
      float currentB = endB + noise(i) * 10;//random(20) - 10;
      
      this.gradientImg.pixels[i] = color(0, currentG, currentB);
    }
  }
  
  public void init(Wavelet prev) {
//    int gradientHeight = 2;
//    this.gradientImg = createImage(width, gradientHeight, ARGB);
    this.gradientImg.loadPixels();
    
//    float startG = green(this.startColor);
//    float startB = blue(this.startColor);
    float endG = green(this.endColor);
    float endB = blue(this.endColor);
    
    prev.gradientImg.loadPixels();
    // set the first line of pixels
    // this only works if gradientHeight == 2
    for(int i = 0; i < this.gradWidth; i++) {
      float currentG = green(prev.gradientImg.pixels[i + this.gradWidth]) + random(4) - 2;
      float currentB = blue(prev.gradientImg.pixels[i + this.gradWidth]) + random(4) - 2;
      
      this.gradientImg.pixels[i] = color(0, currentG, currentB);
    }
    
    for(int i = this.gradWidth; i < 2 * this.gradWidth; i++) {
      float currentG = endG + noise(i * 2) * 10;//random(20) - 10;
      float currentB = endB + noise(i) * 10;//random(20) - 10;
      
      this.gradientImg.pixels[i] = color(0, currentG, currentB);
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
