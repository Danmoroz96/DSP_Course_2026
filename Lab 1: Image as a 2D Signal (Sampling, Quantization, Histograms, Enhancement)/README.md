# Lab 1: Image as a 2D Signal (Sampling, Quantization, Histograms, Enhancement)

## Overview
MATLAB exploration of fundamental 2D digital image concepts—spatial sampling, bit-depth quantization, linear contrast stretching, nonlinear gamma correction, and aliasing—using MATLAB (`R2026b Update 2`) and the Image Processing Toolbox.

## Repository Structure
```text
├── README.md
├── lab1.m
└── screenshots/
    ├── 00_original_rgb.png
    ├── 00_grayscale.png
    ├── 01_quantization.png
    ├── 02_histograms.png
    ├── 02_contrast_stretch.png
    ├── 03_gamma.png
    └── 04_sampling_aliasing.png




## Section Results & Explanations


0) Load and Inspect Image
Loaded peppers.png (384 × 512 × 3, uint8) and converted it to a 2D grayscale luminance image (384 × 512, uint8, intensity range [0, 255]).

1) Quantization and Dynamic Range
Quantized the 8-bit grayscale image (256 gray levels) down to ~6-bit (64 levels, step 4) and ~4-bit (16 levels, step 16).

At 4-bit depth, smooth gradients break into distinct brightness bands.

2) Histogram and Contrast Stretching
Applied linear normalization (mat2gray) and mid-range contrast stretching (imadjust(I, [0.2 0.8], [0 1])).

Stretching spreads the central histogram bins across [0, 255] and clips extreme dark/bright pixels into spikes at 0 and 255.

3) Gamma Correction (Nonlinear Amplitude Scaling)

Applied nonlinear power-law mapping (s = r^ gamma ).

Using gamma = 0.6 brightens dark and mid-tone regions, while gamma = 1.6 darkens mid-tones and compresses shadow values.

4) Sampling and Aliasing

Downsampled the image to 10% of its original resolution using 'nearest' interpolation without low-pass filtering, then upsampled back to original dimensions—producing severe blockiness and jagged edges.

6) Short Reflections

Bit-depth and posterization: Lowering bit-depth from 8 bits (256 levels) to 4 bits (16 levels) increases the quantization step size from 1 to 16.

Smooth tonal transitions across curved surfaces collapse into flat intensity steps with sharp artificial boundaries (posterization / false contouring).

Histogram and detail visibility under contrast stretching:

Linearly mapping [0.2, 0.8] to [0, 1] expands the spacing between mid-tone histogram bins across the full 0–255 range and piles clipped pixels into spikes at 0 and 255.

Mid-tone details become sharper and easier to distinguish, while shadow and highlight details outside [0.2, 0.8] are crushed to black or white.

Aggressive downsampling and Nyquist aliasing:

According to the Nyquist–Shannon sampling theorem, the sampling rate must exceed twice the highest spatial frequency (f_s > 2 f_max) to avoid aliasing.

Naive downsampling by 10 times lowers the Nyquist limit tenfold without pre-filtering, causing high-frequency edges and fine textures to fold into low-frequency stair-step and blocky artifacts when upscaled.

Use of AI Tools

AI assistance (Gemini) was used to fix a syntax typo in the starter script (I(:) indexing), automate PNG figure saving, and structure the README.md layout.

All code was executed and verified in MATLAB by the author.
