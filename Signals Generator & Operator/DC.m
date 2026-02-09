function x_t = DC(t)
    amplitude = input('The Amplitude (DC Level) = ');
    
    % Generate DC signal
    x_t = amplitude * ones(size(t));
    
    % Plot the signal
    figure;
    plot(t, x_t, 'r-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('DC Signal: x(t) = %g', amplitude));
    grid on;
    
    % Set y-axis limits with appropriate margins
    if amplitude >= 0
        ylim([min(-0.5, amplitude - 1), amplitude + 1]);
    else
        ylim([amplitude - 1, max(0.5, amplitude + 1)]);
    end
    
    % Add reference lines
    hold on;
    yline(0, 'k--', 'LineWidth', 0.5, 'Alpha', 0.3, 'Label', 'Zero');
    yline(amplitude, 'r--', 'LineWidth', 1, 'Alpha', 0.5);
    hold off;
    
    % Display signal properties
    fprintf('\n--- DC Signal Properties ---\n');
    fprintf('DC Level (Amplitude): %.4f\n', amplitude);
    fprintf('Signal Type: Constant\n');
    
    if ~isempty(t)
        fprintf('Time Duration: %.4f s (from %.4f to %.4f s)\n', ...
                t(end) - t(1), t(1), t(end));
    end
    
    % Additional info
    fprintf('\nCharacteristics:\n');
    fprintf('- Frequency: 0 Hz (no oscillation)\n');
    fprintf('- RMS Value: %.4f\n', abs(amplitude));
    fprintf('- Average Value: %.4f\n', amplitude);
    fprintf('- Peak-to-Peak: 0 (constant)\n');
end