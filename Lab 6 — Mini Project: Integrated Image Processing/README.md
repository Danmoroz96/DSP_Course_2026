## Overview
End-to-end 2D Digital Signal Processing image pipeline combining non-linear spatial filtering, linear contrast enhancement, Canny edge extraction, and 2D Fourier frequency-domain low-pass filtering in MATLAB (`R2026b Update 2`).

## Defined Problem
Raw camera images often suffer from impulse sensor noise and compressed mid-tone dynamic range, which cause edge detectors to either trigger false contours on noise or miss faint structural boundaries. 

This pipeline pre-processes the grayscale luminance signal to suppress outliers and boost gradient contrast before extracting clean object contours and isolating low-frequency structural energy.

## Repository Structure

├── README.md
├── lab6.m
└── screenshots/
    ├── 01_pipeline_overview.png
    └── 02_edge_comparison.png




Pipeline Results & Visual Verification

1) Complete 6-Panel Pipeline Overview

Shows the progression from raw grayscale input through 3x3 median denoising, mid-tone contrast stretching ([0.2, 0.8] -> [0, 1]), Canny edge detection ([0.1, 0.25]), ideal frequency-domain low-pass reconstruction (D_0 = 60), and the masked 2D log-magnitude spectrum.

2) Impact of Pre-Processing on Edge Extraction


Compares Canny edge detection directly on the raw image against the denoised and contrast-enhanced output. 

Expanding mid-tone gradients reveals faint contours while median filtering suppresses false noise edges.




Report: DSP Operations, Limitations & Improvements


1. Processing Pipeline Summary


Input & Luminance Conversion: 


Loads the target image (your_image.jpg, falling back to peppers.png if absent) and converts it to a normalized 2D signal I[m,n] in [0, 1].


2. Pre-Processing (medfilt2):


Suppresses isolated impulse noise using a 3x3 spatial neighborhood.


3. Contrast Enhancement (imadjust): 

Stretches mid-tone intensities ([0.2, 0.8]) across [0, 1] to increase boundary contrast.



4. Feature Extraction (edge(..., 'Canny')):



Extracts thin, 1-pixel structural contours using dual hysteresis thresholds ([0.1, 0.25]).




5. Frequency-Domain Filtering (fft2 / ifft2):

Applies an ideal circular low-pass mask (D_0 = 60) to separate coarse structural illumination from high-frequency texture and edge energy.


2. Relation of Each Stage to 2D DSP Operations




Non-Linear Rank-Order Filtering (medfilt2(I, [3 3])): 


Unlike linear FIR averaging (box or Gaussian kernels) that computes weighted sums and blurs step edges, sorting 9 local pixels and selecting the middle rank-order sample eliminates extreme outliers while preserving sharp intensity transitions.

Pointwise Amplitude Mapping (imadjust(I_filt, [0.2 0.8], [0 1])):


Applies a memoryless piecewise-linear transformation s = T(r) with slope approx 1.67 inside [0.2, 0.8], amplifying spatial gradients |\nabla I| across object boundaries prior to edge detection.


Gradient Filtering & Hysteresis (edge(..., 'Canny', [0.1 0.25])): 


Combines linear derivative-of-Gaussian FIR filtering (gradient magnitude and orientation) with non-maximum suppression and dual-threshold hysteresis (0.1 low, 0.25 high) to link weak edges connected to strong contours.


2D Discrete Fourier Transform & Spectral Masking ( from fft2 to H and then to ifft2): 


Uses the 2D Convolution Theorem to filter in frequency via pointwise multiplication (F_shift[u,v]) *  H[u,v]. 

Zeroing out radial frequencies with D >= 60 degrees removes rapid spatial variations and reconstructs the smooth low-frequency base.



3. Limitations & Potential Improvements



Gibbs Ringing from Ideal Low-Pass Cutoff: 


The abrupt binary cutoff (D < 60) transforms into an oscillating radial (J_1(r)/r) impulse response in the spatial domain, creating faint concentric ripples near sharp edges. 


Replacing the binary mask with a smooth Gaussian filter H(u,v) = exp(-D^2 / (2sigma^2)) eliminates ringing.


Shadow and Highlight Clipping: Fixed contrast limits [0.2, 0.8] saturate dark pixels (< 0.2) to 0 and bright pixels (> 0.8) to 1, erasing edge detail in extreme intensity zones. 


Using Contrast-Limited Adaptive Histogram Equalization (adapthisteq) would boost local contrast adaptively without global clipping.


Fine-Texture Rounding: Unconditional 3x3 median filtering slightly rounds sharp 1-pixel corners and fine periodic textures; an edge-preserving bilateral filter (imbilatfilt) or adaptive switching median filter would preserve fine geometry.


Use of AI Tools

AI assistance (Gemini) was used to add odd-dimension FFT safeguards, automate PNG screenshot export with tiledlayout formatting in lab6.m, and structure the technical report in README.md.


All code was executed in MATLAB and all outputs were verified by the author.
