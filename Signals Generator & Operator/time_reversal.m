function [x_reversed, t_new, params] = time_reversal(x_t, t)
% TIME_REVERSAL - Reverse the signal in time
%
% Syntax: [x_reversed, t_new, params] = time_reversal(x_t, t)
%
% Inputs:
%   x_t - Original signal
%   t - Time vector
%
% Outputs:
%   x_reversed - Time-reversed signal
%   t_new - Reversed time vector
%   params - Structure containing operation parameters

    fprintf('\n--- TIME REVERSAL ---\n');
    fprintf('Reversing signal in time: x(t) → x(-t)\n');
    
    % Apply time reversal
    x_reversed = fliplr(x_t);
    t_new = -fliplr(t);
    
    % Store parameters
    params.operation = 'Time Reversal';
    
    % Plot comparison
    figure('Name', 'Time Reversal', 'NumberTitle', 'off');
    
    subplot(2, 1, 1);
    plot(t, x_t, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal: x(t)');
    grid on;
    
    subplot(2, 1, 2);
    plot(t_new, x_reversed, 'r-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Time-Reversed Signal: x(-t)');
    grid on;
    
    % Display operation info
    fprintf('\n--- Operation Results ---\n');
    fprintf('Original time range: [%.4f, %.4f] s\n', t(1), t(end));
    fprintf('Reversed time range: [%.4f, %.4f] s\n', t_new(1), t_new(end));
    fprintf('✅ Time reversal completed!\n');
end