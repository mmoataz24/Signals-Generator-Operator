function plot_all_random_signals(signals)
% PLOT_ALL_RANDOM_SIGNALS - Plot all generated random signals
    
    num_signals = length(signals);
    
    % Determine subplot layout
    if num_signals <= 4
        rows = num_signals;
        cols = 1;
    elseif num_signals <= 6
        rows = 3;
        cols = 2;
    elseif num_signals <= 9
        rows = 3;
        cols = 3;
    else
        rows = 4;
        cols = ceil(num_signals / 4);
    end
    
    % Create figure with subplots
    figure('Name', 'Random Signals Overview', 'NumberTitle', 'off');
    set(gcf, 'Position', [100, 100, 1200, 800]);
    
    % Color map for different signals
    colors = ['r', 'g', 'b', 'c', 'm', 'k', 'r', 'g', 'b', 'c', 'm', 'k'];
    
    % Plot each signal
    for i = 1:num_signals
        subplot(rows, cols, i);
        plot(signals{i}.time, signals{i}.data, colors(mod(i-1, 12)+1), 'LineWidth', 1.5);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(sprintf('Signal %d: %s', i, signals{i}.type_name));
        grid on;
    end
    
    % Add overall title
    sgtitle(sprintf('Generated %d Random Signals', num_signals), 'FontSize', 14, 'FontWeight', 'bold');
    
    % Create figure with all signals overlapped
    figure('Name', 'All Random Signals Overlapped', 'NumberTitle', 'off');
    hold on;
    for i = 1:num_signals
        plot(signals{i}.time, signals{i}.data, 'LineWidth', 1.5, ...
             'DisplayName', sprintf('Signal %d: %s', i, signals{i}.type_name));
    end
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('All %d Random Signals Overlapped', num_signals));
    legend('Location', 'best');
    grid on;
    hold off;
end