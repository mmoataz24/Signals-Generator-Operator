function [x_t, params] = generate_random_Sawtooth(t)
% GENERATE_RANDOM_SAWTOOTH - Generate random sawtooth wave
    
    % Random amplitude between 1 and 10
    amplitude = rand() * 9 + 1;
    
    % Random frequency between 0.1 and 5 Hz
    frequency = rand() * 4.9 + 0.1;
    
    % Random phase between 0 and 360 degrees
    phase = rand() * 360;
    
    % Random DC offset between -5 and 5
    dc_offset = (rand() * 10) - 5;
    
    % Convert phase to radians
    phase_rad = phase * pi / 180;
    
    % Generate sawtooth wave
    x_t = amplitude * sawtooth(2 * pi * frequency * t + phase_rad) + dc_offset;
    
    % Store parameters
    params.amplitude = amplitude;
    params.frequency = frequency;
    params.phase = phase;
    params.dc_offset = dc_offset;
    
    % Display parameters
    fprintf('  Amplitude: %.4f\n', amplitude);
    fprintf('  Frequency: %.4f Hz\n', frequency);
    fprintf('  Phase: %.4f degrees\n', phase);
    fprintf('  DC Offset: %.4f\n', dc_offset);
end