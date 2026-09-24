Questions & Short Answers


1. Which sampling frequencies represented the 7 kHz signal correctly?


The 24 kHz and 16 kHz sampling frequencies represented the signal correctly, because both have a Nyquist frequency higher than the 7 kHz target.



2. When did the 7 kHz signal appear as another frequency?


It appeared as another frequency when sampled at 12 kHz (where it shifted to 5 kHz) and when sampled at 8 kHz (where it drastically dropped to 1 kHz).

3. What happened when the Nyquist frequency became lower than 7 kHz?



The sampling rate was no longer fast enough to capture the waveform's true oscillations. The frequency "folded back" into the measurable spectrum, creating a false, lower-frequency signal that wasn't present in the original audio.

4. Did the aliased signal sound different?



Yes. Instead of the sharp, high-pitched 7 kHz tone, the aliased signals produced noticeably lower pitches. The 12 kHz sample produced a slightly lower 5 kHz tone, and the 8 kHz sample produced a dramatically lower, very distinct 1 kHz tone.

5. Why can MATLAB not recover the original 7 kHz signal after aliasing?



Because the information is permanently lost. Once the continuous wave is downsampled, the discrete data points of a 7 kHz wave sampled at 8 kHz are mathematically identical to the points of a 1 kHz wave. MATLAB only sees the raw discrete dots; it has no physical way of knowing which analog wave originally produced them.
