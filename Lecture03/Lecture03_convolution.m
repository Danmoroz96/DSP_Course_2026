clear;
close all;
clc;

% Use the same random noise each time
rng(1);

%% Create a clean discrete-time signal

n = 0:100;
clean = sin(0.1*pi*n);

%% Add noise

noise = 0.4*randn(size(n));
measured = clean + noise;

%% Display the clean and noisy signals

figure;

plot(n,clean,'b','LineWidth',1.5);
hold on;
plot(n,measured,'Color',[0.6 0.6 0.6]);

grid on;
xlabel('Sample index n');
ylabel('Amplitude');
title('Clean and Noisy Signals');
legend('Clean Signal','Noisy Signal');

%% Task 1 & 2: Amplitude Scaling & Signal Delay
figure(2);

% --- Task 1: Amplitude Scaling ---
scaled = 2 * measured; % Multiply noisy signal by 2

subplot(2,1,1);
plot(n, measured, 'Color', [0.6 0.6 0.6]); hold on;
plot(n, scaled, 'b', 'LineWidth', 1.5); hold off;
grid on;
title('Task 1: Amplitude Scaling');
xlabel('Sample index n'); ylabel('Amplitude');
legend('Original Noisy', 'Scaled (x2)', 'Location', 'best');

% --- Task 2: Signal Delay ---
delay = 5;
% Add 5 zeros at the beginning to shift the signal to the right
delayed = [zeros(1, delay), measured]; 

n_measured = 0:length(measured)-1;
n_delayed = 0:length(delayed)-1;

subplot(2,1,2);
plot(n_measured, measured, 'Color', [0.6 0.6 0.6]); hold on;
plot(n_delayed, delayed, 'r', 'LineWidth', 1.5); hold off;
grid on;
title('Task 2: Signal Delay (5 Samples)');
xlabel('Sample index n'); ylabel('Amplitude');
legend('Original Noisy', 'Delayed Signal', 'Location', 'best');

% Save Figure
saveas(gcf, 'signal_operations.png');

%% Task 3: Five-Point Moving-Average Filter
figure(3);
h5 = ones(1,5)/5; % Impulse response of a 5-point moving average
filtered5 = conv(measured, h5, 'same');

plot(n, clean, 'k', 'LineWidth', 1.5); hold on;
plot(n, measured, 'Color', [0.8 0.8 0.8]);
plot(n, filtered5, 'r', 'LineWidth', 1.5); hold off;

grid on;
title('Task 3: 5-Point Moving-Average Filter');
xlabel('Sample index n'); ylabel('Amplitude');
legend('Clean Signal', 'Noisy Signal', '5-Point Filtered');

% Save Figure
saveas(gcf, 'noise_filtering.png');

%% Task 4: Compare Two Filter Lengths
figure(4);
h15 = ones(1,15)/15; % Impulse response of a 15-point moving average
filtered15 = conv(measured, h15, 'same');

plot(n, clean, 'k--', 'LineWidth', 1.5); hold on;
plot(n, measured, 'Color', [0.8 0.8 0.8]);
plot(n, filtered5, 'r', 'LineWidth', 1.2); 
plot(n, filtered15, 'b', 'LineWidth', 2); hold off;

grid on;
title('Task 4: Filter Length Comparison');
xlabel('Sample index n'); ylabel('Amplitude');
legend('Clean Signal', 'Noisy Signal', '5-Point Filter', '15-Point Filter');

% Save Figure
saveas(gcf, 'filter_comparison.png');