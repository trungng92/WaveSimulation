import java.util.Iterator;
// dying waves
// gaussian distribution for wave distance
// drawing waves?
// have waves not dependent on size of width
// wave crashes diameters increase as wave is going to beach
// wave crash diameters decrease as wave is receding
// and diameter goes to 0 when it dies
// each wave should have white crashes
// when a wave dies, the crash stays there, but still fades
// sin waves should shift by approximately pi between each wave

// gradient from top to bottom
// alpha refreshes when a wave crash goes over it
ArrayList<Wave> waves;

void setup() {
  size(400, 700);
  frameRate(5);
//  loadPixels();
  
  waves = new ArrayList<Wave>();
}

void draw() {
//  loadPixelOcean();
  background(color(204, 153, 0));
  for(Wave wave : waves) {
    wave.update(); //<>//
    wave.render();
  }
  
  // check if we need to remove any waves
  for(Iterator<Wave> iter = waves.iterator(); iter.hasNext();) {
    Wave waveToCheck = iter.next();
    if(waveToCheck.wavePoints.get(0).y < 0 || waveToCheck.life <= 0) {
      iter.remove();
      System.out.println("removed a wave");
    }
  }
}

void mouseReleased() {
  float vel = randGauss(3.5, .25);
  float accel = randGauss(.4, .05);
  float accelRate = abs(randGauss(.02, .005));
  System.out.println("vel: " + vel + "\naccel: " + accel + "\naccelRate: " + accelRate);
  Wave wave = new Wave(width / 4, vel, 5, accel, accelRate);
  wave.generateSinWave(random(20, 40), random(2 * PI));
  
  waves.add(wave);
}

float randGauss(float mean, float sd) {
   return (randomGaussian() * sd) + mean;
}

//void loadPixelOcean() {
//  background(color(204, 153, 0));
//  float startingG = 50;
//  float startingB = 50;
//  float currentG = startingG;
//  float currentB = startingB;
//  pixels[0] = color(0, currentG, currentB);
//  int numPixels = width * 300;
//  
//  // set the first line of pixels
//  for(int i = 1; i < width + 1; i++) {
//    currentG += randGauss(-127 / numPixels, .5);
////    System.out.println(currentG);
//    currentG = max(0, currentG);
//    currentG = min(255, currentG);
//    currentB += randGauss(2 * 255 / numPixels, .25);
//    currentB = max(0, currentB);
//    currentB = min(255, currentB);
//    
//    float alpha = (float) (numPixels - i) / numPixels * 255;
//    
//    pixels[i] = color(0, currentG, currentB, alpha);
//  }
//  
//  for(int i = width + 1; i < numPixels; i++) {
//    int indexAbove = pixelAboveIndex(i);
//    float greenColor = (green(pixels[indexAbove]) + green(pixels[indexAbove - 1]) + green(pixels[indexAbove + 1]) + randGauss(2, 1)) / 3;
//    float blueColor = (blue(pixels[indexAbove]) + blue(pixels[indexAbove - 1]) + blue(pixels[indexAbove + 1]) + randGauss(3, 1)) / 3;
//    float alpha = (float) (numPixels - i) / numPixels * 255;
//    pixels[i] = color(0, greenColor, blueColor, alpha);
//  }
//  
//  // and all the lines after are going to be a sum of the previous pixels
//  updatePixels();
//}
//
//int pixelAboveIndex(int index) {
//  return index - width;
//}
