function [x_t, params] = generate_random_Polynomial(t)
% GENERATE_RANDOM_POLYNOMIAL - Generate random polynomial signal
    
    % Random amplitude between 0.1 and 2
    amplitude = rand() * 1.9 + 0.1;
    
    % Random intercept between -10 and 10
    intercept = (rand() * 20) - 10;
    
    % Random order between 2 and 4
    order = randi([2, 4]);
    
    % Generate random coefficients
    coefficients = zeros(1, order + 1);
    for i = 1:(order + 1)
        % Scale coefficients to avoid extreme values
        power = order + 1 - i;
        scale_factor = 10 / (power + 1);  % Higher powers get smaller coefficients
        coefficients(i) = (rand() * 2 - 1) * scale_factor;
    end
    
    % Generate polynomial signal
    x_t = amplitude * polyval(coefficients, t) + intercept;
    
    % Store parameters
    params.amplitude = amplitude;
    params.intercept = intercept;
    params.order = order;
    params.coefficients = coefficients;
    
    % Display parameters
    fprintf('  Amplitude: %.4f\n', amplitude);
    fprintf('  Intercept: %.4f\n', intercept);
    fprintf('  Order: %d\n', order);
    fprintf('  Coefficients: ');
    fprintf('%.4f ', coefficients);
    fprintf('\n');
end