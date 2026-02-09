function [x_t, t_new, F_s_new] = Sinusoidal(t,F_s , t_start, t_end)
    amplitude = input('The Amplitude = ');
    frequency = input('The Frequency (Hz) = ');
    phase = input('The Phase Shift (degrees) = ');
    dc_offset = input('The DC Offset = ');
    
    % Calculate actual sampling frequency from time vector
    F_s = 1 / (t(2) - t(1));
    
    % Validate Nyquist criterion
    nyquist_rate = 2 * frequency;
    samples_per_cycle = F_s / frequency;
    
    fprintf('\n--- Sampling Analysis ---\n');
    fprintf('Signal Frequency: %.2f Hz\n', frequency);
    fprintf('Sampling Frequency: %.2f Hz\n', F_s);
    fprintf('Nyquist Rate (minimum): %.2f Hz\n', nyquist_rate);
    fprintf('Samples per cycle: %.2f\n', samples_per_cycle);

    % Check if resampling is needed
    need_reconfig = false;
    
    if F_s < nyquist_rate
        warning('⚠ ALIASING WARNING: Sampling frequency (%.2f Hz) is below Nyquist rate (%.2f Hz)!', F_s, nyquist_rate);
        fprintf('   The signal will be aliased and distorted!\n');
        fprintf('   Increase sampling frequency to at least %.2f Hz\n\n', nyquist_rate);
        need_reconfig = true;
    elseif samples_per_cycle < 10
        warning('⚠ LOW QUALITY: Only %.1f samples per cycle.', samples_per_cycle);
        fprintf('   For better visualization, increase sampling frequency to %.2f Hz or higher.\n\n', frequency * 10);
        user_choice = input('\nContinue with current sampling rate? (y/n): ', 's');
        if ~strcmpi(user_choice, 'y')
            need_reconfig = true;
        end
    else
        fprintf('✓ Sampling frequency is adequate.\n\n');
    end

    % Reconfigure sampling if needed
    if need_reconfig
        fprintf('\n--- RECONFIGURE SAMPLING FREQUENCY ---\n');
        fprintf('Recommended minimum: %.2f Hz (Nyquist rate)\n', nyquist_rate);
        fprintf('Recommended for good quality: %.2f Hz (10 samples/cycle)\n', frequency * 10);
        fprintf('Recommended for excellent quality: %.2f Hz (100 samples/cycle)\n\n', frequency * 100);
        
        F_s_new = input('Enter new Sampling Frequency (Hz) = ');
        
        % Validate new sampling frequency
        while F_s_new <= 0 || F_s_new < nyquist_rate
            if F_s_new <= 0
                fprintf('✗ Error: Sampling frequency must be positive!\n');
            else
                fprintf('✗ Error: Still below Nyquist rate (%.2f Hz)!\n', nyquist_rate);
            end
            F_s_new = input('Enter new Sampling Frequency (Hz) = ');
        end
        
        % Recalculate time vector with new sampling frequency
        T_s_new = 1 / F_s_new;
        t_new = t_start:T_s_new:t_end;
        
        fprintf('\n✓ Sampling frequency updated successfully!\n');
        fprintf('New samples per cycle: %.2f\n', F_s_new / frequency);
        fprintf('New number of samples: %d\n\n', length(t_new));
    else
        t_new = t;
        F_s_new = F_s;
    end
    

    % Get sinusoidal type
    type = get_sinusoidal_signal();
    
    % Convert phase from degrees to radians
    phase_rad = phase * pi / 180;
    
    % Generate signal based on type
    switch type
        case 1
            x_t = amplitude * sin(2 * pi * frequency * t_new + phase_rad) + dc_offset;
            signal_name = 'Sine';
            fprintf('\nSine Signal Has Been Chosen\n');
        case 2
             x_t = amplitude * cos(2 * pi * frequency * t_new + phase_rad) + dc_offset;
            signal_name = 'Cosine';
            fprintf('\nCosine Signal Has Been Chosen\n');
    end
    
    % Create dynamic title based on signal type
    if type == 1
        titleStr = sprintf('Sinusoidal Signal: x(t) = %g*sin(2π*%g*t + %g°) + %g', ...
                          amplitude, frequency, phase, dc_offset);
    else
        titleStr = sprintf('Sinusoidal Signal: x(t) = %g*cos(2π*%g*t + %g°) + %g', ...
                          amplitude, frequency, phase, dc_offset);
    end
    
    % Plot the signal
    figure;
    plot(t_new, x_t, 'c-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(titleStr);
    grid on;
    ylim([dc_offset - amplitude - 0.5, dc_offset + amplitude + 0.5]);
    
    % Add zero line and DC offset line for reference
    hold on;
    yline(0, 'k--', 'LineWidth', 0.5, 'Alpha', 0.3);
    if dc_offset ~= 0
        yline(dc_offset, 'r--', 'LineWidth', 1, 'Label', 'DC Offset');
    end
    hold off;
    
    % Display signal properties
    fprintf('\n--- %s Wave Properties ---\n', signal_name);
    fprintf('Amplitude: %.2f\n', amplitude);
    fprintf('Frequency: %.2f Hz\n', frequency);
    fprintf('Period: %.4f s\n', 1/frequency);
    fprintf('Phase Shift: %.2f degrees (%.4f radians)\n', phase, phase_rad);
    fprintf('DC Offset: %.2f\n', dc_offset);
    fprintf('Peak-to-Peak: %.2f\n', 2*amplitude);
    fprintf('Actual Sampling Frequency: %.2f Hz\n', F_s_new);
    fprintf('Actual Samples per Cycle: %.2f\n', F_s_new / frequency);
end