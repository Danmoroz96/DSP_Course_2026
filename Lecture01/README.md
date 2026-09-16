Task 2: Compare Different Frequencies

Which signal changes fastest?

Comparing three signals (2 hz, 5 hz, 10 hz), I came to the conclusion that signal, which is 10 Hz, changes fastest. Here is my proof: 

The speed at which a signal changes is determined by its period (T), calculated as T = 1/ f. f means frequency.

As we have frequency as 2 hz, 5 hz, 10 hz respectively, we count T as follows:

T (2Hz)  = 1/ 2 = 0.5 seconds per cycle

T (5Hz)  = 1/ 5  = 0.2 seconds per cycle

T (10Hz) = 1 / 10 = 0.1 seconds per cycle

Because the 10 Hz signal completes a full cycle in just 0.1 seconds, it must rise from zero to its peak and fall back down in the shortest amount of time. 

Which signal has the lowest frequency?

The 2 Hz signal has the lowest frequency.

Frequency (f) represents the absolute number of cycles completed in one second. The lower number of cycles completed - lower frequency is. 

By directly comparing the given scalar values (2 < 5 < 10), 2 is the minimum value.

How can you see the difference in the plots?

You can see the difference by counting the number of complete cycles within the plot window.

Proof: The total time duration (t) of our plot is 1 second. The total number of visible cycles is calculated as Cycles = f * t.

2 Hz plot: 

2 * 1= 2 visible cycles

5 Hz plot: 5 * 1 = 5 visible cycles

10 Hz plot: 10 * 1  = 10 visible cycles

By looking at the graph, you can physically count 2, 5, and 10 peaks in their respective subplots, proving the frequencies are different.

Task 3: Compare Different Amplitudes

Which signal has the largest amplitude?
The signal with an amplitude of 2. 

Does changing amplitude change frequency?
No. The number of complete cycles per second remains exactly the same (In my case I used 5 Hz frequency); only the vertical height (intensity) of the peaks and valleys changes.

Give one real-world example where amplitude is important:

Audio signals in radio and television (sound waves). The amplitude directly corresponds to the volume of the sound of TV and radio. A higher amplitude sound wave creates a louder sound.

Task 4: 

What changed after adding noise?

The perfectly smooth, continuous curve became jagged and unpredictable. The signal now fluctuates randomly around the original path of the sine wave.

Can you still recognize the original signal?

Yes, the fundamental repeating wave shape is still visible to the human eye. However, the precise peaks, valleys, and zero-crossing points are heavily distorted. While a person can easily spot the 5 Hz pattern, a computer program or microcontroller trying to read this raw data would struggle to find the exact values and would likely require a digital filter (like a low-pass filter) to process it accurately.

Give one real-world source of signal noise:
Electrical interference in industrial automation and embedded systems. For example, large motors on a conveyor system can generate electromagnetic noise that distorts the signals on nearby low-voltage sensor wires, or a microcontroller's Analog-to-Digital Converter (ADC), which might introduce thermal noise when reading an analog sensor.

Task 6: Use AI Responsibly

AI Tool Used: Gemini produced by Google Inc. corporation. 

Prompt: "How do I generate three sine waves with different amplitudes in MATLAB and plot them so their heights can be easily compared?"

What AI Suggested: The AI provided me the mathematical formula A * sin(2 * pi * f * t) showing how to multiply by the amplitude A. It also highly recommended using the ylim() function to lock the Y-axis limits across all subplots, explaining that MATLAB auto-scales axes by default, which would make all the waves look like they are the exact same height if I didn't lock them.

Did the code work immediately? 

Talking about code, I should say: yes, the logic and the ylim suggestion worked perfectly.

What did you modify? 

I adjusted the frequency variable to exactly 5 Hz to meet the assignment requirements, and I customized the titles, colors, and axis labels to keep my formatting consistent with my previous tasks.

How did you verify the result? 

I ran the script and visually checked the plots. I confirmed that the Y-axis scale was identical for all three graphs (spanning from -5 to 5) and that the peaks of the waves accurately hit 0.5, 1.0, and 2.0.
