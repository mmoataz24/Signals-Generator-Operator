function [x_t, params] = generate_random_DC(t)
% GENERATE_RANDOM_DC - Generate random DC signal
    
    % Random amplitude between -10 and 10
    amplitude = (rand() * 20) - 10;
    
    % Generate DC signal
    x_t = amplitude * ones(size(t));
    
    % Store parameters
    params.amplitude = amplitude;
    
    % Display parameters
    fprintf('  Amplitude: %.4f\n', amplitude);
end