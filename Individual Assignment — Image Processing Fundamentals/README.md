# Image Processing — Option B: Segmentation Routes

## Overview
This repository contains a comparison of three binary segmentation pipelines on `rice.png` using MATLAB and the Image Processing Toolbox.

## Repository Contents
* `analysis.mlx` — Executed MATLAB Live Script containing code, inline figures, summary metrics, and written analysis.
* `analysis.pdf` — Static PDF export of the executed Live Script for viewing directly on GitHub without MATLAB.
* `README.md` — Experiment settings, environment details, run instructions, summary results, and conclusions.

## Experiment Details & Settings
* **Selected Option:** Option B — Compare segmentation routes
* **Input Image:** `rice.png` (MATLAB Image Processing Toolbox built-in sample image, 256 times `uint8`, no added noise; referenced by filename only and not uploaded)
* **Segmentation Routes Tested:**
  * **Route 1:** Global Otsu thresholding (`imbinarize(R)`) on the raw image.
  * **Route 2:** Morphological background estimation (`imopen(R, strel('disk', 15))`), background subtraction (`imsubtract`), contrast stretching (`imadjust`), and global Otsu thresholding (`imbinarize`).
  * **Route 3:** Local adaptive thresholding (`adaptthresh(R, 0.5)`) on the raw image.
* **Post-Processing:** Identical morphological area opening (`bwareaopen(BW, 50)`) applied to all three binary masks.
* **MATLAB Version:** `26.2.0.3437455 (R2026b) Update 2` with the **Image Processing Toolbox**.

## How to Run
1. Download or clone this repository and open MATLAB.
2. Set the repository folder as your Current Folder and open `analysis.mlx`.
3. Click **Run All** in the **Live Editor** tab to reproduce all masks, labelled outputs, figures, and summary statistics.

## Summary Results

| Route | Grain Count | Mean Area (px) | Std Area (px) |
| :--- | :---: | :---: | :---: |
| Route 1: Global Otsu (Raw) | `[87]` | `[191.93]` | `[76.16]` |
| Route 2: Background Correction + Otsu | `[93]` | `[189.1]` | `[53.92]` |
| Route 3: Adaptive Threshold (Sensitivity 0.5) | `[93]` | `[191.85]` | `[54.74]` |

## Main Conclusion & Limitation
* **Main Conclusion:** **Route 2 (Background Correction + Otsu)** is the most reliable pipeline for `rice.png`. Estimating and subtracting the uneven illumination gradient with `strel('disk', 15)` allows global Otsu thresholding to recover grains in the dark bottom corners without introducing the background noise speckles produced by local adaptive thresholding in Route 3.
* **Limitation:** Adjacent touching grains remain merged as single connected components after `bwareaopen(BW, 50)` (undercounting grains and inflating both mean area and standard deviation), and the absence of a pixel-level ground-truth mask prevents quantitative IoU or precision/recall evaluation.

* ## Visual Region Inspection & Trusted Route
* **Inspected Region:** Dark bottom-left corner of `rice.png` (`rows 157:256, cols 1:100`), where background illumination drops off significantly.
* **Comparison & Choice:** **Route 1 (Global Otsu)** misses multiple dim grains in the shadow, while **Route 3 (Adaptive Thresholding, sensitivity 0.5)** recovers them at the cost of noisier edges and background speckles. **Route 2 (Background Correction + Otsu)** is the most trustworthy pipeline for this image because subtracting the morphological background estimate (`strel('disk', 15)`) removes the lighting gradient before thresholding, recovering all dark-corner grains cleanly.

## Limitations
* **Touching Grains:** Adjacent grains that touch are merged into single objects by `bwlabel` (since no watershed split is applied after `bwareaopen(BW, 50)`), biasing the grain count downward and inflating the mean and standard deviation of grain area.
* **No Ground Truth:** Because `rice.png` does not include a reference ground-truth mask, route performance cannot be quantified with pixel-level accuracy metrics (such as IoU, Dice score, or false-positive rate).

## Use of AI Tools
AI assistance (Gemini) was used to help structure the MATLAB Live Script (`analysis.mlx`), troubleshoot figure layout formatting, and refine the wording of the written explanations and `README.md`. All code was executed in MATLAB and all outputs and conclusions were verified by the author.
