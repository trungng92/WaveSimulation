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

OutputWave outputWave;
ArrayList<Wave> waves;

void setup() {
  size(400, 700);
  frameRate(15);
  
  waves = new ArrayList<Wave>();
  waves.add(new Wave(width, randGauss(1.5, .5), 5, randGauss(.75, .25), abs(randGauss(.02, .001))));
  waves.add(new Wave(width, randGauss(1.5, .5), 5, randGauss(.75, .25), abs(randGauss(.02, .001))));
  
  for(Wave wave : waves) {
    wave.generateSinWave(random(20, 40), random(2 * PI));
  }
  
  outputWave = new OutputWave(width, waves);
}

void draw() {
  background(color(204, 153, 0));
  for(Wave wave : waves) {
    wave.update();
    wave.render();
  }
  
  outputWave.calculateOutputWave();
  outputWave.update();
  outputWave.render();
  
  // check if we need to remove any waves
  for(Iterator<Wave> iter = waves.iterator(); iter.hasNext();) {
    Wave waveToCheck = iter.next();
    if(waveToCheck.wave[0] < 0 || waveToCheck.life <= 0) {
      iter.remove();
      System.out.println("removed a wave");
    }
  }
}

void mouseReleased() {
  Wave wave = new Wave(width, randGauss(1.5, .5), 5, randGauss(.75, .25), abs(randGauss(.02, .001)));
  wave.generateSinWave(random(20, 40), random(2 * PI));
  
  waves.add(wave);
}

float randGauss(float mean, float sd) {
   return (randomGaussian() * sd) + mean;
}
