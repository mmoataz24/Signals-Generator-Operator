function x_t = Polynomial(t)
    amplitude = input('The Amplitude = ');
    intercept = input('The Intercept = ');
    
    % Validate order
    order = input('The Order = ');
    while ~isnumeric(order) || order < 0 || order ~= floor(order)
        fprintf('✗ Error: Order must be a non-negative integer!\n');
        order = input('The Order = ');
    end
    
    % Display the polynomial formula
    fprintf('\nEnter coefficients for: x(t) = amplitude * (');
    for i = order:-1:0
        if i == order
            fprintf('a%d*t^%d', i, i);
        elseif i > 1
            fprintf(' + a%d*t^%d', i, i);
        elseif i == 1
            fprintf(' + a1*t');
        else  % i == 0
            fprintf(' + a0');
        end
    end
    fprintf(') + intercept\n\n');
    
    % Get coefficients
    coefficients = zeros(1, order + 1);
    for i = 1:(order + 1)
        power = order + 1 - i;
        if power == 0
            coefficients(i) = input(sprintf('Enter a%d (constant term): ', power));
        elseif power == 1
            coefficients(i) = input(sprintf('Enter a%d (coefficient for t): ', power));
        else
            coefficients(i) = input(sprintf('Enter a%d (coefficient for t^%d): ', power, power));
        end
    end
    
    % Calculate the polynomial signal
    x_t = amplitude * polyval(coefficients, t) + intercept;
    
    % Build dynamic title string (shortened for readability)
    if order <= 3
        % For low-order polynomials, show full formula
        titleStr = sprintf('Polynomial Signal (Order %d): x(t) = %g*(', order, amplitude);
        for i = 1:(order + 1)
            power = order + 1 - i;
            coeff = coefficients(i);
            
            if i == 1
                % First term
                if power == 0
                    titleStr = [titleStr, sprintf('%g', coeff)];
                elseif power == 1
                    titleStr = [titleStr, sprintf('%g*t', coeff)];
                else
                    titleStr = [titleStr, sprintf('%g*t^%d', coeff, power)];
                end
            else
                % Subsequent terms
                if power == 0
                    if coeff >= 0
                        titleStr = [titleStr, sprintf(' + %g', coeff)];
                    else
                        titleStr = [titleStr, sprintf(' - %g', abs(coeff))];
                    end
                elseif power == 1
                    if coeff >= 0
                        titleStr = [titleStr, sprintf(' + %g*t', coeff)];
                    else
                        titleStr = [titleStr, sprintf(' - %g*t', abs(coeff))];
                    end
                else
                    if coeff >= 0
                        titleStr = [titleStr, sprintf(' + %g*t^%d', coeff, power)];
                    else
                        titleStr = [titleStr, sprintf(' - %g*t^%d', abs(coeff), power)];
                    end
                end
            end
        end
        titleStr = [titleStr, sprintf(') + %g', intercept)];
    else
        % For high-order polynomials, use compact notation
        titleStr = sprintf('Polynomial Signal (Order %d): x(t) = %g*P_%d(t) + %g', ...
                          order, amplitude, order, intercept);
    end
    
    % Plot the signal
    figure;
    plot(t, x_t, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(titleStr);
    grid on;
    
    % Add zero line for reference
    hold on;
    yline(0, 'k--', 'LineWidth', 0.5, 'Alpha', 0.3);
    if intercept ~= 0
        yline(intercept, 'r--', 'LineWidth', 1, 'Label', 'Intercept');
    end
    hold off;
    
    % Display polynomial properties
    fprintf('\n--- Polynomial Signal Properties ---\n');
    fprintf('Order: %d\n', order);
    fprintf('Amplitude multiplier: %.2f\n', amplitude);
    fprintf('Intercept (DC offset): %.2f\n', intercept);
    fprintf('Coefficients (highest to lowest power):\n');
    for i = 1:(order + 1)
        power = order + 1 - i;
        if power == 0
            fprintf('  a%d (constant): %.4f\n', power, coefficients(i));
        elseif power == 1
            fprintf('  a%d (linear): %.4f\n', power, coefficients(i));
        else
            fprintf('  a%d (t^%d): %.4f\n', power, power, coefficients(i));
        end
    end
    fprintf('Range of x(t): [%.4f, %.4f]\n', min(x_t), max(x_t));
    fprintf('Mean value: %.4f\n', mean(x_t));
end