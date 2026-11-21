# Lab 5: Edge Detection and Segmentation

## Overview
MATLAB laboratory exploring high-frequency edge extraction and histogram-based segmentation—comparing first-order derivative operators (Sobel, Prewitt), multi-stage Canny edge detection, second-order Laplacian of Gaussian (LoG) zero-crossings, Otsu automatic thresholding, and connected-component labeling—using MATLAB (`R2026b Update 2`) and the Image Processing Toolbox.

## Repository Structure
```text
├── README.md
├── lab5.m
└── screenshots/
    ├── 01_sobel_prewitt.png
    ├── 02_canny_edges.png
    ├── 03_log_edges.png
    ├── 04_otsu_mask.png
    └── 05_labeled_regions.png





2. Section Explanations & Reflections


Section-by-Section Explanations

1) Basic Derivative Filters (Sobel, Prewitt):

Both operators approximate the first-order spatial gradient (nabla I), acting as directional high-pass filters that respond to rapid intensity transitions (high spatial frequencies).

Sobel applies extra weight to the center row/column ([1 2 1]), providing slightly stronger noise suppression than Prewitt's uniform [1 1 1] weights, though both produce somewhat broken contours along low-contrast boundaries.


2) Canny Detector (Multi-Stage):


Combines Gaussian low-pass smoothing, gradient magnitude/direction calculation, non-maximum suppression, and dual-threshold hysteresis ([0.05 0.2]).

This produces thin, continuous 1-pixel object contours while rejecting isolated high-frequency noise.



3) Laplacian of Gaussian (LoG):


Smooths the image with a Gaussian kernel first and then applies the isotropic second-order Laplacian operator (nabla^2 (G_sigma * I)).

Edges are located at zero-crossings of the second derivative, forming closed loops around regions of differing intensity.

4) Automatic Segmentation (Otsu Thresholding):


 graythresh(I) analyzes the grayscale intensity histogram to compute an optimal global threshold (level), and imbinarize partitions pixels into foreground (1) and background (0).


5) Label and Visualize Regions:


 bwlabel(BW) assigns a unique integer ID (1 to num) to each 8-connected foreground component, and label2rgb maps each label to a distinct color.


Without morphological cleanup (such as bwareaopen), small pixel clusters near the threshold boundary are also counted as separate regions.


6) Reflections


Which operator gives the thinnest, cleanest edges?

Canny produces the thinnest and cleanest edges because its non-maximum suppression step thins gradient ridges to 1-pixel-wide local maxima while hysteresis thresholding removes isolated noise speckles.


Why does Canny outperform simple gradient filters?


Simple gradient operators (Sobel/Prewitt) apply a single threshold to raw derivatives, causing either thick/noisy edges or broken weak contours.


Canny combines Gaussian noise pre-filtering, non-maximum suppression for 1-pixel edge localization, and dual-threshold hysteresis ([0.05 0.2]) to preserve weak edges only when linked to strong contours.



How does Otsu relate to histogram-based thresholding?


Otsu's method automates histogram-based thresholding by treating the normalized image histogram as a probability distribution and selecting the threshold t^* that maximizes between-class variance sigma_B^2(t) = omega_0(t) * omega_1(t)[mu_0(t) -\mu_1(t)]^2

 (minimizing within-class variance), automatically locating the optimal split between foreground and background intensity peaks.



Section Results & Explanations


1) Basic Derivative Filters (Sobel & Prewitt)


Computed first-order spatial gradients (edge(I, 'Sobel') and edge(I, 'Prewitt')), which highlight high-frequency intensity transitions.

Both produce similar primary boundaries, with Sobel offering slightly smoother noise behavior due to its center-weighted kernel.

2) Canny Edge Detector (Multi-Stage)


Applied edge(I, 'Canny', [0.05 0.2]).

Non-maximum suppression and dual-threshold hysteresis produce continuous, 1-pixel-wide contours with minimal background noise.

3) Laplacian of Gaussian (LoG)


Applied edge(I, 'log'), which smooths the image with a Gaussian filter and detects edges at second-derivative zero-crossings, generating closed contour loops around intensity regions.

4) Automatic Segmentation via Otsu Thresholding


Computed the optimal global threshold (level = graythresh(I)) and binarized peppers.png (imbinarize(I, level)), separating bright foreground peppers from darker background regions.

5) Connected-Component Labeling


Labeled all 8-connected foreground regions ([L, num] = bwlabel(BW)) and visualized each region with a distinct color via label2rgb.


Use of AI Tools


AI assistance (Gemini) was used to automate PNG screenshot saving and metric reporting in lab5.m and to structure the explanations and reflection answers in README.md.


 All code was executed in MATLAB and all outputs were verified by the author.
