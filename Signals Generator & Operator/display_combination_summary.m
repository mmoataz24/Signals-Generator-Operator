function display_combination_summary(segments, x_combined, t_combined, breakpoints)
% DISPLAY_COMBINATION_SUMMARY - Display summary of combined signal
%
% Syntax: display_combination_summary(segments, x_combined, t_combined, breakpoints)

    num_segments = length(segments);
    
    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('                    COMBINATION SUMMARY\n');
    fprintf('=========================================================================\n\n');
    
    fprintf('Number of Segments: %d\n', num_segments);
    fprintf('Total Duration: %.4f s\n', t_combined(end) - t_combined(1));
    fprintf('Total Samples: %d\n\n', length(x_combined));
    
    fprintf('--- SEGMENT DETAILS ---\n');
    for i = 1:num_segments
        fprintf('\nSegment %d:\n', i);
        fprintf('  Time Range: [%.4f, %.4f] s\n', segments{i}.start, segments{i}.end);
        fprintf('  Duration: %.4f s\n', segments{i}.end - segments{i}.start);
        fprintf('  Samples: %d\n', length(segments{i}.signal));
        fprintf('  Min Value: %.4f\n', min(segments{i}.signal));
        fprintf('  Max Value: %.4f\n', max(segments{i}.signal));
        fprintf('  Mean Value: %.4f\n', mean(segments{i}.signal));
        fprintf('  RMS Value: %.4f\n', rms(segments{i}.signal));
    end
    
    fprintf('\n--- COMBINED SIGNAL STATISTICS ---\n');
    fprintf('Min Value: %.4f\n', min(x_combined));
    fprintf('Max Value: %.4f\n', max(x_combined));
    fprintf('Mean Value: %.4f\n', mean(x_combined));
    fprintf('RMS Value: %.4f\n', rms(x_combined));
    fprintf('Variance: %.6f\n', var(x_combined));
    fprintf('Standard Deviation: %.6f\n', std(x_combined));
    
    fprintf('\n--- BREAKPOINTS ---\n');
    for i = 1:length(breakpoints)
        if i == 1
            fprintf('Start: %.4f s\n', breakpoints(i));
        elseif i == length(breakpoints)
            fprintf('End: %.4f s\n', breakpoints(i));
        else
            fprintf('Breakpoint %d: %.4f s\n', i-1, breakpoints(i));
        end
    end
    
    fprintf('\n=========================================================================\n');
end