function [x_t, params] = generate_random_Exponential(t)
% GENERATE_RANDOM_EXPONENTIAL - Generate random exponential signal
    
    % Random amplitude between 0.5 and 5
    amplitude = rand() * 4.5 + 0.5;
    
    % Random exponent between -2 and 2 (excluding very small values near 0)
    exponent = (rand() * 4) - 2;
    if abs(exponent) < 0.1
        exponent = sign(exponent) * 0.1;
    end
    
    % Random DC offset between -5 and 5
    dc_offset = (rand() * 10) - 5;
    
    % Generate exponential signal
    x_t = amplitude * exp(exponent * t) + dc_offset;
    
    % Store parameters
    params.amplitude = amplitude;
    params.exponent = exponent;
    params.dc_offset = dc_offset;
    
    % Display parameters
    fprintf('  Amplitude: %.4f\n', amplitude);
    fprintf('  Exponent: %.4f\n', exponent);
    fprintf('  DC Offset: %.4f\n', dc_offset);
end