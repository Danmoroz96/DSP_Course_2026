% Set time vector for 1 second duration with a high sampling rate for smooth curves
t= 0:0.001:1

%% Task 1: Create a Sine Wave
figure(1);
A1 = 1;
f1 = 5;
y1 = A1 * sin(2 * pi * f1 * t);

plot(t, y1, 'LineWidth', 1.5);
title('Task 1: Sine Wave (5 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

%% Task 2 and task 5: Compare Different Frequencies

figure(2);
f2_a = 2; f2_b = 5; f2_c = 10;

y2_a = sin(2 * pi * f2_a * t);
y2_b = sin(2 * pi * f2_b * t);
y2_c = sin(2 * pi * f2_c * t);

subplot(3, 1, 1);
plot(t, y2_a, 'b'); title('2 Hz Sine Wave'); grid on; ylabel('Amplitude');

subplot(3, 1, 2);
plot(t, y2_b, 'r'); title('5 Hz Sine Wave'); grid on; ylabel('Amplitude');

subplot(3, 1, 3);
plot(t, y2_c, 'k'); title('10 Hz Sine Wave'); grid on;
xlabel('Time (seconds)'); ylabel('Amplitude');

% Save Figure
saveas(gcf, 'frequency_comparison.png');

%% Task 3 & Task 5: Compare Different Amplitudes
figure(3);
f3 = 5; 

y3_a = 0.5 * sin(2 * pi * f3 * t);
y3_b = 1.0 * sin(2 * pi * f3 * t);
y3_c = 2.0 * sin(2 * pi * f3 * t);

subplot(3, 1, 1);
plot(t, y3_a, 'b'); title('Amplitude = 0.5'); grid on; ylabel('Amplitude'); ylim([-5 5]);

subplot(3, 1, 2);
plot(t, y3_b, 'r'); title('Amplitude = 1.0'); grid on; ylabel('Amplitude'); ylim([-5 5]);

subplot(3, 1, 3);
plot(t, y3_c, 'k'); title('Amplitude = 2.0'); grid on;
xlabel('Time (seconds)'); ylabel('Amplitude'); ylim([-5 5]);

% Save Figure
saveas(gcf, 'amplitude_comparison.png');

%% Task 4 & Task 5: Add Noise
figure(4);
y_clean = sin(2 * pi * 5 * t);

noise = 0.8 * randn(size(t)); 
y_noisy = y_clean + noise;

subplot(2, 1, 1);
plot(t, y_clean, 'b', 'LineWidth', 1.5); 
title('Clean Signal (5 Hz)'); grid on; ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, y_noisy, 'r'); 
title('Noisy Signal'); grid on; 
xlabel('Time (seconds)'); ylabel('Amplitude');

% Save Figure
saveas(gcf, 'clean_vs_noisy_signal.png');