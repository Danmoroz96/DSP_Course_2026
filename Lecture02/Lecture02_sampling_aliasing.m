% Lecture02_sampling_aliasing.m
% Analysis of signal sampling, Nyquist theorem, and aliasing effects

%% Task 1: Create the Original Signal
% Defining a high-resolution time vector to simulate an analog wave
signal_freq = 10; % Hz
time_analog = 0:0.0005:1; % 0.5 ms step for smooth plotting
wave_analog = sin(2 * pi * signal_freq * time_analog);

figure(1);
plot(time_analog, wave_analog, 'k-', 'LineWidth', 1.2);
title('Task 1: Continuous 10 Hz Analog Signal');
xlabel('Time [s]');
ylabel('Amplitude');
grid on;
legend('Analog Waveform');

saveas(gcf, 'original_signal.png');

%% Task 2: Investigate Different Sampling Frequencies
test_frequencies = [15, 20, 25, 50, 100]; % Array of sampling rates to test

for k = 1:length(test_frequencies)
    fs = test_frequencies(k);

    % Generate discrete time steps and sample the wave
    time_discrete = 0:(1/fs):1;
    wave_discrete = sin(2 * pi * signal_freq * time_discrete);

    figure(k + 1);
    % Plot the original wave as a background reference
    plot(time_analog, wave_analog, 'Color', [0.7 0.7 0.7], 'LineWidth', 1.5);
    hold on;

    % Plot the sampled data as distinct points
    plot(time_discrete, wave_discrete, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 5);
    hold off;

    title(['Signal Representation at fs = ', num2str(fs), ' Hz']);
    xlabel('Time [s]');
    ylabel('Amplitude');
    grid on;
    legend('True Analog Wave', 'Digital Samples');

    % Dynamically save each figure
    fig_name = sprintf('sampling_%dHz.png', fs);
    saveas(gcf, fig_name);
end