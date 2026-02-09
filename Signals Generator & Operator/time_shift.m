function [x_shifted, t_new, params] = time_shift(x_t, t)
% TIME_SHIFT - Shift the signal in time
%
% Syntax: [x_shifted, t_new, params] = time_shift(x_t, t)
%
% Inputs:
%   x_t - Original signal
%   t - Time vector
%
% Outputs:
%   x_shifted - Time-shifted signal
%   t_new - Shifted time vector
%   params - Structure containing operation parameters

    fprintf('\n--- TIME SHIFT ---\n');
    shift_value = input('Enter the time shift value in seconds (positive = right, negative = left): ');
    
    % Validate shift value
    while ~isnumeric(shift_value) || ~isscalar(shift_value)
        fprintf('✗ Invalid input! Please enter a numeric value.\n');
        shift_value = input('Enter the time shift value in seconds: ');
    end
    
    % Apply time shift
    t_new = t + shift_value;
    x_shifted = x_t;  % Signal values remain the same, only time axis shifts
    
    % Store parameters
    params.operation = 'Time Shift';
    params.shift_value = shift_value;
    
    % Plot comparison
    figure('Name', 'Time Shift', 'NumberTitle', 'off');
    
    subplot(2, 1, 1);
    plot(t, x_t, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal: x(t)');
    grid on;
    
    subplot(2, 1, 2);
    plot(t_new, x_shifted, 'r-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Time-Shifted Signal: x(t - %.2f)', shift_value));
    grid on;
    
    % Display operation info
    fprintf('\n--- Operation Results ---\n');
    fprintf('Shift Value: %.4f seconds\n', shift_value);
    if shift_value > 0
        fprintf('Direction: Right (delayed)\n');
    elseif shift_value < 0
        fprintf('Direction: Left (advanced)\n');
    else
        fprintf('Direction: No shift\n');
    end
    fprintf('Original time range: [%.4f, %.4f] s\n', t(1), t(end));
    fprintf('Shifted time range: [%.4f, %.4f] s\n', t_new(1), t_new(end));
    fprintf('✅ Time shift completed!\n');
end