function [x_t, params] = generate_random_Gaussian(t)
% GENERATE_RANDOM_GAUSSIAN - Generate random Gaussian pulse
    
    % Random amplitude between 1 and 10
    amplitude = rand() * 9 + 1;
    
    % Random center within the time range
    t_range = t(end) - t(1);
    center = t(1) + rand() * t_range;
    
    % Random width between 5% and 20% of time range
    width = (rand() * 0.15 + 0.05) * t_range;
    
    % Random DC offset between -2 and 2
    dc_offset = (rand() * 4) - 2;
    
    % Generate Gaussian pulse
    x_t = amplitude * exp(-(t - center).^2 / (2 * width^2)) + dc_offset;
    
    % Store parameters
    params.amplitude = amplitude;
    params.center = center;
    params.width = width;
    params.dc_offset = dc_offset;
    
    % Display parameters
    fprintf('  Amplitude: %.4f\n', amplitude);
    fprintf('  Center: %.4f s\n', center);
    fprintf('  Width (σ): %.4f s\n', width);
    fprintf('  DC Offset: %.4f\n', dc_offset);
end