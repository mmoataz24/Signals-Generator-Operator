function [x_scaled, t_new, params] = amplitude_scaling(x_t, t)
% AMPLITUDE_SCALING - Scale the amplitude of a signal
%
% Syntax: [x_scaled, t_new, params] = amplitude_scaling(x_t, t)
%
% Inputs:
%   x_t - Original signal
%   t - Time vector
%
% Outputs:
%   x_scaled - Scaled signal
%   t_new - Time vector (unchanged)
%   params - Structure containing operation parameters

    fprintf('\n--- AMPLITUDE SCALING ---\n');
    scale_factor = input('Enter the scaling factor (e.g., 2 for double, 0.5 for half): ');
    
    % Validate scaling factor
    while ~isnumeric(scale_factor) || ~isscalar(scale_factor)
        fprintf('✗ Invalid input! Please enter a numeric value.\n');
        scale_factor = input('Enter the scaling factor: ');
    end
    
    % Apply amplitude scaling
    x_scaled = scale_factor * x_t;
    t_new = t;
    
    % Store parameters
    params.operation = 'Amplitude Scaling';
    params.scale_factor = scale_factor;
    
    % Plot comparison
    figure('Name', 'Amplitude Scaling', 'NumberTitle', 'off');
    
    subplot(2, 1, 1);
    plot(t, x_t, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal');
    grid on;
    
    subplot(2, 1, 2);
    plot(t_new, x_scaled, 'r-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Scaled Signal (Factor = %.2f)', scale_factor));
    grid on;
    
    % Display operation info
    fprintf('\n--- Operation Results ---\n');
    fprintf('Scaling Factor: %.4f\n', scale_factor);
    fprintf('Original Signal - Min: %.4f, Max: %.4f, Mean: %.4f\n', ...
            min(x_t), max(x_t), mean(x_t));
    fprintf('Scaled Signal - Min: %.4f, Max: %.4f, Mean: %.4f\n', ...
            min(x_scaled), max(x_scaled), mean(x_scaled));
    fprintf('✅ Amplitude scaling completed!\n');
end