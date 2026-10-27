% exercise3.m
d = 4; % Assigned digit
f2 = 13.2 + 0.17*d; % f2 = 13.88 Hz

fs = 200;

% 1. One-second recording
T1 = 1;
t1 = 0:1/fs:T1-1/fs;
x1 = 0.8*sin(2*pi*15*t1) + 0.4*sin(2*pi*f2*t1);

N1 = length(x1);
Y1 = fft(x1);
P1_1 = abs(Y1/N1);
P1_1 = P1_1(1:N1/2+1); P1_1(2:end-1) = 2*P1_1(2:end-1);
f1 = fs*(0:N1/2)/N1;

% 2. Four-second recording
T4 = 4;
t4 = 0:1/fs:T4-1/fs;
x4 = 0.8*sin(2*pi*15*t4) + 0.4*sin(2*pi*f2*t4);

N4 = length(x4);
Y4 = fft(x4);
P1_4 = abs(Y4/N4);
P1_4 = P1_4(1:N4/2+1); P1_4(2:end-1) = 2*P1_4(2:end-1);
f4 = fs*(0:N4/2)/N4;

% 3. Zero-padded one-second recording
N_pad = 4 * N1;
Y_pad = fft(x1, N_pad);
P1_pad = abs(Y_pad/N1); % Normalize by original N to maintain amplitude
P1_pad = P1_pad(1:N_pad/2+1); P1_pad(2:end-1) = 2*P1_pad(2:end-1);
f_pad = fs*(0:N_pad/2)/N_pad;

% Plotting
figure('Color', 'white', 'Position', [100, 100, 800, 800]);

subplot(3,1,1);
plot(f1, P1_1, 'b.-', 'MarkerSize', 12);
grid on; xlim([10 20]);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('1-Second Recording (N = 200)');

subplot(3,1,2);
plot(f4, P1_4, 'r.-', 'MarkerSize', 12);
grid on; xlim([10 20]);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('4-Second Recording (N = 800)');

subplot(3,1,3);
plot(f_pad, P1_pad, 'k.-', 'MarkerSize', 12);
grid on; xlim([10 20]);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Zero-Padded 1-Second Recording (N = 800)');

saveas(gcf, 'leakage-comparison.png');
