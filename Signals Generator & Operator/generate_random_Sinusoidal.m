function [x_t, params] = generate_random_Sinusoidal(t)
% GENERATE_RANDOM_SINUSOIDAL - Generate random sinusoidal signal
    
    % Random amplitude between 1 and 10
    amplitude = rand() * 9 + 1;
    
    % Random frequency between 0.1 and 5 Hz
    frequency = rand() * 4.9 + 0.1;
    
    % Random phase between 0 and 360 degrees
    phase = rand() * 360;
    
    % Random DC offset between -5 and 5
    dc_offset = (rand() * 10) - 5;
    
    % Randomly choose sine or cosine
    type = randi([1, 2]);
    
    % Convert phase to radians
    phase_rad = phase * pi / 180;
    
    % Generate signal
    if type == 1
        x_t = amplitude * sin(2 * pi * frequency * t + phase_rad) + dc_offset;
        signal_name = 'Sine';
    else
        x_t = amplitude * cos(2 * pi * frequency * t + phase_rad) + dc_offset;
        signal_name = 'Cosine';
    end
    
    % Store parameters
    params.amplitude = amplitude;
    params.frequency = frequency;
    params.phase = phase;
    params.dc_offset = dc_offset;
    params.type = type;
    params.signal_name = signal_name;
    
    % Display parameters
    fprintf('  Type: %s\n', signal_name);
    fprintf('  Amplitude: %.4f\n', amplitude);
    fprintf('  Frequency: %.4f Hz\n', frequency);
    fprintf('  Phase: %.4f degrees\n', phase);
    fprintf('  DC Offset: %.4f\n', dc_offset);
end