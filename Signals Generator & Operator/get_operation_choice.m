function choice = get_operation_choice()
% GET_OPERATION_CHOICE - Display menu and get user's operation selection
%
% Syntax: choice = get_operation_choice()
%
% Outputs:
%   choice - Integer from 0 to 7 (0 means no operation)
%
% Operation Types:
%   0 - No Operation (Exit)
%   1 - Amplitude Scaling
%   2 - Time Reversal
%   3 - Time Shift
%   4 - Time Expansion
%   5 - Time Compression
%   6 - Add Random Noise
%   7 - Smoothing (Moving Average)

    % Operation names for reference
    operation_names = {
        'No Operation (Exit)', ...
        'Amplitude Scaling', ...
        'Time Reversal', ...
        'Time Shift', ...
        'Time Expansion', ...
        'Time Compression', ...
        'Add Random Noise', ...
        'Smoothing (Moving Average)'
    };
    
    % Valid choices
    valid_choices = 0:7;
    
    % Display menu
    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('                    SELECT SIGNAL OPERATION\n');
    fprintf('=========================================================================\n');
    fprintf('  0. No Operation (Exit to finish)\n');
    fprintf('  1. Amplitude Scaling\n');
    fprintf('  2. Time Reversal\n');
    fprintf('  3. Time Shift\n');
    fprintf('  4. Time Expansion\n');
    fprintf('  5. Time Compression\n');
    fprintf('  6. Add Random Noise (SNR-based)\n');
    fprintf('  7. Smoothing (Moving Average Filter)\n');
    fprintf('=========================================================================\n');
    
    % Get user input with validation
    while true
        choice = input('Enter your choice (0-7): ');
        
        % Validate input
        if isnumeric(choice) && isscalar(choice) && ismember(choice, valid_choices)
            % Valid choice
            fprintf('\n✓ You selected: %s\n', operation_names{choice + 1});
            break;
        else
            % Invalid choice
            fprintf('✗ Invalid choice! Please enter a number between 0 and 7.\n\n');
        end
    end
end