# Lab 4: Noise and Filtering

## Overview

MATLAB laboratory modeling Gaussian and salt-and-pepper noise on `peppers.png`, measuring degradation with Mean-Square Error (MSE) and Signal-to-Noise Ratio (SNR), and comparing linear (mean, Gaussian) vs. non-linear (median) spatial filters in MATLAB (`R2026b Update 2`).

## Repository Structure
```text
├── README.md
├── lab4.m
└── screenshots/
    ├── 01_noise_types.png
    ├── 03_linear_filtering.png
    └── 04_avg_vs_median.png




2. Section Explanations & Reflections

Section-by-Section Explanations

1) Add Different Noise Types:

Corrupts the grayscale peppers.png image with two distinct stochastic models: additive zero-mean Gaussian noise (sigma^2 = 0.01), which adds continuous random grain across every pixel, and salt-and-pepper impulse noise (5% density), which replaces random pixels with extreme black (0) or white (1) spikes.

2) Compute Simple Quality Metrics:

 Quantifies baseline degradation before filtering using Mean-Square Error (MSE = 1/ MN* sum (I_noisy) - I^2) and Signal-to-Noise Ratio (SNR = 10log_10(sum I^2 / sum (I_noisy) - I^2) in dB).

 Higher SNR and lower MSE indicate closer fidelity to the clean reference image.

3) Linear Filtering (Mean, Gaussian):

Applies a uniform 3 x 3 box average (fspecial('average', 3)) and a weighted 3 x 3 Gaussian kernel (sigma = 0.7).

Both reduce zero-mean Gaussian fluctuations by local weighted averaging, with the Gaussian kernel preserving slightly sharper contours than the uniform box filter.


4) Non-Linear Filtering (Median):

Applies a 3x3 order-statistic median filter (medfilt2).

Comparing the 2x2 montage shows that Avg smears salt-and-pepper impulses into gray blotches, whereas Median eliminates the black/white specks cleanly while keeping object edges crisp.

5) Compare Metrics After Filtering:

Evaluates MSE and SNR across all filter/noise pairs. For salt-and-pepper noise, the 3x3 median filter achieves a dramatic drop in MSE and boost in SNR compared to linear averaging;

for Gaussian noise, linear smoothing (Mean / Gaussian) achieves lower MSE and higher SNR than the median filter.

6) Reflections

Which noise is best removed by the median filter?

 Why?

Salt-and-pepper (impulse) noise is best removed by the median filter because isolated extreme spikes (0 and 1) sit at the ends of a sorted 3x3 neighborhood.

Selecting the middle rank-order value completely rejects impulse outliers without blending them into neighboring pixels.


Why does linear filtering blur edges more?


Linear filters compute a weighted average across all pixels in the window, mixing bright and dark intensities across sharp boundaries and turning step edges into wide ramps.


A median filter preserves step edges because the majority pixel group on one side of the boundary determines the median output intact.


How could we design adaptive filters to preserve detail?


By comparing local neighborhood variance sigma_L^$ against noise variance sigma_eta^2 (Wiener-style adaptive smoothing) so strong filtering occurs only in flat regions (sigma_L^2 > > sigma_eta^2$) while edges (sigma_L^2 >> sigma_eta^2) remain unblurred, or by using a switching/adaptive median filter that modifies only pixels detected as impulse outliers.



Section Results & Explanations

1) Add Different Noise Types

Added zero-mean Gaussian noise (sigma^2 = 0.01) and salt-and-pepper impulse noise (5% density) to grayscale peppers.png.

2) Baseline Quality Metrics

Measured initial degradation against the clean reference image using immse and SNR (dB).

3) Linear Filtering (Mean & Gaussian)

Applied a 3x3 mean filter and a 3x3 Gaussian filter (sigma = 0.7) to suppress additive noise via local weighted averaging.

4) Non-Linear Filtering (Median vs. Mean)

Compared 3x3 mean and 3x3 median filtering on both noise types.

The median filter completely removes salt-and-pepper impulses without smearing edges, whereas mean averaging turns impulses into blurred gray spots.

5) Quantitative Comparison (MSE & SNR)

Can be seen in screenshot

Use of AI Tools


AI assistance (Gemini) was used to add SNR metric formatting, automate PNG screenshot export in lab4.m, and structure the explanations and reflections in README.md.

All code was executed in MATLAB and all outputs were verified by the author.
