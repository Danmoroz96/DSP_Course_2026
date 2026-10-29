The goal for this task was to Load a WAV file in MATLAB, identify one unwanted sound component, and apply a suitable digital filter. 

I had to check whether the unwanted sound is reduced and whether the useful audio is preserved.

For this task, I used the audiofile called "Ring07.wav", which is installed directly in Windows Media.

Unwanted component identified: 
High-frequency hiss/noise located above 1.5 kHz, while the primary audio signal is situated around 600–900 Hz.   

Filter used: 4th-order Butterworth Low-Pass Filter with a cutoff frequency (f_c) of 1500 Hz.

What changed: 

Frequencies above 1.5 kHz were smoothed out, reducing background hiss while completely preserving the main audio frequencies between 600 Hz and 900 Hz.   
