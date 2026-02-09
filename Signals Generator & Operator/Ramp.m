function x_t = Ramp(t)
    slope = input('The Slope = ');
    intercept = input('The Intercept = ');
    
    % Generate ramp signal
    x_t = slope * t + intercept;
    
    % Determine signal type based on slope
    if slope > 0
        signal_type = 'Increasing';
    elseif slope < 0
        signal_type = 'Decreasing';
    else
        signal_type = 'Constant (Zero Slope)';
    end
    
    % Plot the signal
    figure;
    plot(t, x_t, 'g-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Ramp Signal: x(t) = %g*t + %g', slope, intercept));
    grid on;
    
    % Add reference lines
    hold on;
    yline(0, 'k--', 'LineWidth', 0.5, 'Alpha', 0.3, 'Label', 'Zero');
    yline(intercept, 'r--', 'LineWidth', 1, 'Alpha', 0.5, 'Label', 'Intercept');
    
    % Mark initial point
    if ~isempty(t)
        plot(t(1), x_t(1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
        plot(t(end), x_t(end), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    end
    hold off;
    
    % Display signal properties
    fprintf('\n--- Ramp Signal Properties ---\n');
    fprintf('Signal Type: %s Ramp\n', signal_type);
    fprintf('Slope: %.4f\n', slope);
    fprintf('Intercept: %.4f\n', intercept);
    
    if ~isempty(t)
        fprintf('\nTime Range: %.4f to %.4f s (Duration: %.4f s)\n', ...
                t(1), t(end), t(end) - t(1));
        fprintf('Initial value at t=%.4f: %.4f\n', t(1), x_t(1));
        fprintf('Final value at t=%.4f: %.4f\n', t(end), x_t(end));
        fprintf('Total change: %.4f\n', x_t(end) - x_t(1));
        
        if slope ~= 0
            % Calculate when signal crosses zero
            t_zero = -intercept / slope;
            if t_zero >= t(1) && t_zero <= t(end)
                fprintf('\nZero crossing at t = %.4f s\n', t_zero);
            elseif t_zero < t(1)
                fprintf('\nZero crossing occurred before t = %.4f s (at t = %.4f s)\n', t(1), t_zero);
            else
                fprintf('\nZero crossing will occur after t = %.4f s (at t = %.4f s)\n', t(end), t_zero);
            end
        end
        
        % Average value over the time range
        avg_value = mean(x_t);
        fprintf('Average value: %.4f\n', avg_value);
    end
end