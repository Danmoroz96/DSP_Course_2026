# Gaussian Noise Denoising: Traditional Filters vs. Deep Learning (`DnCNN`)

## Overview
MATLAB experiment modeling additive white Gaussian noise (AWGN) on `cameraman.tif`, evaluating restoration quality using **MSE**, **PSNR**, and **SSIM**, and comparing traditional spatial filters (**Mean**, **Median**, **Gaussian blur**, and **Adaptive Wiener**) against a pre-trained **`DnCNN`** deep learning model in MATLAB (`R2026b Update 2`).


## Repository Structure
├── README.md
├── gaussian_denoising_ai.m
└── screenshots/
    ├── 01_wiener_vs_dncnn.png
    └── 02_traditional_filters.png


2. Section-by-Section Explanations


1. Setup (Gaussian Noise Modeling):

Loads cameraman.tif (256 x256), converts pixel intensities to double in [0, 1], and corrupts the image with zero-mean additive white Gaussian noise (AWGN) of standard deviation sigma = 0.04 (variance sigma^2 = 0.0016), simulating uniform thermal/sensor noise across every pixel.


2. Traditional Filters (Adaptive Wiener vs. Mean, Median & Gaussian):

Adaptive Wiener (wiener2): 

Estimates local mean and variance inside each 5x5 window. 


Where local variance is close to the noise variance sigma^2 (flat sky), it averages strongly; 

where local variance is high (edges and textures), it reduces smoothing to preserve sharpness.


Mean & Gaussian Blur: 


Apply fixed low-pass weights everywhere, reducing noise in flat areas at the cost of blurring object boundaries uniformly.


Median Filter (medfilt2): Designed primarily for salt-and-pepper impulse outliers; on continuous Gaussian noise, it leaves noticeable blotchy grain and yields lower PSNR/SSIM than Wiener or Gaussian filtering.


3. AI Filter (Pre-trained DnCNN):

Uses MATLAB's pre-trained Denoising Convolutional Neural Network (DnCNN), which predicts the residual noise layer from multi-scale learned features and subtracts it from the noisy input.

4. Quantitative Evaluation (MSE, PSNR & SSIM):

MSE: Average squared pixel error relative to originalImage (lower is better).

PSNR (dB): Logarithmic ratio of peak signal power to MSE (higher is better).

SSIM: Perceptual similarity index in [0, 1] comparing local luminance, contrast, and structure (closer to 1.0 indicates higher structural fidelity).

5. Visual Observation:

 Visually inspecting the coat, camera tripod, and background buildings confirms the quantitative scores: fixed spatial filters blur edges, adaptive Wiener keeps edges noticeably sharper with minor residual grain, and DnCNN produces the cleanest background and sharpest fine detail.


Section Results & Explanations


Noise Modeling, Adaptive Wiener Filter & AI (DnCNN)


Added zero-mean Gaussian noise (sigma = 0.04, variance sigma^2 = 0.0016) to cameraman.tif and denoised the image with a 5x5 adaptive Wiener filter (wiener2) and MATLAB's pre-trained DnCNN network (denoiseImage).

4. Quantitative Evaluation (MSE, PSNR & SSIM)

The table is presented in separate screenshot.

5. Traditional Filter Comparison & Visual Observations

Fixed Spatial Filters (Mean, Median, Gaussian): 

Mean and Gaussian filters smooth Gaussian grain in flat sky regions but blur sharp edges uniformly; 

the Median filter is optimized for impulse (salt-and-pepper) noise rather than continuous Gaussian noise.


Adaptive Wiener (wiener2): 

Scales smoothing inversely with local variance, preserving edges far better than non-adaptive linear filters.



Pre-trained AI (DnCNN): 

Achieves the lowest MSE and highest PSNR/SSIM, removing background noise while keeping fine details on the coat, tripod, and distant buildings crisp.


Use of AI Tools

AI assistance (Gemini) was used to format the 2 × 2 figure layouts, include MSE and classic filter comparisons matching the learning outcomes, and structure README.md. 

All code was executed in MATLAB and all outputs were verified by the author.
