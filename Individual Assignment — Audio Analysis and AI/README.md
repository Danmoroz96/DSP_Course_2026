# Audio Noise Reduction Analysis (Option B)

## Selected Option

**Option B — Compare Noise Reduction Settings**

## Assignment Overview
This project evaluates the performance of classical spectral gating on a noisy speech signal using two attenuation parameters (`prop_decrease = 0.5` versus `prop_decrease = 1.0`). The goal is to analyze the trade-off between total noise energy reduction and perceptual speech distortion.

## Audio File Inventory & Source Attribution
* **Original Clean Speech Reference:** `data/demo/05_speech.wav` (Supplied course package audio, 16 kHz sample rate)
* **Processed Output (0.5 Attenuation):** `results/spectral_gate_0.5.wav`
* **Processed Output (1.0 Attenuation):** `results/spectral_gate_1.0.wav`

## Experimental Setup & Settings
* **Sampling Frequency (f_s):** 16,000 Hz
* **Noise Estimate Window:** Initial 0.5-second silent lead-in segment (`noisy[:FS//2]`)
* **Noise Profile:** Synthetic white Gaussian noise (5 dB nominal SNR) mixed with a 50 Hz powerline hum
* **Spectral Gating Tool:** `noisereduce` library executing stationary noise reduction at `prop_decrease = 0.5` and `prop_decrease = 1.0`.

## Experimental Metrics & Results
| Processing Condition | Reference-Based SNR (dB) | Perceptual Acoustic & Intelligibility Observations |
| :--- | :--- | :--- |
| **Noisy Input** | ~4.02 dB | Dominant background hiss and constant low-frequency 50 Hz hum. |
| **Spectral Gate (`prop_decrease=0.5`)** | ~6.46 dB | Soft residual noise floor remains, but speech formants remain natural and clear. |
| **Spectral Gate (`prop_decrease=1.0`)** | ~7.23 dB | Pauses are completely silent, but active speech suffers from 'musical noise' and flanging artifacts. |

## Main Conclusion & Preferred Setting
**Preferred Setting:** `prop_decrease = 0.5`

Although setting `prop_decrease = 1.0` achieves a higher mathematical Signal-to-Noise Ratio (~7.23 dB vs ~6.46 dB) by completely zeroing background noise during speech pauses, it aggressively cuts time-frequency bins during active speech. This introduces sharp phase distortions and metallic "musical noise" artifacts. `prop_decrease = 0.5` is preferred because it maintains vocal clarity and natural formant transitions while still attenuating background noise.

## Limitation of Analysis
Reference-based SNR measures raw time-domain energy differences across the entire signal rather than human psychoacoustic perception. Consequently, a higher numerical SNR value does not guarantee better speech intelligibility or acoustic naturalness.

## Instructions to Reproduce
1. Open `analysis.ipynb` in Google Colab or local Jupyter environment.
2. Install dependencies: `pip install numpy scipy librosa soundfile noisereduce matplotlib pandas`.
3. Place `manifest.csv` and audio samples inside the `data/` directory.
4. Execute **Runtime -> Run All** to regenerate outputs in `results/`.

## AI Assistance Disclosure
AI assistance (Gemini) was used to assist with Python code syntax, self-contained notebook error handling, and formatting markdown tables. All code was reviewed, executed, and verified independently.
