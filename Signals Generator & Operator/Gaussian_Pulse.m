function x_t = Gaussian_Pulse(t)
    amplitude = input('The Amplitude = ');
    center = input('The Center Position (mean) = ');
    width = input('The Width (standard deviation σ) = ');
    dc_offset = input('The DC Offset = ');
    
    % Generate Gaussian pulse signal
    x_t = amplitude * exp(-(t - center).^2 / (2 * width^2)) + dc_offset;
    
    % Calculate key pulse characteristics
    fwhm = 2 * sqrt(2 * log(2)) * width;  % Full Width at Half Maximum
    half_max = amplitude / 2 + dc_offset;
    
    % Find pulse boundaries at half maximum
    if ~isempty(t)
        idx_peak = find(abs(t - center) == min(abs(t - center)), 1);
        left_half = find(x_t(1:idx_peak) >= half_max, 1, 'first');
        right_half = find(x_t(idx_peak:end) >= half_max, 1, 'last') + idx_peak - 1;
    end
    
    % Plot the signal
    figure;
    plot(t, x_t, 'k-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Gaussian Pulse: x(t) = %g*e^{-(t-%g)^2/(2*%g^2)} + %g', ...
                  amplitude, center, width, dc_offset));
    grid on;
    
    % Add reference lines and markers
    hold on;
    yline(0, 'k--', 'LineWidth', 0.5, 'Alpha', 0.3);
    if dc_offset ~= 0
        yline(dc_offset, 'r--', 'LineWidth', 1, 'Alpha', 0.5, 'Label', 'DC Offset');
    end
    
    % Mark peak
    plot(center, amplitude + dc_offset, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    
    % Mark FWHM points
    yline(half_max, 'b--', 'LineWidth', 1, 'Alpha', 0.5, 'Label', 'Half Maximum');
    
    % Mark ±σ, ±2σ, ±3σ boundaries
    for i = 1:3
        xline(center - i*width, 'g:', 'LineWidth', 1, 'Alpha', 0.3);
        xline(center + i*width, 'g:', 'LineWidth', 1, 'Alpha', 0.3);
    end
    hold off;
    
    % Display signal properties
    fprintf('\n--- Gaussian Pulse Properties ---\n');
    fprintf('Amplitude: %.4f\n', amplitude);
    fprintf('Center Position (μ): %.4f s\n', center);
    fprintf('Width (σ): %.4f s\n', width);
    fprintf('DC Offset: %.4f\n', dc_offset);
    fprintf('\nPulse Characteristics:\n');
    fprintf('Peak Value: %.4f (at t = %.4f s)\n', amplitude + dc_offset, center);
    fprintf('FWHM (Full Width at Half Max): %.4f s\n', fwhm);
    fprintf('Half Maximum Level: %.4f\n', half_max);
    
    % Percentage of energy contained within ±nσ
    fprintf('\nEnergy Distribution:\n');
    fprintf('Within ±1σ (%.4f to %.4f s): 68.27%% of energy\n', ...
            center - width, center + width);
    fprintf('Within ±2σ (%.4f to %.4f s): 95.45%% of energy\n', ...
            center - 2*width, center + 2*width);
    fprintf('Within ±3σ (%.4f to %.4f s): 99.73%% of energy\n', ...
            center - 3*width, center + 3*width);
    
    % Bandwidth (approximate for Gaussian pulse)
    bandwidth = 1 / (2 * pi * width);
    fprintf('\nApproximate Bandwidth: %.4f Hz\n', bandwidth);
    
    if ~isempty(t)
        fprintf('\nTime Range: %.4f to %.4f s\n', t(1), t(end));
        
        % Calculate pulse energy in the visible range
        dt = mean(diff(t));
        energy = sum(x_t.^2) * dt;
        fprintf('Signal Energy (in range): %.4f\n', energy);
    end
end