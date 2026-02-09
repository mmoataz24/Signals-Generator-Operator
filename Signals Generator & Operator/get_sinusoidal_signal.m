function type = get_sinusoidal_signal()
    menu_text = sprintf(['Choose sinusoidal type:\n' ...
                         '1. Sine wave\n' ...
                         '2. Cosine wave\n' ...
                         '\nEnter your choice (1-2): ']);
    valid_choices = [1, 2];
    
    while true
        type = input(menu_text);
        if isnumeric(type) && isscalar(type) && ismember(type, valid_choices)
            break;
        else
            fprintf('Invalid choice! Please enter 1 for sine or 2 for cosine.\n\n');
        end
    end
end