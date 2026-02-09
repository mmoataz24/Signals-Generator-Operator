function [x_combined, t_combined] = merge_segments(segments)
% MERGE_SEGMENTS - Merge multiple signal segments into one
%
% Syntax: [x_combined, t_combined] = merge_segments(segments)
%
% Inputs:
%   segments - Cell array of segment structures
%
% Outputs:
%   x_combined - Combined signal
%   t_combined - Combined time vector

    num_segments = length(segments);
    
    % Initialize combined arrays
    x_combined = [];
    t_combined = [];
    
    fprintf('Merging %d segments...\n', num_segments);
    
    for i = 1:num_segments
        % For all segments except the first, skip the first point to avoid duplication
        if i == 1
            x_combined = [x_combined, segments{i}.signal];
            t_combined = [t_combined, segments{i}.time];
        else
            % Skip first point if it's a duplicate of the last point
            if abs(segments{i}.time(1) - t_combined(end)) < 1e-10
                x_combined = [x_combined, segments{i}.signal(2:end)];
                t_combined = [t_combined, segments{i}.time(2:end)];
            else
                x_combined = [x_combined, segments{i}.signal];
                t_combined = [t_combined, segments{i}.time];
            end
        end
        
        fprintf('  ✓ Segment %d merged (%d samples)\n', i, length(segments{i}.signal));
    end
    
    fprintf('\nTotal samples in combined signal: %d\n', length(x_combined));
end