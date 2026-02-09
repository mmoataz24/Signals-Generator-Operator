function breakpoints = get_breakpoints(t_start, t_end, num_segments)
% GET_BREAKPOINTS - Get time breakpoints from user
%
% Syntax: breakpoints = get_breakpoints(t_start, t_end, num_segments)
%
% Inputs:
%   t_start - Start time
%   t_end - End time
%   num_segments - Number of segments
%
% Outputs:
%   breakpoints - Array of breakpoint times (length = num_segments + 1)

    fprintf('\n--- DEFINE BREAKPOINTS ---\n');
    fprintf('Total time range: [%.4f, %.4f] s\n', t_start, t_end);
    fprintf('You need to define %d breakpoint(s) between start and end.\n', num_segments - 1);
    fprintf('Breakpoints will divide the signal into %d segments.\n\n', num_segments);
    
    % Initialize breakpoints array
    breakpoints = zeros(1, num_segments + 1);
    breakpoints(1) = t_start;
    breakpoints(end) = t_end;
    
    % Get intermediate breakpoints
    for i = 2:num_segments
        valid_input = false;
        
        while ~valid_input
            fprintf('Breakpoint %d (must be between %.4f and %.4f): ', ...
                    i-1, breakpoints(i-1), t_end);
            bp = input('');
            
            % Validate breakpoint
            if ~isnumeric(bp) || ~isscalar(bp)
                fprintf('✗ Invalid input! Please enter a numeric value.\n');
            elseif bp <= breakpoints(i-1)
                fprintf('✗ Error: Breakpoint must be greater than %.4f\n', breakpoints(i-1));
            elseif bp >= t_end
                fprintf('✗ Error: Breakpoint must be less than %.4f\n', t_end);
            else
                breakpoints(i) = bp;
                valid_input = true;
                fprintf('✓ Breakpoint %d set to %.4f s\n\n', i-1, bp);
            end
        end
    end
    
    % Display all breakpoints
    fprintf('--- BREAKPOINTS SUMMARY ---\n');
    fprintf('Start: %.4f s\n', breakpoints(1));
    for i = 2:num_segments
        fprintf('Breakpoint %d: %.4f s\n', i-1, breakpoints(i));
    end
    fprintf('End: %.4f s\n', breakpoints(end));
    fprintf('\n');
end