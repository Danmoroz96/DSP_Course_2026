% exercise4.m
x = [1 1 1 1];
n = 0:length(x)-1;

% DTFT (Continuous)
w = linspace(-pi, pi, 1000);
X = x * exp(-1j * (n.' * w));

% 4-point DFT (Shifted to align with -pi to pi)
X4 = fftshift(fft(x, 4));
w4 = linspace(-pi, pi - (2*pi/4), 4);

% 64-point DFT (Shifted to align with -pi to pi)
X64 = fftshift(fft(x, 64));
w64 = linspace(-pi, pi - (2*pi/64), 64);

figure('Color', 'white');
plot(w, abs(X), 'k', 'LineWidth', 1.5);
hold on;
stem(w64, abs(X64), 'b', 'Marker', '.', 'LineStyle', 'none');
stem(w4, abs(X4), 'r', 'filled', 'LineWidth', 1.5);
grid on;
xlabel('Angular frequency (rad/sample)');
ylabel('Magnitude');
title('DTFT vs DFT Comparison');
legend('DTFT (Continuous)', '64-point DFT', '4-point DFT');

saveas(gcf, 'dtft-dft-comparison.png');
