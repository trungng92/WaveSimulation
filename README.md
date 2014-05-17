WaveSimulation
==============

This is an attempt to create something that looks like waves at the beach from a top down view.


Each branch is a different type of test to see how to waves would look.

The master branch just uses semi random bubbles to look like waves.

The testGradient branch uses linear interpolation and makes a width by 2 image and turns it into the blue wavelet part. One bad thing about this is that the computer must do a lot of interpolation each time the wave changes length. This isn't a problem if the waves are small (e.g. if the wave is 10 rows long, it only has to do 10 rows of lerping), but if the waves are large, then each iteration, the wave have to do a lot of lerp calculations).

The WaveMultipleSmallLerp branch uses linear interpolation, but it breaks down the wavelet parts into rectangles so that longer waves don't have to do repetitive calculations.