# Hybrid Computer Vision Pipeline: K-Means Segmentation + SqueezeNet CNN

## Overview
MATLAB implementation of a hybrid computer vision pipeline combining traditional unsupervised color segmentation (**K-means clustering in CIE L^*a^*b^* space**) with a pre-trained deep learning classifier (**SqueezeNet CNN**) in MATLAB (`R2026b Update 2`).

## Repository Structure

├── README.md
├── hybrid_pipeline.m
└── screenshots/
    ├── 01_hybrid_pipeline.png
    └── 02_ai_vs_hybrid_comparison.png




2. Section-by-Section Explanations & Analysis


Section 1 — Load Image and AI Network: 


Loads peppers.png (384x512x3 RGB) and initializes SqueezeNet, a compact pre-trained Convolutional Neural Network trained on ImageNet (1,000 object categories) that requires 227x227x3 inputs.

Section 2 — Traditional Method (Color Segmentation via K-Means): 

Converts the RGB image into the CIE L^*a^*b^* color space (rgb2lab) and extracts only the chrominance channels (a^* and b^*), discarding brightness (L^*) so shadows and highlights do not split uniform colors across clusters. 

imsegkmeans(ab, 2) partitions pixels into two color clusters, and mask sets background pixels to black (0) while preserving foreground color and surface texture.


Section 3 — AI Method (Image Classification): 


Resizes the masked foreground image to SqueezeNet's required 227x227x3 dimensions (imresize) and runs classify(net, resizedObject) to compute predicted ImageNet class probabilities.


Section 4 — Results Analysis (Why Hybrid Improves Over Single Methods):

Traditional K-means alone groups pixels purely by color statistics (Cluster 1 vs. Cluster 2) with zero semantic understanding—it can separate a foreground region from the background, but cannot recognize what the object is.

AI (CNN) alone evaluates the entire unsegmented frame at once; background clutter, shadows, and secondary objects activate competing convolutional features, which can lower prediction confidence or cause misclassification.

Hybrid Pipeline (K-Means + CNN): 

Traditional color segmentation acts as a fast pre-processing filter that removes background distractions before inference, allowing SqueezeNet's receptive fields to focus purely on the target object's color and shape. 



(Limitation: downstream AI accuracy depends directly on mask quality—if K-means clips important object edges or groups similar background colors with the foreground, classification accuracy can drop.)


Section Explanations & Visual Results


Section 1: Load Image and Pre-trained AI Network


Loaded peppers.png (384 × 512 × 3 RGB) and initialized MATLAB's pre-trained SqueezeNet CNN (227 × 227 × 3 input layer, 1,000 ImageNet classes).


Section 2: Traditional Color Segmentation (K-Means)


Converted the RGB image to CIE L^*a^*b^* (rgb2lab) and clustered the chrominance channels (a^*, b^*) into k = 2 groups via imsegkmeans. 


Dropping the lightness channel (L^*) prevents shadows and glossy highlights from fragmenting objects. 


The binary mask zeroes out background clutter while retaining foreground color and texture.


Section 3: AI Classification (SqueezeNet)


Resized the segmented foreground object to 227 × 227 × 3 (imresize) and classified it with classify(net, resizedObject) to obtain top-1 predicted class labels and softmax confidence scores.


Section 4: Pipeline Visualization & Results Analysis


This analysis are presented in screeshot.


Why Combining Traditional + AI Methods Improves Results



Limitation of Traditional Segmentation Alone: 


K-means clustering partitions pixels based solely on color similarity without semantic awareness—it isolates regions, but cannot identify object categories.

Limitation of Deep Learning Alone: 


Passing an unsegmented image into a CNN exposes convolutional filters to background clutter and competing objects, which can dilute feature activations and reduce classification confidence.

Hybrid Advantage & Trade-off: 


Traditional K-means segmentation acts as a lightweight pre-processing stage that removes background noise, enabling SqueezeNet to focus exclusively on the isolated object. 


However, hybrid reliability depends on segmentation quality: if K-means under-segments the target or includes background artifacts, CNN predictions can degrade.


Use of AI Tools


AI assistance (Gemini) was used to add a baseline AI-only comparison, automate PNG screenshot export with tiledlayout formatting in hybrid_pipeline.m, and structure README.md. 


All code was executed in MATLAB and all outputs were verified by the author.
