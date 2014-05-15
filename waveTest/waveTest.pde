import java.util.Iterator;
// have waves not dependent on size of width
// sin waves should shift by approximately pi between each wave

// gradient from top to bottom
// alpha refreshes when a wave crash goes over it

// no need for each wave to redraw the wavelets
// the wavelets should only be drawn once

// If the wave were to hit an object,
// there would be no way for it to account for going around something
// or parts of the wave being blocked, e.g. by a sand castle wall.
// If I were to redo this, I would want to make it tile based

ArrayList<Wave> waves;

void setup() {
  size(800, 600);
//  frameRate(10);
  
  waves = new ArrayList<Wave>();
}

void draw() {
  background(color(204, 153, 0));
  for(Wave wave : waves) {
    wave.update();
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
  System.out.println("Frame rate " + frameRate + ", wavecount: " + waves.size());
}

void mouseReleased() {
  float vel = randGauss(3.5, .25);
  float accel = randGauss(.4, .05);
  float accelRate = abs(randGauss(.02, .005));
  System.out.println("vel: " + vel + "\naccel: " + accel + "\naccelRate: " + accelRate);
  Wave wave = new Wave(width / 4, vel, 5, accel, accelRate);
  wave.generateSinWave(random(20, 40), random(2 * PI));
  wave.generateCrashWavelet();
  
  waves.add(wave);
}

float randGauss(float mean, float sd) {
   return (randomGaussian() * sd) + mean;
}
