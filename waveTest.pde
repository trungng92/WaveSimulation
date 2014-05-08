import java.util.Iterator;
// dying waves
// gaussian distribution for wave distance
// drawing waves?
// test commit
float[] outputWave;

ArrayList<Wave> waves;

void setup() {
  size(400, 700);
  frameRate(15);
  
  waves = new ArrayList<Wave>();
  waves.add(new Wave(width, random(.5), 5, random(.25, .5), random(.005, .01)));
  waves.add(new Wave(width, random(.5), 5, random(.25, .5), random(.005, .01)));
  
  for(Wave wave : waves) {
    wave.generateSinWave(random(20, 40), random(2 * PI));
  }
}

void draw() {
  background(255);
  for(Wave wave : waves) {
    wave.update();
    wave.render();
  }
  
  // check if we need to remove any waves
  for(Iterator<Wave> iter = waves.iterator(); iter.hasNext();) {
    Wave waveToCheck = iter.next();
    if(waveToCheck.wave[0] < 0) {
      iter.remove();
      System.out.println("removed a wave");
    }
  }
  if(waves.size() > 0) {
    outputWave = calcOutputWave(waves);
    stroke(255, 0, 0);
    strokeWeight(2);
    drawWave(outputWave);
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

void drawWave(float[] wave) {
  for(int i = 0; i < wave.length; i++) {
    float x = i;
    float y = wave[i];
    point(x, y);
  }
}

float[] addWaves(float[] wave1, float[] wave2) {
  float[] outputWave = new float[wave1.length];
  for(int i = 0; i < wave1.length; i++) {
    outputWave[i] = wave1[i] + wave2[i]; 
  }
  return outputWave;
}

void mouseReleased() {
  Wave wave = new Wave(width, random(.5), 5, random(.25, .5), random(.005, .01));
  wave.generateSinWave(random(20, 40), random(2 * PI));
  
  waves.add(wave);
}
