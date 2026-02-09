function plot_combined_signal(segments, x_combined, t_combined, breakpoints)
% PLOT_COMBINED_SIGNAL - Plot the combined signal with segment boundaries
%
% Syntax: plot_combined_signal(segments, x_combined, t_combined, breakpoints)

    num_segments = length(segments);
    
    % Color map for different segments
    colors = [0 0.4470 0.7410;    % Blue
              0.8500 0.3250 0.0980; % Orange
              0.9290 0.6940 0.1250; % Yellow
              0.4940 0.1840 0.5560; % Purple
              0.4660 0.6740 0.1880; % Green
              0.3010 0.7450 0.9330; % Cyan
              0.6350 0.0780 0.1840; % Red
              0 0.5 0;              % Dark Green
              0.5 0 0.5;            % Dark Purple
              1 0.4 0.6];           % Pink
    
    % Figure 1: Individual segments
    figure('Name', 'Combined Signal - Individual Segments', 'NumberTitle', 'off');
    set(gcf, 'Position', [100, 100, 1200, 800]);
    
    for i = 1:num_segments
        subplot(num_segments, 1, i);
        plot(segments{i}.time, segments{i}.signal, 'LineWidth', 2, ...
             'Color', colors(mod(i-1, 10)+1, :));
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(sprintf('Segment %d: [%.4f, %.4f] s', i, ...
                     segments{i}.start, segments{i}.end));
        grid on;
        
        % Add vertical lines at breakpoints
        hold on;
        xline(segments{i}.start, 'k--', 'LineWidth', 1.5, 'Alpha', 0.7);
        xline(segments{i}.end, 'k--', 'LineWidth', 1.5, 'Alpha', 0.7);
        hold off;
    end
    
    sgtitle('Individual Signal Segments', 'FontSize', 14, 'FontWeight', 'bold');
    
    % Figure 2: Combined signal with color-coded segments
    figure('Name', 'Combined Signal - Complete View', 'NumberTitle', 'off');
    set(gcf, 'Position', [150, 150, 1400, 600]);
    
    hold on;
    for i = 1:num_segments
        % Find indices for this segment
        idx = (t_combined >= segments{i}.start) & (t_combined <= segments{i}.end);
        plot(t_combined(idx), x_combined(idx), 'LineWidth', 2.5, ...
             'Color', colors(mod(i-1, 10)+1, :), ...
             'DisplayName', sprintf('Segment %d', i));
    end
    
    % Add vertical lines at breakpoints
    for i = 2:length(breakpoints)-1
        xline(breakpoints(i), 'k--', 'LineWidth', 2, 'Alpha', 0.7, ...
              'Label', sprintf('BP%d', i-1), 'LabelOrientation', 'horizontal');
    end
    
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Amplitude', 'FontSize', 12);
    title('Combined Signal with Segment Boundaries', 'FontSize', 14, 'FontWeight', 'bold');
    legend('Location', 'best');
    grid on;
    hold off;
    
    % Figure 3: Combined signal (single color)
    figure('Name', 'Combined Signal - Unified View', 'NumberTitle', 'off');
    plot(t_combined, x_combined, 'b-', 'LineWidth', 2);
    hold on;
    
    % Mark breakpoints
    for i = 2:length(breakpoints)-1
        xline(breakpoints(i), 'r--', 'LineWidth', 1.5, 'Alpha', 0.5);
    end
    
    % Mark breakpoint values on the signal
    for i = 2:length(breakpoints)-1
        idx = find(abs(t_combined - breakpoints(i)) < 1e-6, 1);
        if ~isempty(idx)
            plot(t_combined(idx), x_combined(idx), 'ro', 'MarkerSize', 10, ...
                 'MarkerFaceColor', 'r');
        end
    end
    
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Amplitude', 'FontSize', 12);
    title('Complete Combined Signal', 'FontSize', 14, 'FontWeight', 'bold');
    grid on;
    hold off;
end