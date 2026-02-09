function display_operations_summary(x_original, t_original, x_final, t_final, operation_history)
% DISPLAY_OPERATIONS_SUMMARY - Display summary of all operations performed
%
% Syntax: display_operations_summary(x_original, t_original, x_final, t_final, operation_history)

    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('                    OPERATIONS SUMMARY\n');
    fprintf('=========================================================================\n\n');
    
    num_operations = length(operation_history);
    
    fprintf('Total Operations Performed: %d\n\n', num_operations);
    
    % List all operations
    for i = 1:num_operations
        fprintf('%d. %s\n', i, operation_history{i}.operation);
        
        % Display specific parameters for each operation
        params = operation_history{i}.params;
        
        if isfield(params, 'scale_factor')
            fprintf('   - Scaling Factor: %.4f\n', params.scale_factor);
        end
        
        if isfield(params, 'shift_value')
            fprintf('   - Shift Value: %.4f seconds\n', params.shift_value);
        end
        
        if isfield(params, 'expansion_factor')
            fprintf('   - Expansion Factor: %.4f\n', params.expansion_factor);
        end
        
        if isfield(params, 'compression_factor')
            fprintf('   - Compression Factor: %.4f\n', params.compression_factor);
        end
        
        if isfield(params, 'SNR_dB')
            fprintf('   - SNR: %.2f dB\n', params.SNR_dB);
        end
        
        if isfield(params, 'window_size')
            fprintf('   - Window Size: %d samples\n', params.window_size);
        end
        
        fprintf('\n');
    end
    
    % Display signal statistics comparison
    fprintf('─────────────────────────────────────────────────────────────────────────\n');
    fprintf('                    SIGNAL STATISTICS COMPARISON\n');
    fprintf('─────────────────────────────────────────────────────────────────────────\n\n');
    
    fprintf('ORIGINAL SIGNAL:\n');
    fprintf('  Time Range: [%.4f, %.4f] s\n', t_original(1), t_original(end));
    fprintf('  Min Value: %.4f\n', min(x_original));
    fprintf('  Max Value: %.4f\n', max(x_original));
    fprintf('  Mean Value: %.4f\n', mean(x_original));
    fprintf('  RMS Value: %.4f\n', rms(x_original));
    fprintf('  Variance: %.6f\n', var(x_original));
    
    fprintf('\nFINAL SIGNAL:\n');
    fprintf('  Time Range: [%.4f, %.4f] s\n', t_final(1), t_final(end));
    fprintf('  Min Value: %.4f\n', min(x_final));
    fprintf('  Max Value: %.4f\n', max(x_final));
    fprintf('  Mean Value: %.4f\n', mean(x_final));
    fprintf('  RMS Value: %.4f\n', rms(x_final));
    fprintf('  Variance: %.6f\n', var(x_final));
    
    fprintf('\n=========================================================================\n');
    
    % Create comparison plot
    figure('Name', 'Operations Summary - Before and After', 'NumberTitle', 'off');
    
    subplot(2, 1, 1);
    plot(t_original, x_original, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal (Before Operations)');
    grid on;
    
    subplot(2, 1, 2);
    plot(t_final, x_final, 'r-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Final Signal (After %d Operations)', num_operations));
    grid on;
    
    % Create overlay plot if time ranges are compatible
    if length(t_original) == length(t_final) && ...
       abs(t_original(1) - t_final(1)) < 1e-6 && ...
       abs(t_original(end) - t_final(end)) < 1e-6
        
        figure('Name', 'Operations Summary - Overlay Comparison', 'NumberTitle', 'off');
        plot(t_original, x_original, 'b-', 'LineWidth', 2, 'DisplayName', 'Original');
        hold on;
        plot(t_final, x_final, 'r--', 'LineWidth', 2, 'DisplayName', 'Final');
        xlabel('Time (s)');
        ylabel('Amplitude');
        title('Original vs Final Signal Comparison');
        legend('Location', 'best');
        grid on;
        hold off;
    end
end