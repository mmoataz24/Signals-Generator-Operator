function mode = get_generation_mode()
% GET_GENERATION_MODE - Display menu and get user's generation mode selection
%
% Syntax: mode = get_generation_mode()
%
% Outputs:
%   mode - Integer: 1 for custom signal, 2 for random signals

    % Valid choices
    valid_choices = [1, 2];
    
    % Display menu
    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('                    SELECT GENERATION MODE\n');
    fprintf('=========================================================================\n');
    fprintf('  1. Generate Signal(s) (Single or Combined with Breakpoints)\n');
    fprintf('  2. Generate Multiple Random Signals\n');
    fprintf('=========================================================================\n');
    
    % Get user input with validation
    while true
        mode = input('Enter your choice (1-2): ');
        
        % Validate input
        if isnumeric(mode) && isscalar(mode) && ismember(mode, valid_choices)
            % Valid choice
            if mode == 1
                fprintf('\n✓ You selected: Generate Signal(s)\n');
            else
                fprintf('\n✓ You selected: Generate Multiple Random Signals\n');
            end
            break;
        else
            % Invalid choice
            fprintf('✗ Invalid choice! Please enter 1 or 2.\n\n');
        end
    end
end