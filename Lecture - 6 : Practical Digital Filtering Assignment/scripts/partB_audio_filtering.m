% partB_audio_filtering.m
% Part B: 50 Hz Audio Hum Reduction and Bandwidth Comparison
clear; close all; clc;

%% 1. Robust Output Folder Setup
outputDir = fullfile(pwd, 'figures');
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

%% 2. Load Audio Signal and Add 50 Hz Hum
load handel;                            % Loads y (audio data) and Fs (8192 Hz)
xClean = y(:);                          % Convert to column vector
tAudio = (0:numel(xClean)-1)'/Fs;       % Time vector in seconds

% Confirm Fs > 102 Hz (Nyquist limit for 50 Hz is 100 Hz)
if Fs <= 102
    error('Sampling frequency Fs must be greater than 102 Hz.');
end

% Add controlled 50 Hz hum (amplitude 0.15)
humAmplitude = 0.15;
xHum = xClean + humAmplitude * sin(2*pi*50*tAudio);

%% 3. Design Filters (Narrow vs. Wide Band-Stop)
% Narrow Notch: 49–51 Hz
Wn_narrow = [49 51] / (Fs/2);
[bN, aN] = butter(2, Wn_narrow, 'stop');
yAudioNarrow = filtfilt(bN, aN, xHum);

% Wide Notch: 45–55 Hz
Wn_wide = [45 55] / (Fs/2);
[bW, aW] = butter(2, Wn_wide, 'stop');
yAudioWide = filtfilt(bW, aW, xHum);

%% 4. Task B1: Waveform Comparison Plot (0.2s Window)
figure('Color', 'w', 'Name', 'Audio Waveform Comparison');
tSegment = (tAudio >= 1.0 & tAudio <= 1.2); % 0.2s section

subplot(3,1,1);
plot(tAudio(tSegment), xClean(tSegment), 'k'); grid on;
ylabel('Amplitude'); title('Original Clean Audio (Handel)');
ylim([-0.8 0.8]);

subplot(3,1,2);
plot(tAudio(tSegment), xHum(tSegment), 'r'); grid on;
ylabel('Amplitude'); title('Audio with 50 Hz Hum (A = 0.15)');
ylim([-0.8 0.8]);

subplot(3,1,3);
plot(tAudio(tSegment), yAudioNarrow(tSegment), 'b'); grid on;
xlabel('Time (s)'); ylabel('Amplitude'); 
title('Filtered Audio (Narrow 49–51 Hz Notch)');
ylim([-0.8 0.8]);

saveas(gcf, fullfile(outputDir, 'audio_waveform_comparison.png'));

%% 5. Task B2: Audio Spectrogram Comparison
figure('Color', 'w', 'Name', 'Audio Spectrograms');

subplot(1,3,1);
spectrogram(xClean, 512, 256, 512, Fs, 'yaxis');
title('Clean Audio'); ylim([0 0.5]); % Zoomed to 0–0.5 kHz

subplot(1,3,2);
spectrogram(xHum, 512, 256, 512, Fs, 'yaxis');
title('With 50 Hz Hum'); ylim([0 0.5]);

subplot(1,3,3);
spectrogram(yAudioNarrow, 512, 256, 512, Fs, 'yaxis');
title('Narrow Filtered (49–51 Hz)'); ylim([0 0.5]);

saveas(gcf, fullfile(outputDir, 'audio_spectrogram_comparison.png'));

%% 6. Task B3: Filter Frequency Response Comparison (freqz)
figure('Color', 'w', 'Name', 'Notch Filter Magnitude Responses');
[hNarrow, fAudioAxis] = freqz(bN, aN, 8192, Fs);
[hWide, ~]           = freqz(bW, aW, 8192, Fs);

plot(fAudioAxis, 20*log10(abs(hNarrow)), 'b-', 'LineWidth', 1.5); hold on;
plot(fAudioAxis, 20*log10(abs(hWide)), 'r--', 'LineWidth', 1.5); hold off;
grid on; xlim([0 150]); ylim([-40 5]);
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
title('Notch Filter Magnitude Response (Narrow vs. Wide)');
legend('Narrow Notch (49–51 Hz)', 'Wide Notch (45–55 Hz)', 'Location', 'southeast');

saveas(gcf, fullfile(outputDir, 'notch_filter_responses.png'));

%% 7. Task B4 & B5: 50 Hz Amplitude Attenuation Measurement
N_aud = length(xClean);
fftHum    = abs(fft(xHum)/N_aud);
fftNarrow = abs(fft(yAudioNarrow)/N_aud);
fftWide   = abs(fft(yAudioWide)/N_aud);

% Locate the bin closest to 50 Hz
[~, idx50] = min(abs((0:N_aud/2)*(Fs/N_aud) - 50));
amp50_before = 2 * fftHum(idx50);
amp50_narrow = 2 * fftNarrow(idx50);
amp50_wide   = 2 * fftWide(idx50);

attNarrow_dB = 20*log10(amp50_narrow / amp50_before);
attWide_dB   = 20*log10(amp50_wide / amp50_before);

fprintf('=== PART B RESULTS ===\n');
fprintf('Unfiltered 50 Hz Amplitude: %.4f\n', amp50_before);
fprintf('Narrow Notch (49–51 Hz) 50 Hz Amp: %.6f (Attenuation: %.2f dB)\n', amp50_narrow, attNarrow_dB);
fprintf('Wide Notch (45–55 Hz) 50 Hz Amp:   %.6f (Attenuation: %.2f dB)\n', amp50_wide, attWide_dB);

%% 8. Audio Playback Check
disp('Playing audio with 50 Hz hum...');
soundsc(xHum, Fs);
pause(numel(xHum)/Fs + 0.5);

disp('Playing filtered audio (narrow notch)...');
soundsc(yAudioNarrow, Fs);
