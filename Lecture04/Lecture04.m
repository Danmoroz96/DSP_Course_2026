clear; clc; close all;

x = [1 2 1];
n = 0:length(x)-1;

% Delay the signal by one sample
xDelayed = [0 x];
nDelayed = 0:length(xDelayed)-1;

figure;
subplot(2,1,1);
stem(n, x, 'filled');
title('Original Signal x[n]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nDelayed, xDelayed, 'filled');
title('One-Sample Delay x[n-1]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

% Coefficients of H(z) = 0.5 + 0.5*z^(-1)
b = [0.5 0.5];
a = 1;

% Add one zero to show the final output sample
xInput = [x 0];
y = filter(b, a, xInput);
nOutput = 0:length( y )-1;

figure;
subplot(2,1,1);
stem(nOutput, xInput, 'filled');
title('Input x[n]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nOutput, y, 'filled');
title('Output y[n]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

disp('Output samples:');
disp( y ) ;

%% Task 6: A system with updated coefficients
% Coefficients of H(z) = 0.8 + 0.2*z^(-1)
b2 = [0.8 0.2];

y2 = filter(b2, a, xInput);

figure(3);
subplot(2,1,1);
stem(nOutput, xInput, 'filled', 'b');
title('Input x[n]');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nOutput, y2, 'filled', 'g');
title('Output y[n] with H(z) = 0.8 + 0.2z^{-1}');
xlabel('Sample n'); ylabel('Amplitude');
grid on;

disp('--- Task 6: MATLAB Output (Updated Filter) ---');
disp('Output samples y[n]:');
disp(y2);

saveas(gcf, 'part2_filter_updated.png');