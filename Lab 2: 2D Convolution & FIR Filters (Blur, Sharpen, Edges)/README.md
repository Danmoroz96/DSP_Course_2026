# Lab 2: 2D Convolution & FIR Filters (Blur, Sharpen, Edges)

## Overview
MATLAB laboratory exploring 2D linear shift-invariant (LSI) filtering concepts—impulse response, box vs. separable Gaussian low-pass smoothing, unsharp masking, Sobel and Laplacian edge operators, correlation vs. convolution, and boundary padding modes—using MATLAB (`R2026b Update 2`) and the Image Processing Toolbox.

## Repository Structure
```text
├── README.md
├── lab2.m
└── screenshots/
    ├── 01_impulse_response.png
    ├── 02_lowpass_filters.png
    ├── 03_unsharp_masking.png
    ├── 04_edges_sobel_laplacian.png
    └── 06_boundary_handling.png

2. Section Explanations & Reflections

Section-by-Section Explanations

1) Delta Image & Impulse Response:

Convolving a 2D unit impulse\delta[m-51, n-51] with a 3 X 3 averaging kernel outputs the filter's impulse response h[m,n] directly a 3 X 3 square of uniform amplitude approx 0.1111 surrounded by zeros.

2) Low-Pass Filtering (Box vs. Gaussian & Separability):
Box 3x3 provides mild smoothing, while Box 7x7 blurs heavily with faint boxy edge artifacts.

The 7 X 7 Gaussian (sigma = 1.2), constructed via the outer product g1d' * g1d, produces cleaner, isotropic smoothing while preserving natural object contours.

3) Unsharp Masking (Sharpen): Subtracting the Gaussian-blurred image from the original (mask = I - I_blur) isolates high-frequency edge and texture details (negative values appear black when displayed directly in [0, 1]).

Adding the weighted mask back (I + gain * mask) boosts local edge contrast without altering flat regions.

4) Edges (Sobel & Laplacian): Sobel Gx responds strongly to horizontal intensity transitions, while Sobel Gy highlights vertical edges.

Combining them via hypot(Gx, Gy) yields the orientation-independent gradient magnitude, whereas the second-derivative Laplacian filter highlights fine edges and zero-crossings in all directions simultaneously (and is more sensitive to fine texture/noise).


5) Correlation vs. Convolution: By default, imfilter performs correlation (no kernel flip), whereas conv2 performs true 2D convolution (rotating the kernel by 180 degrees).

Passing 'conv' to imfilter flips the kernel and uses matching zero-padding at the borders, yielding a maximum difference on the order of machine precision (~1e-16 or 0).

6) Boundary Handling: Applying a 7X7 box filter near the image perimeter shows how out-of-bounds pixels are synthesized: 'replicate' repeats the outermost border pixels, 'symmetric' mirrors interior pixels across the edge, and 'circular' wraps opposite borders around periodically.

7) Reflections

Why is Gaussian preferred over a large box low-pass filter?

A box filter has sharp spatial edges, so its 2D Fourier transform is a sinc function with oscillating side lobes that cause ringing artifacts and uneven frequency attenuation (even phase inversions at certain spatial frequencies), as well as directional bias along the square axes.

A Gaussian kernel is smooth and circularly symmetric (isotropic), and its Fourier transform is also a Gaussian with zero side lobes, ensuring smooth, monotonic high-frequency attenuation without ringing.


What does separability do for computational cost?

Applying a non-separable K x K 2D kernel directly requires K^2 multiplications and additions per pixel (O(K^2)).

Because a 2D Gaussian filter factors into two 1D vectors (h[m,n] = g_1[m]\,g_2[n]), filtering can be executed as two sequential 1D passes (horizontal 1 x K, then vertical K x 1), reducing the cost to 2K operations per pixel (O(K)).

For a 7 x 7 kernel, this cuts work from $49$ operations per pixel down to 14 (a 3.5 times reduction).

How do boundary modes change corners and edges?

'replicate' clamps edge values outward, keeping border brightness steady without introducing dark zero-padded frames.


'symmetric' reflects pixel neighborhoods across the border, preserving local slopes and textures smoothly up to the corners.


'circular' wraps the top border into the bottom and left into right; because opposite sides of peppers.png have very different intensities, circular convolution introduces visible wrap-around bleed along the image borders and corners.


Section Results & Explanations



1) Delta Image & Impulse Response

Convolved a 101 x 101 unit impulse delta[m-51, n-51] with a 3 x 3 box filter (ones(3,3)/9), directly visualizing the 2D impulse response h[m,n] as a 3 x 3 block of amplitude approx 0.1111.

2) Low-Pass Filtering: Box vs. Gaussian & Separability

Compared 3 x 3 and 7x 7 box filters against a 7x7 separable Gaussian filter (sigma = 1.2, g1d' * g1d). The Gaussian filter achieves smooth, natural blur without the boxy artifacts of the 7 x 7 uniform kernel, and splitting it into two 1D passes matches the 2D output to floating-point precision (~1e-16).


3) Unsharp Masking (Sharpening)

Extracted a high-frequency detail mask (mask = I - I_blur) using the Gaussian-smoothed image and added it back (gain = 1.0) to sharpen edges and surface textures while clamping output intensities to [0, 1].

4) Edges: Sobel & Laplacian

Computed directional first-order gradients (Sobel Gx for horizontal edges, Sobel Gy for vertical edges), combined gradient magnitude (hypot(Gx, Gy)), and the isotropic second-order Laplacian response (alpha = 0.2).


5) Correlation vs. Convolution

Verified that conv2(I, h_box3, 'same') and imfilter(I, h_box3, 'conv', 'same') produce identical results (Max difference: ~1.11e-16), confirming that 'conv' rotates the kernel by 180 degrees and uses matching zero-padded boundaries.



6) Boundary Handling


Compared 'replicate', 'symmetric', and 'circular' boundary modes with a 7x7 box filter.

'replicate' and 'symmetric' preserve natural edge continuity, whereas 'circular' introduces wrap-around intensity bleed from opposite borders.



Use of AI Tools


AI assistance (Gemini) was used to automate PNG screenshot export in lab2.m and format the explanations and reflection answers in README.md.

All code was executed in MATLAB and all outputs were verified by the author.
