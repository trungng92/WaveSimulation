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
//  frameRate(15);
//  loadPixels();
  
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
