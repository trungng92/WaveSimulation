import java.util.Iterator;
// dying waves
// gaussian distribution for wave distance
// drawing waves?

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
  
  outputWave = new OutputWave(width);
}

void draw() {
  background(color(204, 153, 0));
  for(Wave wave : waves) {
    wave.update();
    wave.render();
  }
  
  outputWave.calculateOutputWave(waves);
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

float[] calcOutputWave(ArrayList<Wave> waves) {
  float[] outputWave = new float[waves.get(0).wave.length];
  for(int i = 0; i < outputWave.length; i++) {
    float max = 0;
    for(int j = 0; j < waves.size(); j++) {
      max = max(max, waves.get(j).wave[i]);
    }
    outputWave[i] = max;
  }
  return outputWave;
}

void mouseReleased() {
  Wave wave = new Wave(width, randGauss(1.5, .5), 5, randGauss(.75, .25), abs(randGauss(.02, .001)));
  wave.generateSinWave(random(20, 40), random(2 * PI));
  
  waves.add(wave);
}

float randGauss(float mean, float sd) {
   return (randomGaussian() * sd) + mean;
}
