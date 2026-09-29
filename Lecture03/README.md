Which operation changed the signal amplitude?

Scalar multiplication (scaled = 2 * measured) changed the amplitude. 

It amplified the intensity of both the original sine wave and the noise proportionally, making the peaks and valleys twice as high/deep.


How did the five-sample delay change the signal?

By prepending an array of zeros [0, 0, 0, 0, 0] to the measured data, the entire waveform was physically shifted to the right along the time axis (index n). 

The shape, amplitude, and frequency of the wave remained completely identical; it just arrives 5 samples later.

What does the impulse response h[n] represent?

The impulse response defines the specific behavior and "weights" of a digital filter. For our moving average, it is an array of equal fractions (e.g., [0.2, 0.2, 0.2, 0.2, 0.2]). 


It represents exactly how the system reacts to a single input spike (an impulse), which dictates how it will average out continuous data.


How did convolution change the noisy signal?

Convolution computationally "dragged" the filter mask h[n] across the noisy signal, calculating a dot product at every step. 

This effectively averaged adjacent samples together, pulling down erratic high-frequency noise spikes and smoothing the waveform toward the signal's true center.

What differences did you observe between the 5-point and 15-point filters?


The 5-point filter retained some of the jaggedness of the noise but accurately tracked the amplitude of the main wave. 

The 15-point filter drew a much smoother, thicker curve, but it visibly struggled to reach the top and bottom peaks of the sine wave.

Which filter removed more noise?

The 15-point filter removed significantly more noise variance.

Did the longer filter remove or distort useful signal information?

Yes, it caused noticeable attenuation (distortion). 

Because a 15-sample window covers a large chunk of the sine wave's curve, averaging them all together artificially flattened the true peak amplitudes of the signal.

Which filter would you recommend for this signal? Explain your decision.


I highly recommend the 5-point filter. 

In signal processing, the goal is to eliminate high-frequency erratic noise without destroying the underlying dynamics of the true signal. 

If we use the 5-point filter, it will clean up the worst spikes while preserving the actual amplitude and responsiveness of the base wave. 

The 15-point filter is too aggressive and distorts the true process values.

Engineering Application


Give one real engineering application for moving-average filtering.


Smoothing raw analog sensor readings—such as an ultrasonic distance sensor connected to a Siemens PLC.

Without a moving-average filter, electrical noise will cause the HMI display to flicker rapidly, and it will cause a PID controller to react erratically to false spikes. 

A short moving average stabilizes the sensor reading so the control logic can operate smoothly.

AI Usage
Tool used: Gemini

How I used it: I asked how to properly execute a signal delay in MATLAB by padding an array, and how to plot Task 1 and Task 2 together efficiently.

What I verified or changed: The AI suggested using [zeros(1, delay), measured] for the delay. 

I verified that the dimensions matched correctly in my workspace. 

I also grouped Task 1 and Task 2 into subplot(2,1,1) and subplot(2,1,2) to output a clean, single signal_operations.png file as required by the assignment structure.
