function display_random_signals_summary(signals)
% DISPLAY_RANDOM_SIGNALS_SUMMARY - Display summary of all generated signals
    
    num_signals = length(signals);
    
    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('                    RANDOM SIGNALS SUMMARY\n');
    fprintf('=========================================================================\n\n');
    
    for i = 1:num_signals
        fprintf('Signal %d: %s\n', i, signals{i}.type_name);
        fprintf('  Time Range: %.4f to %.4f s\n', ...
                signals{i}.time(1), signals{i}.time(end));
        fprintf('  Min Value: %.4f\n', min(signals{i}.data));
        fprintf('  Max Value: %.4f\n', max(signals{i}.data));
        fprintf('  Mean Value: %.4f\n', mean(signals{i}.data));
        fprintf('  RMS Value: %.4f\n', rms(signals{i}.data));
        fprintf('\n');
    end
    
    fprintf('=========================================================================\n');
end