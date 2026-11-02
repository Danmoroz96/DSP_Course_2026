This repository contains the implementation, analysis, and evaluation of digital filters applied to synthetic sensor signals and audio recordings. 

It compares Finite Impulse Response (FIR) and Infinite Impulse Response (IIR) low-pass designs, as well as narrow vs. wide notch filters for electrical hum suppression.

Environment & Prerequisites

Environment: MATLAB Online / MATLAB R2020a or newer

Required Toolboxes: Signal Processing Toolbox

Key Functions Used: fir1, butter, filtfilt, freqz, spectrogram, fft


Part A: Sensor Signal Filtering

1. Signal & Filter Specifications



Sampling Frequency (F_s): 

1000 Hz (2-second duration, 2000 samples)

Clean Measurement Signal: x_{clean)(t) = sin(2*pi*5t) + 0.35*sin(2*pi*12t)

Interference & Noise: 

0.35 * sin(2pi * 50t) + 0.20* sin(2pi * 137t) + 0.25 * N(0,1)

Cutoff Frequency (f_c): 

20 Hz (Wn = 20 / 500 = 0.04)

Filter Designs:

FIR Filter: Order 60 (61 taps), designed via fir1 with a Hamming window.

IIR Filter: 4th-order Butterworth low-pass, designed via butter.

Application: Zero-phase filtering via filtfilt.


2. Time-Domain Performance


Over a 0.2 s window, both zero-phase filters eliminate the rapid high-frequency interference ripple while accurately tracking the fundamental 5Hz} + 12 Hz wave contour without phase delay.

3. Magnitude Responses & Single-Sided SpectraThe frequency response (freqz) confirms an exact -3dB cutoff at 20 Hz for both filters.

The 60th-order FIR filter demonstrates a steeper roll-off in the transition band (20-50 Hz).

Single-sided amplitude spectra demonstrate the following behavior:
5 Hz and 12 Hz (Passband): Amplitudes preserved at 1.00 and 0.35.

50 Hz (Interference): Attenuated from 0.35 down to < 0.003 (FIR) and < 0.009 (IIR).

137 Hz (Interference): Fully suppressed below 0.0001 by both filters.

4. Quantitative RMSE Evaluation

<img width="930" height="443" alt="image" src="https://github.com/user-attachments/assets/40663feb-eb91-479d-880d-0e0dac301c81" />

5. Design Comparison

<img width="951" height="443" alt="image" src="https://github.com/user-attachments/assets/25df1a52-2f97-4c0f-a4ac-f3243a3d64c1" />


Part B: 50 Hz Audio Hum Reduction

1. Audio Setup & Filter Specification


Audio Source: Built-in MATLAB handel chorus recording (F_s = 8192 Hz).

Interference: 

Added 50 Hz power line hum (A = 0.15).

Filter Designs:

Narrow Notch: 2nd-order Butterworth band-stop, 49-51Hz (Delta f = 2Hz).

Wide Notch: 2nd-order Butterworth band-stop, 45-55Hz (Delta f = 10Hz).

2. Waveform & Spectrogram Analysis

Adding the 50 Hz tone introduces a low-frequency envelope oscillation. 

Filtering with the 49-51 Hz notch removes this envelope, restoring clean audio bounds. Spectrogram analysis displays a continuous bright horizontal band at 0.05 kHz (50 Hz) in the unfiltered audio, which is erased in the filtered output.


3. Notch Bandwidth Trade-Off Analysis

<img width="1164" height="309" alt="image" src="https://github.com/user-attachments/assets/49364eb4-c890-4f39-b986-bda7a3428fcc" />


Report Questions & Answers


1. Why is a 20 Hz low-pass reasonable for Part A, and what assumption does it make about the wanted sensor signal?


A 20 Hz cutoff is reasonable because the highest frequency component of the wanted signal is 12 Hz. 

Placing the cutoff at 20 Hz leaves an 8 Hz passband safety margin above 12 Hz, ensuring zero amplitude attenuation or phase distortion for the 5 Hz and 12 Hz components.

Core Assumption: The filter assumes that the physical process being measured has a strictly limited bandwidth (f_max <=12 Hz) and contains no rapid step-changes or high-frequency transients above 20Hz that carry meaningful information.

2. Which filter gives the better result for the requirements chosen? Support the answer with at least two kinds of evidence.


The 60th-Order FIR Filter (fir1) provides the superior overall result for offline analysis.

Evidence 1 (Numerical Error): 

Achieves a lower RMSE (0.0402 vs. 0.0528), reducing raw noise power by 91.2%.

Evidence 2 (Stopband Attenuation): Provides -42 dB attenuation at 50Hz versus -32dB} for the 4th-order IIR filter.

3. How would your implementation change if the sensor had to be filtered live with low latency?


Replace filtfilt with single-pass filter: Zero-phase filtering (filtfilt) is non-causal and requires processing the entire dataset forward and backward. 

Real-time filtering must run sample-by-sample using casual filter(b, a, x).

Switch to 4th-order IIR: A 60th-order FIR filter introduces a fixed group delay of N/2 = 30 samples (30 ms at 1000 Hz). 

A 4th-order Butterworth IIR filter requires far fewer operations (10 vs. 61 per sample) and introduces significantly lower group delay in the passband.

4. Why is a narrow band-stop appropriate for a steady 50 Hz hum? What would you do if the interference frequency drifted?


A narrow band-stop (49-51 Hz) is appropriate because AC mains hum concentrates its interference energy on a single frequency line (50 Hz). 

A high-Q notch removes this spike without carving out neighboring audio frequencies.

If the frequency drifts (48-52Hz$): 

Static widening of the notch attenuates neighboring musical notes. The optimal solution is an Adaptive Notch Filter (e.g., using an LMS algorithm) or a Phase-Locked Loop (PLL) that tracks the drifting interference frequency and dynamically updates the filter's center frequency in real time.

5. Describe one limitation of your experiments and one improvement you would make in a real measurement system.


Experimental Limitation: The synthetic model assumes stationary white Gaussian noise and ideal single-frequency sinusoids. Real-world sensor noise includes non-stationary impulse spikes (relay switching) and DC baseline drift.

Engineering System Improvement: Implement an analog anti-aliasing low-pass filter directly at the sensor hardware before ADC sampling, paired with differential shielded cabling (4 - 20 mA) to reject 50Hz electromagnetic hum at the physical layer.


All MATLAB code was written, executed, and verified in MATLAB Online. The signal generation and filter designs follow standard algorithms (fir1, butter, filtfilt, freqz, spectrogram) from the MATLAB Signal Processing Toolbox. Generative AI tools were utilized as an interactive programming collaborator to assist with data formatting, and code optimization.
