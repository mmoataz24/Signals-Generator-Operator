function [x_final, t_final, operation_history] = apply_operations(x_t, t)
% APPLY_OPERATIONS - Apply multiple operations to a signal
%
% Syntax: [x_final, t_final, operation_history] = apply_operations(x_t, t)
%
% Inputs:
%   x_t - Original signal
%   t - Time vector
%
% Outputs:
%   x_final - Final processed signal
%   t_final - Final time vector
%   operation_history - Cell array containing all operations performed

    % Initialize
    x_current = x_t;
    t_current = t;
    operation_history = {};
    operation_count = 0;
    
    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('                    SIGNAL OPERATIONS MODULE\n');
    fprintf('=========================================================================\n');
    
    % Ask if user wants to perform operations
    fprintf('\nWould you like to perform operations on this signal?\n');
    perform_ops = input('Enter 1 for Yes, 0 for No: ');
    
    while ~isnumeric(perform_ops) || ~isscalar(perform_ops) || ...
          (perform_ops ~= 0 && perform_ops ~= 1)
        fprintf('✗ Invalid input! Please enter 0 or 1.\n');
        perform_ops = input('Enter 1 for Yes, 0 for No: ');
    end
    
    if perform_ops == 0
        fprintf('\nNo operations selected. Using original signal.\n');
        x_final = x_current;
        t_final = t_current;
        return;
    end
    
    % Loop for multiple operations
    while true
        % Get operation choice
        choice = get_operation_choice();
        
        % Exit if user selects 0
        if choice == 0
            fprintf('\n✓ Exiting operations module.\n');
            break;
        end
        
        % Apply selected operation
        fprintf('\n📊 Applying operation...\n');
        
        try
            switch choice
                case 1
                    [x_current, t_current, params] = amplitude_scaling(x_current, t_current);
                case 2
                    [x_current, t_current, params] = time_reversal(x_current, t_current);
                case 3
                    [x_current, t_current, params] = time_shift(x_current, t_current);
                case 4
                    [x_current, t_current, params] = time_expansion(x_current, t_current);
                case 5
                    [x_current, t_current, params] = time_compression(x_current, t_current);
                case 6
                    [x_current, t_current, params] = add_noise(x_current, t_current);
                case 7
                    [x_current, t_current, params] = smoothing(x_current, t_current);
            end
            
            % Store operation in history
            operation_count = operation_count + 1;
            operation_history{operation_count}.number = operation_count;
            operation_history{operation_count}.operation = params.operation;
            operation_history{operation_count}.params = params;
            operation_history{operation_count}.signal = x_current;
            operation_history{operation_count}.time = t_current;
            
            fprintf('\n✅ Operation %d completed successfully!\n', operation_count);
            
        catch ME
            fprintf('\n✗ Error during operation: %s\n', ME.message);
            fprintf('Skipping this operation and continuing...\n');
        end
        
        % Ask if user wants another operation
        fprintf('\n─────────────────────────────────────────────────────────────────────────\n');
        fprintf('Would you like to perform another operation?\n');
        continue_ops = input('Enter 1 for Yes, 0 for No: ');
        
        while ~isnumeric(continue_ops) || ~isscalar(continue_ops) || ...
              (continue_ops ~= 0 && continue_ops ~= 1)
            fprintf('✗ Invalid input! Please enter 0 or 1.\n');
            continue_ops = input('Enter 1 for Yes, 0 for No: ');
        end
        
        if continue_ops == 0
            fprintf('\n✓ Finished applying operations.\n');
            break;
        end
    end
    
    % Set final signal
    x_final = x_current;
    t_final = t_current;
    
    % Display operations summary
    if operation_count > 0
        display_operations_summary(x_t, t, x_final, t_final, operation_history);
    end
    
    fprintf('\n=========================================================================\n');
    fprintf('✅ All operations completed! Total operations: %d\n', operation_count);
    fprintf('=========================================================================\n\n');
end