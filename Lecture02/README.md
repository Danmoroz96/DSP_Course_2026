Lecture 02 – Sampling and Aliasing


 ## Objective


The purpose of this lab is to visually demonstrate how an analog signal (10 Hz) is translated into the digital domain under various sampling rates. By testing rates both above and below the Nyquist threshold, we can observe the critical impact sampling choices have on data integrity and alias generation.


 ## Nyquist Analysis



Calculation: The fundamental frequency of our target signal is f_max = 10 Hz. 

The Nyquist Sampling Theorem says that the sampling rate (f_s) must be strictly greater than 2 * f_max to reconstruct the wave. 

As a result, f_s > 20 Hz.

Compliant Frequencies: From the test set, only 25 Hz, 50 Hz, and 100 Hz satisfy the Nyquist criterion.

Sampling exactly at Nyquist: It is not recommended to sample at exactly 20 Hz. If the sampling triggers exactly at the zero-crossing points of the sine wave (a 0-degree phase shift), the resulting digital signal will just be a flat line of zeros, destroying all amplitude data.



 ## Results

15 Hz: The samples map out a completely false 5 Hz waveform. The data is entirely unreliable.

20 Hz: We get a triangular-looking wave. It captures the basic period, but the amplitude is highly distorted and phase-dependent.

25 Hz: The 10 Hz frequency is accurately preserved without aliasing, but the visual reconstruction is quite rough and lacks detail.

50 Hz: The wave structure is clearly defined. With 5 samples per cycle, the true nature of the sine wave is easily identifiable.

100 Hz: The digital samples track the analog curve almost perfectly, providing a high-fidelity digital twin of the original physical signal.




 ## Aliasing Discussion

I saw that aliasing was actively observed at the 15 Hz sampling rate.

It occurs because usually aliasing happens when the sensor "blinks" too slowly to capture the oscillation of the machine. 

Because 15 Hz violates the Nyquist rule (< 20 Hz), the discrete data points connect to form a "ghost" signal at a lower frequency ( mod (10 - 15) = 5 Hz) that doesn't actually exist in the physical system.



 ## Engineering Recommendation

If I were deploying a condition monitoring system on a mechanical setup like a Festo conveyor system, I would recommend the 100 Hz sampling rate.

While 25 Hz satisfies the math, condition monitoring often relies on time-domain peak detection to identify early mechanical faults. A 100 Hz rate gives us the necessary waveform fidelity to catch sudden amplitude spikes. Furthermore, a rate of 100 Hz strikes an ideal balance between accuracy and system resources. It provides enough data points for reliable algorithmic analysis without generating unnecessarily massive datasets that would slow down a microcontroller's processing time.




 ## AI Usage

AI Tool Used: Gemini

Prompt(s): "In MATLAB, how can I use a loop to save multiple plots automatically so that the filename updates with the current frequency variable (e.g., sampling_15Hz, sampling_20Hz)?"

Summary of AI Response: The AI explained that string concatenation in MATLAB is best handled using the sprintf function to format variables into a string, which can then be passed to the saveas(gcf, filename) command.

What I Modified: I integrated this logic inside my for loop and adjusted the string formatting layout to match the exact naming convention required by the assignment instructions.

How I Verified the Results: I executed the script and checked my active directory in MATLAB. I verified that all five PNG files were successfully generated with the correct naming scheme and that the images contained the proper plots.


