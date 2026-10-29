% filter_audio.m
% Inspecting and filtering an unwanted sound component from a WAV file

clear; close all; clc;

%% 1 & 2: Load the file and check properties
filename = 'Ring07.wav'; % REPLACE with your actual WAV file name

try
    [y, fs] = audioread(filename);
catch
    error('Could not find %s. Make sure the file is in your MATLAB folder.', filename);
end

% If the audio is stereo (2 channels), convert it to mono for easier processing
if size(y, 2) > 1
    y = mean(y, 2); 
end

duration = length(y) / fs;
fprintf('--- Audio File Properties ---\n');
fprintf('Sample Rate: %d Hz\n', fs);
fprintf('Duration: %.2f seconds\n', duration);
fprintf('Channels: %d (converted to mono)\n\n', size(y, 2));

%% 3, 4, & 5: Identify and Apply Low-Pass Filter
% Target: Remove unwanted high-frequency hiss/noise above 1.5 kHz
% Preserves useful audio around 600 Hz - 900 Hz

fc = 1500; % Cutoff frequency at 1.5 kHz (1500 Hz)
order = 4; % 4th-order Butterworth filter

% Normalized cutoff frequency (Wn = fc / (fs/2))
Wn = fc / (fs / 2);

% Create filter coefficients
[b, a] = butter(order, Wn, 'low');

% Apply digital filter
y_filtered = filter(b, a, y);

%% 6: Compare original and filtered signals
figure('Color', 'white', 'Position', [100, 100, 1000, 600]);

% --- Plot 1: Waveform Comparison (Zoomed into a 0.1s segment) ---
t_sec = (0:length(y)-1) / fs;
zoom_idx = 1:round(0.1 * fs); % Extract just the first 100 ms to see the wave shape

subplot(2,2,1);
plot(t_sec(zoom_idx), y(zoom_idx), 'b');
title('Original Waveform (0.1s segment)');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;
ylim([-1 1]);

subplot(2,2,2);
plot(t_sec(zoom_idx), y_filtered(zoom_idx), 'r');
title('Filtered Waveform (0.1s segment)');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;
ylim([-1 1]);

% --- Plot 2: Spectrogram Comparison ---
% Using a window of 1024 samples for good frequency resolution
subplot(2,2,3);
spectrogram(y, 1024, 512, 1024, fs, 'yaxis');
title('Original Spectrogram');
ylim([0 1]); % Zoom Y-axis to 0-1 kHz to clearly see the low-frequency hum

subplot(2,2,4);
spectrogram(y_filtered, 1024, 512, 1024, fs, 'yaxis');
title('Filtered Spectrogram (50 Hz Notch)');
% ylim([0 1]); % comment out

% Save the comparison figure
saveas(gcf, 'audio_filter_comparison.png');

%% 6b: Playback
disp('Playing original sound...');
soundsc(y, fs);
pause(duration + 1); % Wait for the first sound to finish

disp('Playing filtered sound...');
soundsc(y_filtered, fs);