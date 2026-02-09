function choice = get_signal_choice()
% GET_SIGNAL_CHOICE - Display menu and get user's signal selection
%
% Syntax: choice = get_signal_choice()
%
% Outputs:
%   choice - Integer from 1 to 7 representing the selected signal type
%
% Signal Types:
%   1 - DC Signal (Constant)
%   2 - Ramp Signal (Linear)
%   3 - Exponential Signal
%   4 - Sinusoidal Signal (Sine/Cosine)
%   5 - Gaussian Pulse
%   6 - Sawtooth Wave
%   7 - Polynomial Signal

    % Signal names for reference
    signal_names = {
        'DC Signal (Constant)', ...
        'Ramp Signal (Linear)', ...
        'Exponential Signal', ...
        'Sinusoidal Signal (Sine/Cosine)', ...
        'Gaussian Pulse', ...
        'Sawtooth Wave', ...
        'Polynomial Signal'
    };
    
    % Valid choices
    valid_choices = 1:7;
    
    % Display menu
    fprintf('=========================================================================\n');
    fprintf('                        SELECT SIGNAL TYPE\n');
    fprintf('=========================================================================\n');
    fprintf('  1. DC Signal (Constant)\n');
    fprintf('  2. Ramp Signal (Linear)\n');
    fprintf('  3. Exponential Signal\n');
    fprintf('  4. Sinusoidal Signal (Sine/Cosine)\n');
    fprintf('  5. Gaussian Pulse\n');
    fprintf('  6. Sawtooth Wave\n');
    fprintf('  7. Polynomial Signal\n');
    fprintf('=========================================================================\n');
    
    % Get user input with validation
    while true
        choice = input('Enter your choice (1-7): ');
        
        % Validate input
        if isnumeric(choice) && isscalar(choice) && ismember(choice, valid_choices)
            % Valid choice
            fprintf('\n✓ You selected: %s\n', signal_names{choice});
            break;
        else
            % Invalid choice
            fprintf('❌ Invalid choice! Please enter a number between 1 and 7.\n\n');
        end
    end
end