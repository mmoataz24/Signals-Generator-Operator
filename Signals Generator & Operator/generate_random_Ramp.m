function [x_t, params] = generate_random_Ramp(t)
% GENERATE_RANDOM_RAMP - Generate random ramp signal
    
    % Random slope between -5 and 5
    slope = (rand() * 10) - 5;
    
    % Random intercept between -10 and 10
    intercept = (rand() * 20) - 10;
    
    % Generate ramp signal
    x_t = slope * t + intercept;
    
    % Store parameters
    params.slope = slope;
    params.intercept = intercept;
    
    % Display parameters
    fprintf('  Slope: %.4f\n', slope);
    fprintf('  Intercept: %.4f\n', intercept);
end