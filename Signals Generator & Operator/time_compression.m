function [x_compressed, t_new, params] = time_compression(x_t, t)
% TIME_COMPRESSION - Compress the signal in time (speed up)
%
% Syntax: [x_compressed, t_new, params] = time_compression(x_t, t)
%
% Inputs:
%   x_t - Original signal
%   t - Time vector
%
% Outputs:
%   x_compressed - Time-compressed signal
%   t_new - Compressed time vector
%   params - Structure containing operation parameters

    fprintf('\n--- TIME COMPRESSION ---\n');
    compression_factor = input('Enter the compression factor (e.g., 2 to make signal twice as fast): ');
    
    % Validate compression factor
    while ~isnumeric(compression_factor) || ~isscalar(compression_factor) || compression_factor <= 0
        fprintf('✗ Invalid input! Please enter a positive numeric value.\n');
        compression_factor = input('Enter the compression factor: ');
    end
    
    % Apply time compression: x(t) → x(a*t) where a > 1 compresses the signal
    t_new = t / compression_factor;
    x_compressed = x_t;  % Signal values remain the same
    
    % Store parameters
    params.operation = 'Time Compression';
    params.compression_factor = compression_factor;
    
    % Plot comparison
    figure('Name', 'Time Compression', 'NumberTitle', 'off');
    
    subplot(2, 1, 1);
    plot(t, x_t, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal: x(t)');
    grid on;
    
    subplot(2, 1, 2);
    plot(t_new, x_compressed, 'r-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Time-Compressed Signal: x(%.2f*t)', compression_factor));
    grid on;
    
    % Display operation info
    fprintf('\n--- Operation Results ---\n');
    fprintf('Compression Factor: %.4f\n', compression_factor);
    fprintf('Original time range: [%.4f, %.4f] s (Duration: %.4f s)\n', ...
            t(1), t(end), t(end) - t(1));
    fprintf('Compressed time range: [%.4f, %.4f] s (Duration: %.4f s)\n', ...
            t_new(1), t_new(end), t_new(end) - t_new(1));
    fprintf('Signal is now %.2fx faster\n', compression_factor);
    fprintf('✅ Time compression completed!\n');
end