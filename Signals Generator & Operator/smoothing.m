function [x_smoothed, t_new, params] = smoothing(x_t, t)
% SMOOTHING - Smooth the signal using moving average filter
%
% Syntax: [x_smoothed, t_new, params] = smoothing(x_t, t)
%
% Inputs:
%   x_t - Original signal
%   t - Time vector
%
% Outputs:
%   x_smoothed - Smoothed signal
%   t_new - Time vector (unchanged)
%   params - Structure containing operation parameters

    fprintf('\n--- SMOOTHING (MOVING AVERAGE) ---\n');
    fprintf('Window size determines smoothing strength: larger = smoother\n');
    fprintf('Recommended: 3-20 for subtle smoothing, 21-50 for strong smoothing\n');
    
    window_size = input('Enter the window size (odd number recommended): ');
    
    % Validate window size
    while ~isnumeric(window_size) || ~isscalar(window_size) || ...
          window_size < 1 || window_size ~= floor(window_size) || window_size > length(x_t)
        fprintf('✗ Invalid input! Please enter a positive integer less than signal length (%d).\n', length(x_t));
        window_size = input('Enter the window size: ');
    end
    
    % Make window size odd for symmetry
    if mod(window_size, 2) == 0
        window_size = window_size + 1;
        fprintf('ℹ Window size adjusted to %d (odd number) for symmetry.\n', window_size);
    end
    
    % Apply moving average filter
    % Create moving average filter
    window = ones(1, window_size) / window_size;
    
    % Use convolution for moving average (with 'same' to keep original length)
    x_smoothed = conv(x_t, window, 'same');
    t_new = t;
    
    % Store parameters
    params.operation = 'Smoothing (Moving Average)';
    params.window_size = window_size;
    
    % Calculate smoothing metrics
    original_variance = var(x_t);
    smoothed_variance = var(x_smoothed);
    variance_reduction = (1 - smoothed_variance/original_variance) * 100;
    
    % Plot comparison
    figure('Name', 'Smoothing', 'NumberTitle', 'off');
    
    subplot(2, 1, 1);
    plot(t, x_t, 'b-', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal');
    grid on;
    
    subplot(2, 1, 2);
    plot(t_new, x_smoothed, 'r-', 'LineWidth', 1.5);
    hold on;
    plot(t, x_t, 'b:', 'LineWidth', 0.5, 'Color', [0.5 0.5 0.5]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Smoothed Signal (Window = %d)', window_size));
    legend('Smoothed', 'Original', 'Location', 'best');
    grid on;
    hold off;
    
    % Plot overlay comparison
    figure('Name', 'Smoothing Comparison', 'NumberTitle', 'off');
    plot(t, x_t, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Original');
    hold on;
    plot(t_new, x_smoothed, 'r-', 'LineWidth', 2, 'DisplayName', 'Smoothed');
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Original vs Smoothed Signal (Window = %d)', window_size));
    legend('Location', 'best');
    grid on;
    hold off;
    
    % Display operation info
    fprintf('\n--- Operation Results ---\n');
    fprintf('Window Size: %d samples\n', window_size);
    fprintf('Original Signal - Mean: %.4f, Variance: %.6f\n', mean(x_t), original_variance);
    fprintf('Smoothed Signal - Mean: %.4f, Variance: %.6f\n', mean(x_smoothed), smoothed_variance);
    fprintf('Variance Reduction: %.2f%%\n', variance_reduction);
    
    % Calculate difference
    difference = x_t - x_smoothed;
    fprintf('Mean Absolute Difference: %.6f\n', mean(abs(difference)));
    fprintf('Max Absolute Difference: %.6f\n', max(abs(difference)));
    fprintf('✅ Smoothing completed!\n');
end