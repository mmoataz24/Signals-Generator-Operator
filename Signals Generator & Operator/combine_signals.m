function [x_combined, t_combined] = combine_signals(t_start, t_end, F_s)
% COMBINE_SIGNALS - Combine multiple signals at specified breakpoints
%
% Syntax: [x_combined, t_combined] = combine_signals(t_start, t_end, F_s)
%
% Inputs:
%   t_start - Start time
%   t_end - End time
%   F_s - Sampling frequency
%
% Outputs:
%   x_combined - Combined signal
%   t_combined - Time vector for combined signal

    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('                    SIGNAL COMBINATION MODULE\n');
    fprintf('=========================================================================\n');
    
    % Get number of segments
    fprintf('\nHow many signal segments do you want to combine?\n');
    num_segments = input('Enter number of segments (minimum 2): ');
    
    % Validate number of segments
    while ~isnumeric(num_segments) || num_segments < 2 || num_segments ~= floor(num_segments)
        fprintf('✗ Invalid input! Please enter an integer ≥ 2.\n');
        num_segments = input('Enter number of segments: ');
    end
    
    % Get breakpoints
    breakpoints = get_breakpoints(t_start, t_end, num_segments);
    
    % Display segment information
    fprintf('\n--- SEGMENT BREAKDOWN ---\n');
    for i = 1:num_segments
        fprintf('Segment %d: [%.4f, %.4f] s (Duration: %.4f s)\n', ...
                i, breakpoints(i), breakpoints(i+1), ...
                breakpoints(i+1) - breakpoints(i));
    end
    fprintf('=========================================================================\n');
    
    % Generate each segment
    segments = cell(num_segments, 1);
    
    for i = 1:num_segments
        fprintf('\n');
        fprintf('─────────────────────────────────────────────────────────────────────────\n');
        fprintf('                    SEGMENT %d of %d\n', i, num_segments);
        fprintf('                    Time Range: [%.4f, %.4f] s\n', ...
                breakpoints(i), breakpoints(i+1));
        fprintf('─────────────────────────────────────────────────────────────────────────\n');
        
        % Create time vector for this segment
        T_s = 1 / F_s;
        t_segment = breakpoints(i):T_s:breakpoints(i+1);
        
        % Get signal choice for this segment
        choice = get_signal_choice();
        
        fprintf('\n📊 Generating signal for Segment %d...\n\n', i);
        
        % Generate signal based on choice
        switch choice
            case 1
                x_segment = DC(t_segment);
            case 2
                x_segment = Ramp(t_segment);
            case 3
                x_segment = Exponential(t_segment);
            case 4
                [x_segment, t_segment, ~] = Sinusoidal(t_segment, F_s, breakpoints(i), breakpoints(i+1));
            case 5
                x_segment = Gaussian_Pulse(t_segment);
            case 6
                [x_segment, t_segment, ~] = Sawtooth_Wave(t_segment, F_s, breakpoints(i), breakpoints(i+1));
            case 7
                x_segment = Polynomial(t_segment);
        end
        
        % Store segment
        segments{i}.signal = x_segment;
        segments{i}.time = t_segment;
        segments{i}.type = choice;
        segments{i}.start = breakpoints(i);
        segments{i}.end = breakpoints(i+1);
        
        fprintf('\n✅ Segment %d completed!\n', i);
    end
    
    % Combine all segments
    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('                    COMBINING SEGMENTS\n');
    fprintf('=========================================================================\n');
    
    [x_combined, t_combined] = merge_segments(segments);
    
    % Plot combined signal
    plot_combined_signal(segments, x_combined, t_combined, breakpoints);
    
    % Display statistics
    display_combination_summary(segments, x_combined, t_combined, breakpoints);
    
    fprintf('\n=========================================================================\n');
    fprintf('✅ Signal combination completed successfully!\n');
    fprintf('=========================================================================\n\n');
end