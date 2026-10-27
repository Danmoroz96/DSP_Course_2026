% exercise1.m
t = linspace(-1, 1, 4000);
H_vals = [1, 3, 9, 25];

figure('Color', 'white', 'Position', [100, 100, 800, 600]);

for i = 1:length(H_vals)
    H = H_vals(i);
    x = zeros(size(t));
    for k = 1:2:H
        x = x + (4/pi) * sin(2*pi*k*t) / k;
    end

    subplot(2, 2, i);
    plot(t, x, 'b', 'LineWidth', 1.2);
    grid on;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(['H = ', num2str(H)]);
    ylim([-1.5 1.5]);
end

saveas(gcf, 'square-wave-comparison.png');
