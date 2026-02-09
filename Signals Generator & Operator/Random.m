function signals = Random(t, num_signals)
% RANDOM - Generate multiple random signals with random parameters
%
% Syntax: signals = Random(t, num_signals)
%
% Inputs:
%   t - Time vector
%   num_signals - Number of random signals to generate
%
% Outputs:
%   signals - Cell array containing generated signals and their info

    % Initialize cell array to store signals
    signals = cell(num_signals, 1);
    
    % Signal type names
    signal_names = {
        'DC Signal', ...
        'Ramp Signal', ...
        'Exponential Signal', ...
        'Sinusoidal Signal', ...
        'Gaussian Pulse', ...
        'Sawtooth Wave', ...
        'Polynomial Signal'
    };
    
    fprintf('\n=========================================================================\n');
    fprintf('                 GENERATING %d RANDOM SIGNALS\n', num_signals);
    fprintf('=========================================================================\n\n');
    
    % Generate each random signal
    for i = 1:num_signals
        fprintf('--- Generating Signal %d/%d ---\n', i, num_signals);
        
        % Randomly select signal type (1-7)
        signal_type = randi([1, 7]);
        fprintf('Signal Type: %s\n', signal_names{signal_type});
        
        % Generate signal based on type
        switch signal_type
            case 1
                [x_t, params] = generate_random_DC(t);
            case 2
                [x_t, params] = generate_random_Ramp(t);
            case 3
                [x_t, params] = generate_random_Exponential(t);
            case 4
                [x_t, params] = generate_random_Sinusoidal(t);
            case 5
                [x_t, params] = generate_random_Gaussian(t);
            case 6
                [x_t, params] = generate_random_Sawtooth(t);
            case 7
                [x_t, params] = generate_random_Polynomial(t);
        end
        
        % Store signal data
        signals{i}.type = signal_type;
        signals{i}.type_name = signal_names{signal_type};
        signals{i}.data = x_t;
        signals{i}.params = params;
        signals{i}.time = t;
        
        fprintf('\n');
    end
    
    % Plot all signals together
    plot_all_random_signals(signals);
    
    % Display summary
    display_random_signals_summary(signals);
    
    fprintf('=========================================================================\n');
    fprintf('✅ Successfully generated %d random signals!\n', num_signals);
    fprintf('=========================================================================\n\n');
end