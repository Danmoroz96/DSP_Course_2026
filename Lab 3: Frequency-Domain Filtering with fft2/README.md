# Lab 3: Frequency-Domain Filtering with `fft2`

## Overview
MATLAB laboratory investigating 2D frequency-domain image processing—log-magnitude Fourier spectra, ideal vs. Gaussian low-pass filtering (Gibbs ringing vs. smooth attenuation), complement high-pass filtering, and the spatial/frequency Convolution Theorem—using MATLAB (`R2026b Update 2`) and the Image Processing Toolbox.

## Repository Structure
```text
├── README.md
├── lab3.m
└── screenshots/
    ├── 01_magnitude_spectrum.png
    ├── 02_filter_masks.png
    ├── 03_lowpass_comparison.png
    ├── 04_highpass_result.png
    └── 05_spatial_vs_freq_gauss.png

2. Section Explanations & Reflections


Section-by-Section Explanations


1) Magnitude Spectrum (Log-Scale):


Computes the 2D Discrete Fourier Transform (fft2), shifts the zero-frequency (DC) component to the center (fftshift), and applies logarithmic compression (log(1 + abs(Fshift))) so faint high-frequency details remain visible alongside the bright central DC peak.


2) Ideal & Gaussian Low-Pass Filters in Frequency: Constructs a centered radial distance grid D(u,v) = sqrt{u^2 + v^2} to define a binary circular mask (D <= 40) with an abrupt brick-wall cutoff and a smooth Gaussian transfer function (sigma = 20) that tapers high frequencies gradually.

3) Apply LP Filters in Frequency Domain:

Multiplies the centered spectrum by each transfer function, shifts quadrants back (ifftshift), and applies ifft2.


The Ideal LP output exhibits visible wavy ringing artifacts along sharp edges, whereas the Gaussian LP output is smoothly blurred without oscillations.


4) High-Pass via Complement: Subtracts the Gaussian low-pass transfer function from 1 (1 - H_gauss_LP) to suppress smooth low-frequency regions and isolate rapid intensity transitions, edges, and fine surface textures.

5) Spatial vs. Frequency-Domain Gaussian LP:

Demonstrates the Convolution Theorem—spatial convolution with a Gaussian kernel and pointwise multiplication with a Gaussian in the frequency domain both perform isotropic low-pass smoothing (here, sigma_freq = 20 on a 384X512 image corresponds to a wider spatial blur than the small 7X7, sigma_{spatial} = 1.2 kernel, since sigma_spatial approx N/ (2*pi *sigma_freq).

6) Reflections




Why ideal LP causes ringing (Gibbs phenomenon):

A sharp step cutoff in frequency (D <= D_0) transforms back into a spatially oscillating radial jinc (J_1(r)/r) impulse response with positive and negative side lobes.

Convolving sharp edges with these oscillating side lobes creates concentric ripple artifacts ("ringing") around boundaries.


What fftshift does visually: Raw fft2 places the DC component at the top-left corner and high frequencies in the center.

fftshift swaps quadrants diagonally so the zero-frequency peak sits at the center of the image and spatial frequency increases radially outward.


When frequency-domain filtering is computationally preferable:

Direct spatial convolution scales as O(MNK^2), whereas FFT filtering scales as O(MN log_2(MN)) independent of kernel size.

Frequency-domain filtering is preferable when using large non-separable kernels (K > 15-30) or when applying multiple filters to the same transformed image.

Use of AI Tools


AI assistance (Gemini) was used to automate PNG screenshot saving in lab3.m and structure the written explanations and reflection answers in README.md.

All code was executed in MATLAB and all outputs were verified by the author.
