function [x_expanded, t_new, params] = time_expansion(x_t, t)
% TIME_EXPANSION - Expand the signal in time (slow down)
%
% Syntax: [x_expanded, t_new, params] = time_expansion(x_t, t)
%
% Inputs:
%   x_t - Original signal
%   t - Time vector
%
% Outputs:
%   x_expanded - Time-expanded signal
%   t_new - Expanded time vector
%   params - Structure containing operation parameters

    fprintf('\n--- TIME EXPANSION ---\n');
    expansion_factor = input('Enter the expansion factor (e.g., 2 to make signal twice as slow): ');
    
    % Validate expansion factor
    while ~isnumeric(expansion_factor) || ~isscalar(expansion_factor) || expansion_factor <= 0
        fprintf('✗ Invalid input! Please enter a positive numeric value.\n');
        expansion_factor = input('Enter the expansion factor: ');
    end
    
    % Apply time expansion: x(t) → x(t/a) where a > 1 expands the signal
    t_new = t * expansion_factor;
    x_expanded = x_t;  % Signal values remain the same
    
    % Store parameters
    params.operation = 'Time Expansion';
    params.expansion_factor = expansion_factor;
    
    % Plot comparison
    figure('Name', 'Time Expansion', 'NumberTitle', 'off');
    
    subplot(2, 1, 1);
    plot(t, x_t, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal: x(t)');
    grid on;
    
    subplot(2, 1, 2);
    plot(t_new, x_expanded, 'r-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Time-Expanded Signal: x(t/%.2f)', expansion_factor));
    grid on;
    
    % Display operation info
    fprintf('\n--- Operation Results ---\n');
    fprintf('Expansion Factor: %.4f\n', expansion_factor);
    fprintf('Original time range: [%.4f, %.4f] s (Duration: %.4f s)\n', ...
            t(1), t(end), t(end) - t(1));
    fprintf('Expanded time range: [%.4f, %.4f] s (Duration: %.4f s)\n', ...
            t_new(1), t_new(end), t_new(end) - t_new(1));
    fprintf('Signal is now %.2fx slower\n', expansion_factor);
    fprintf('✅ Time expansion completed!\n');
end