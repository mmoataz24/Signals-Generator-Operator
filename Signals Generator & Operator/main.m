clc;
clear;
close all;  % Close any existing figures


% =========================================================================
% MAIN SIGNAL GENERATOR PROGRAM
% =========================================================================
% This program generates various types of signals based on user input
% and allows operations to be performed on them
% =========================================================================



% Display welcome banner
fprintf('\n');
fprintf('=========================================================================\n');
fprintf('                    SIGNAL GENERATOR PROGRAM\n');
fprintf('=========================================================================\n\n');

% -------------------------------------------------------------------------
% TIME CONFIGURATION
% -------------------------------------------------------------------------
fprintf('--- TIME CONFIGURATION ---\n');
t_start = input('Start Time (s) = ');
t_end = input('End Time (s) = ');

% Validate time inputs
while t_end <= t_start
    fprintf('✗ Error: End time must be greater than start time!\n');
    t_start = input('Start Time (s) = ');
    t_end = input('End Time (s) = ');
end

F_s = input('Sampling Frequency (Hz) = ');

% Validate sampling frequency
while F_s <= 0
    fprintf('✗ Error: Sampling frequency must be positive!\n');
    F_s = input('Sampling Frequency (Hz) = ');
end

% Calculate sampling parameters
T_s = 1 / F_s;
t = t_start:T_s:t_end;

% Display time configuration summary
fprintf('\n--- TIME CONFIGURATION SUMMARY ---\n');
fprintf('Duration: %.4f seconds\n', t_end - t_start);
fprintf('Sampling Period (Ts): %.6f seconds\n', T_s);
fprintf('Sampling Frequency (Fs): %.2f Hz\n', F_s);
fprintf('Number of Samples: %d\n', length(t));
fprintf('=========================================================================\n\n');

% -------------------------------------------------------------------------
% GENERATION MODE SELECTION
% -------------------------------------------------------------------------
mode = get_generation_mode();

% Check if user wants to combine signals
if mode == 1
    fprintf('\n');
    fprintf('Would you like to combine multiple signals at breakpoints?\n');
    combine_signals_flag = input('Enter 1 for Yes, 0 for No: ');
    
    while ~isnumeric(combine_signals_flag) || ~isscalar(combine_signals_flag) || ...
          (combine_signals_flag ~= 0 && combine_signals_flag ~= 1)
        fprintf('✗ Invalid input! Please enter 0 or 1.\n');
        combine_signals_flag = input('Enter 1 for Yes, 0 for No: ');
    end
else
    combine_signals_flag = 0;
end

% -------------------------------------------------------------------------
% SIGNAL GENERATION
% -------------------------------------------------------------------------
fprintf('\n=========================================================================\n');

try
    if mode == 1

      if combine_signals_flag == 1
            % =====================================================================
            % COMBINED SIGNALS GENERATION
            % =====================================================================
            [x_t, t] = combine_signals(t_start, t_end, F_s);
      else
        % =====================================================================
        % CUSTOM SIGNAL GENERATION
        % =====================================================================
        choice = get_signal_choice();
        
        fprintf('\n=========================================================================\n');
        
        switch choice
            case 1
                fprintf('📊 Generating DC Signal...\n\n');
                x_t = DC(t);
            case 2
                fprintf('📊 Generating Ramp Signal...\n\n');
                x_t = Ramp(t);
            case 3
                fprintf('📊 Generating Exponential Signal...\n\n');
                x_t = Exponential(t);
            case 4
                fprintf('📊 Generating Sinusoidal Signal...\n\n');
                [x_t, t, F_s] = Sinusoidal(t, F_s, t_start, t_end);
            case 5
                fprintf('📊 Generating Gaussian Pulse...\n\n');
                x_t = Gaussian_Pulse(t);
            case 6
                fprintf('📊 Generating Sawtooth Wave...\n\n');
                [x_t, t, F_s] = Sawtooth_Wave(t, F_s, t_start, t_end);
            case 7
                fprintf('📊 Generating Polynomial Signal...\n\n');
                x_t = Polynomial(t);
            otherwise
                error('Invalid signal choice!');
        end
      end
        
        fprintf('\n=========================================================================\n');
        fprintf('✅ Signal generation completed successfully!\n');
        fprintf('=========================================================================\n');
        
        % =====================================================================
        % APPLY OPERATIONS TO THE GENERATED SIGNAL
        % =====================================================================
        [x_final, t_final, operation_history] = apply_operations(x_t, t);
        
    else
        % =====================================================================
        % RANDOM SIGNALS GENERATION
        % =====================================================================
        num_signals = input('\nEnter the number of random signals to generate: ');
        
        % Validate number of signals
        while ~isnumeric(num_signals) || num_signals < 1 || num_signals ~= floor(num_signals)
            fprintf('✗ Error: Please enter a positive integer!\n');
            num_signals = input('Enter the number of random signals to generate: ');
        end
        
        % Generate random signals
        signals = Random(t, num_signals);
        
        fprintf('\n=========================================================================\n');
        fprintf('✅ Random signal generation completed successfully!\n');
        fprintf('=========================================================================\n');
        
        % Note: Operations are not applied to random signals in batch mode
        fprintf('\nℹ Note: Operations are only available for custom single signals.\n');
        fprintf('  To apply operations, please select mode 1 (Custom Signal).\n');
    end
    
    % Final success message
    fprintf('\n=========================================================================\n');
    fprintf('✅ PROGRAM COMPLETED SUCCESSFULLY!\n');
    fprintf('=========================================================================\n\n');
    
catch ME
    % Error handling
    fprintf('\n=========================================================================\n');
    fprintf('✗ Error occurred during execution:\n');
    fprintf('   %s\n', ME.message);
    fprintf('   Location: %s (line %d)\n', ME.stack(1).name, ME.stack(1).line);
    fprintf('=========================================================================\n\n');
    rethrow(ME);
end