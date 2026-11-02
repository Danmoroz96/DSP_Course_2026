% partA_sensor_filtering.m
% Part A: Synthetic Sensor Signal Filtering and Comparison
clear; close all; clc;

% Place this at the very top of your script
outputDir = fullfile(pwd, 'figures');
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

%% 1. Signal Generation
Fs = 1000;                     % Sampling frequency (1000 Hz)
t = (0:1/Fs:2-1/Fs)';          % 2-second time vector (2000 samples)
rng(7);                        % Fixed seed for reproducible noise

% Clean signal (5 Hz main wave + 0.35 weight 12 Hz secondary wave)
clean = sin(2*pi*5*t) + 0.35*sin(2*pi*12*t);

% Interference (50 Hz power hum + 137 Hz high-freq noise + white noise)
noise = 0.35*sin(2*pi*50*t) + 0.20*sin(2*pi*137*t) + 0.25*randn(size(t));
x = clean + noise;

%% 2. Filter Designs & Zero-Phase Application
fc = 20;                       % Cutoff frequency at 20 Hz
Wn = fc / (Fs/2);              % Normalized cutoff (20 / 500 = 0.04)

% Design 60th-order FIR filter (61 taps) and 4th-order Butterworth IIR filter
bFIR = fir1(60, Wn, 'low');
[bIIR, aIIR] = butter(4, Wn, 'low');

% Apply zero-phase filtering (filtfilt)
yFIR = filtfilt(bFIR, 1, x);
yIIR = filtfilt(bIIR, aIIR, x);

%% 3. Task A1: Time-Domain Comparison Plot (0.2 s Window)
figure('Color', 'w', 'Name', 'Sensor Time Domain');
idx02 = (t <= 0.2);

plot(t(idx02), clean(idx02), 'k-', 'LineWidth', 2.0); hold on;
plot(t(idx02), x(idx02), 'Color', [0.7 0.7 0.7], 'LineWidth', 1.0);
plot(t(idx02), yFIR(idx02), 'r--', 'LineWidth', 1.5);
plot(t(idx02), yIIR(idx02), 'b-.', 'LineWidth', 1.5); hold off;

grid on; xlabel('Time (s)'); ylabel('Amplitude');
title('Sensor Signal Time-Domain Comparison (0.2 s Window)');
legend('Clean Signal', 'Noisy Input', 'FIR Output (Order 60)', 'IIR Output (Order 4)', 'Location', 'northeast');
saveas(gcf, fullfile(outputDir, 'sensor_time_comparison.png'));

%% 4. Task A2: Magnitude Responses (freqz)
figure('Color', 'w', 'Name', 'Filter Frequency Responses');
[hFIR, fAxis] = freqz(bFIR, 1, 4096, Fs);
[hIIR, ~]     = freqz(bIIR, aIIR, 4096, Fs);

plot(fAxis, 20*log10(abs(hFIR)), 'r-', 'LineWidth', 1.5); hold on;
plot(fAxis, 20*log10(abs(hIIR)), 'b--', 'LineWidth', 1.5);
xline(fc, 'k:', 'LineWidth', 1.2, 'Label', 'fc = 20 Hz'); hold off;

grid on; xlim([0 200]); ylim([-80 5]);
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
title('Filter Magnitude Responses (freqz)');
legend('60th-Order FIR', '4th-Order Butterworth IIR', 'Cutoff (20 Hz)', 'Location', 'northeast');
saveas(gcf, fullfile(outputDir, 'sensor_freqz_responses.png'));

%% 5. Task A3: Single-Sided Amplitude Spectra
N = length(x);
f = (0:N/2)*(Fs/N);

% Single-sided spectrum calculation
P1_X   = abs(fft(x)/N);   P1_X   = P1_X(1:N/2+1);   P1_X(2:end-1)   = 2*P1_X(2:end-1);
P1_FIR = abs(fft(yFIR)/N); P1_FIR = P1_FIR(1:N/2+1); P1_FIR(2:end-1) = 2*P1_FIR(2:end-1);
P1_IIR = abs(fft(yIIR)/N); P1_IIR = P1_IIR(1:N/2+1); P1_IIR(2:end-1) = 2*P1_IIR(2:end-1);

figure('Color', 'w', 'Name', 'Single-Sided Amplitude Spectra');
subplot(3,1,1); stem(f, P1_X, 'Color', [0.5 0.5 0.5], 'Marker', 'none'); grid on;
xlim([0 160]); ylim([0 1.2]); ylabel('Amplitude'); title('Noisy Input Spectrum');
xline(5, 'r--'); xline(12, 'r--'); xline(50, 'k--'); xline(137, 'k--');

subplot(3,1,2); stem(f, P1_FIR, 'r', 'Marker', 'none'); grid on;
xlim([0 160]); ylim([0 1.2]); ylabel('Amplitude'); title('FIR Filtered Spectrum');
xline(5, 'r--'); xline(12, 'r--');

subplot(3,1,3); stem(f, P1_IIR, 'b', 'Marker', 'none'); grid on;
xlim([0 160]); ylim([0 1.2]); ylabel('Amplitude'); title('IIR Filtered Spectrum');
xlabel('Frequency (Hz)'); ylabel('Amplitude');
xline(5, 'r--'); xline(12, 'r--');
saveas(gcf, fullfile(outputDir, 'sensor_amplitude_spectra.png'));

%% 6. Task A4: RMSE Calculations
rmseNoisy = sqrt(mean((x - clean).^2));
rmseFIR   = sqrt(mean((yFIR - clean).^2));
rmseIIR   = sqrt(mean((yIIR - clean).^2));

fprintf('=== PART A RESULTS ===\n');
fprintf('Noisy Input RMSE: %.4f\n', rmseNoisy);
fprintf('FIR Output RMSE:   %.4f\n', rmseFIR);
fprintf('IIR Output RMSE:   %.4f\n', rmseIIR);
