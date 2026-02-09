function x_t = Exponential(t)
    amplitude = input('The Amplitude = ');
    exponent = input('The Exponent (decay rate if negative, growth rate if positive) = ');
    dc_offset = input('The DC Offset = ');
    
    % Generate exponential signal
    x_t = amplitude * exp(exponent * t) + dc_offset;
    
    % Determine signal type for display
    if exponent > 0
        signal_type = 'Growing';
    elseif exponent < 0
        signal_type = 'Decaying';
    else
        signal_type = 'Constant';
    end
    
    % Plot the signal
    figure;
    plot(t, x_t, 'm-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Exponential Signal: x(t) = %g*e^{%g*t} + %g', amplitude, exponent, dc_offset));
    grid on;
    
    % Add reference lines
    hold on;
    yline(0, 'k--', 'LineWidth', 0.5, 'Alpha', 0.3);
    if dc_offset ~= 0
        yline(dc_offset, 'r--', 'LineWidth', 1, 'Label', 'DC Offset');
    end
    hold off;
    
    % Display signal properties
    fprintf('\n--- Exponential Signal Properties ---\n');
    fprintf('Signal Type: %s Exponential\n', signal_type);
    fprintf('Amplitude: %.2f\n', amplitude);
    fprintf('Exponent: %.4f\n', exponent);
    fprintf('DC Offset: %.2f\n', dc_offset);
    
    if exponent ~= 0
        time_constant = abs(1/exponent);
        fprintf('Time Constant (τ): %.4f s\n', time_constant);
        
        if exponent < 0
            fprintf('At t=τ, signal decays to %.2f%% of initial value\n', 100/exp(1));
        else
            fprintf('At t=τ, signal grows to %.2f%% more than initial value\n', (exp(1)-1)*100);
        end
    end
    
    % Display initial and final values (if within time range)
    if ~isempty(t)
        fprintf('\nInitial value at t=%.2f: %.4f\n', t(1), x_t(1));
        fprintf('Final value at t=%.2f: %.4f\n', t(end), x_t(end));
    end
end