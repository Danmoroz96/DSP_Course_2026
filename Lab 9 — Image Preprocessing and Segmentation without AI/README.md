# Tire Stud Detector (Image Preprocessing & Connected-Component Analysis)

## Overview

MATLAB computer vision script (`tire_stud_detector.m`) that distinguishes studded winter tires from non-studded summer tires by isolating the dark rubber tread, extracting bright metallic reflections, filtering candidates by geometric shape properties, and classifying the tire based on detected stud count.


```text
├── README.md
├── tire_stud_detector.m
├── studded_tire.jpeg
├── summer_tire.jpg
└── screenshots/
    ├── 01_result_studded_tire.png
    └── 02_result_summer_tire.png




2. How Each Stage Works & Quick Tuning TipsTire Mask Isolation (Step 3): 


Thresholding Igray < 120 separates the dark rubber tread from the bright background. imfill(..., 'holes') closes the center wheel opening and any bright stud holes inside the tread, bwareafilt(..., 1) discards stray corner shadows, and imerode(..., strel('disk', 5)) pulls the mask slightly inward so bright background pixels along the tire's outer silhouette cannot trigger false detections.



Candidate Extraction (Step 4): 


Applying a mild Gaussian blur (imgaussfilt(Igray, 1.0)) suppresses single-pixel sensor grain before finding bright metallic pinpoints (Iblur > 140) strictly inside tire


Mask.Geometric Filtering (Steps 5–6): 


Glossy rubber highlights or white sidewall lettering can also exceed bright

Thresh, so regionprops filters out non-stud blobs using three shape rules:


Area (4–150 px): 


Rejects tiny noise specks and large sidewall logos/reflections.


Circularity (4piA} / {P^2} >= 0.60): 


Rejects elongated tread grooves or specular streaks.


Eccentricity (<=0.85): 


Ensures detected blobs are compact and roughly circular rather than line-shaped.



If Your Specific Images Need Threshold Adjustments:


If studCount is too low on studded_tire.jpeg, lower brightThresh from 140 to 115–125 (or increase maxA to 250 if the image resolution is very high).


If white sidewall text is being counted on summer_tire.jpg, raise minCirc to 0.70 or lower maxA to 80.


Processing Pipeline



Read & Resize: Loads each tire image and downscales by 0.5 (imresize) for consistent spatial scale and fast execution.

Grayscale Conversion: Converts RGB images to single-channel luminance (rgb2gray).

Tire Segmentation (tireMask): 


Thresholds dark rubber pixels (Igray < 120), fills interior holes (imfill), retains the largest connected object (bwareafilt), and erodes the outer boundary (strel('disk', 5)) to eliminate background edge glare.

Candidate Stud Extraction: 


Smooths minor noise with a Gaussian filter (sigma = 1.0), thresholds bright metallic reflections inside tireMask (Iblur > 140), and removes sub-threshold specks (bwareaopen).

Connected-Component & Shape Filtering: 


Uses bwconncomp and regionprops to keep only small, round candidates (Area in [4, 150] px, Circularity >= 0.60, Eccentricity <= 0.85), rejecting elongated tread reflections and sidewall lettering.

Classification & Visualization: 

Classifies images with studCount > 10 as STUDDED TIRE and <= 10 as NON-STUDDED TIRE, displaying the original image, binary candidate mask, and red boundary overlays (visboundaries).


Results

They can be in screenshot in this repository.

Visual Outputs

Can be seen in screenshots in this repository.


How to Run

Clone or download this repository and open MATLAB (R2026b Update 2 with the Image Processing Toolbox).

Set the repository folder as your Current Folder and run tire_stud_detector.m.


Use of AI Tools


AI assistance (Gemini) was used to implement the morphological mask cleanup, geometric filtering loop, and README.md documentation. 

All code was executed and verified in MATLAB by the author.
