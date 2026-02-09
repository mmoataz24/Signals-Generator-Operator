function [x_t, t_new, F_s_new] = Sawtooth_Wave(t, F_s, t_start, t_end)
    amplitude = input('The Amplitude = ');
    frequency = input('The Frequency (Hz) = ');
    phase = input('The Phase Shift (degrees) = ');
    dc_offset = input('The DC Offset = ');
    
    % Convert phase from degrees to radians
    phase_rad = phase * pi / 180;
    
    % Calculate sampling metrics
    nyquist_rate = 2 * frequency;  % Minimum for fundamental only
    samples_per_cycle = F_s / frequency;
    
    % For sawtooth, we need many more samples due to harmonics
    recommended_min = frequency * 50;   % 50 samples per cycle
    recommended_good = frequency * 100;  % 100 samples per cycle
    
    fprintf('\n--- Sampling Analysis for Sawtooth Wave ---\n');
    fprintf('Signal Frequency (fundamental): %.2f Hz\n', frequency);
    fprintf('Sampling Frequency: %.2f Hz\n', F_s);
    fprintf('Nyquist Rate (fundamental only): %.2f Hz\n', nyquist_rate);
    fprintf('Samples per cycle: %.2f\n', samples_per_cycle);
    
    % Determine sampling adequacy
    need_reconfig = false;
    
    if F_s < nyquist_rate
        warning('✗ CRITICAL: Below Nyquist rate for fundamental frequency!\n');
        fprintf('   Severe aliasing will occur.\n');
        need_reconfig = true;
    elseif samples_per_cycle < 20
        fprintf('✗ VERY POOR: Only %.1f samples/cycle.\n', samples_per_cycle);
        fprintf('   Sawtooth shape will be completely lost.\n');
        fprintf('   Signal will look like a triangle or sinusoid.\n');
        need_reconfig = true;
    elseif samples_per_cycle < 50
        fprintf('⚠ POOR QUALITY: %.1f samples/cycle.\n', samples_per_cycle);
        fprintf('   Sawtooth will appear very blocky and distorted.\n');
        fprintf('   High-frequency harmonics will be lost.\n');
        
        user_choice = input('\nContinue with current sampling rate? (y/n): ', 's');
        if ~strcmpi(user_choice, 'y')
            need_reconfig = true;
        end
    elseif samples_per_cycle < 100
        fprintf('✓ ACCEPTABLE: %.1f samples/cycle.\n', samples_per_cycle);
        fprintf('   Sawtooth shape visible but somewhat blocky.\n');
        fprintf('   Consider increasing for smoother appearance.\n');
        
        user_choice = input('\nContinue with current sampling rate? (y/n): ', 's');
        if ~strcmpi(user_choice, 'y')
            need_reconfig = true;
        end
    else
        fprintf('✓✓ Good sampling frequency (%.1f samples/cycle).\n', samples_per_cycle);
    end
    
    % Reconfigure if needed
    if need_reconfig
        fprintf('\n--- RECONFIGURE SAMPLING FREQUENCY ---\n');
        fprintf('⚠ NOTE: Sawtooth waves contain many high-frequency harmonics!\n');
        fprintf('   They require MUCH higher sampling rates than sinusoids.\n\n');
        fprintf('Absolute minimum: %.2f Hz (Nyquist for fundamental)\n', nyquist_rate);
        fprintf('Minimum acceptable: %.2f Hz (20 samples/cycle)\n', frequency * 20);
        fprintf('Recommended minimum: %.2f Hz (50 samples/cycle)\n', recommended_min);
        fprintf('Good quality: %.2f Hz (100 samples/cycle)\n', recommended_good);
        fprintf('Excellent quality: %.2f Hz (500 samples/cycle)\n\n', frequency * 500);
        
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
        
        % Warn if still low quality
        new_samples_per_cycle = F_s_new / frequency;
        if new_samples_per_cycle < 50
            fprintf('\n⚠ WARNING: %.1f samples/cycle is still low for sawtooth.\n', new_samples_per_cycle);
            fprintf('   Signal quality will be limited.\n');
        end
        
        % Recalculate time vector
        T_s_new = 1 / F_s_new;
        t_new = t_start:T_s_new:t_end;
        
        fprintf('\n✓ Sampling frequency updated!\n');
        fprintf('New samples per cycle: %.2f\n', new_samples_per_cycle);
        fprintf('New number of samples: %d\n\n', length(t_new));
    else
        t_new = t;
        F_s_new = F_s;
    end
    
    % Generate sawtooth wave
    x_t = amplitude * sawtooth(2 * pi * frequency * t_new + phase_rad) + dc_offset;
    
    % Plot the signal
    figure;
    plot(t_new, x_t, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Sawtooth Wave: A=%g, f=%g Hz, \\phi=%g°, DC=%g', ...
                  amplitude, frequency, phase, dc_offset));
    grid on;
    
    % Add zero line for reference
    hold on;
    yline(dc_offset, 'r--', 'LineWidth', 1, 'Label', 'DC Offset');
    hold off;
    
    % Display signal properties
    fprintf('\n--- Sawtooth Wave Properties ---\n');
    fprintf('Amplitude: %.2f\n', amplitude);
    fprintf('Frequency: %.2f Hz\n', frequency);
    fprintf('Period: %.4f s\n', 1/frequency);
    fprintf('Phase Shift: %.2f degrees (%.4f radians)\n', phase, phase_rad);
    fprintf('DC Offset: %.2f\n', dc_offset);
    fprintf('Peak-to-Peak: %.2f\n', 2*amplitude);
    fprintf('Actual Sampling Frequency: %.2f Hz\n', F_s_new);
    fprintf('Actual Samples per Cycle: %.2f\n', F_s_new / frequency);
    
    % Display harmonic information
    fprintf('\n--- Harmonic Content ---\n');
    fprintf('A sawtooth wave contains infinite harmonics at:\n');
    fprintf('  f, 2f, 3f, 4f, ...\n');
    fprintf('With current sampling, harmonics up to %.0f Hz can be represented.\n', F_s_new/2);
    fprintf('This includes approximately the first %.0f harmonics.\n', floor((F_s_new/2)/frequency));
end