function [x_noisy, t_new, params] = add_noise(x_t, t)
% ADD_NOISE - Add random noise to the signal based on SNR
%
% Syntax: [x_noisy, t_new, params] = add_noise(x_t, t)
%
% Inputs:
%   x_t - Original signal
%   t - Time vector
%
% Outputs:
%   x_noisy - Signal with added noise
%   t_new - Time vector (unchanged)
%   params - Structure containing operation parameters

    fprintf('\n--- ADD RANDOM NOISE ---\n');
    fprintf('SNR (Signal-to-Noise Ratio): Higher values = less noise\n');
    fprintf('Typical values: 10 dB (noisy), 20 dB (moderate), 30 dB (clean)\n');
    
    SNR_dB = input('Enter the desired SNR in dB: ');
    
    % Validate SNR
    while ~isnumeric(SNR_dB) || ~isscalar(SNR_dB)
        fprintf('✗ Invalid input! Please enter a numeric value.\n');
        SNR_dB = input('Enter the desired SNR in dB: ');
    end
    
    % Calculate signal power
    signal_power = mean(x_t.^2);
    
    % Calculate noise power from SNR
    % SNR (dB) = 10 * log10(signal_power / noise_power)
    SNR_linear = 10^(SNR_dB / 10);
    noise_power = signal_power / SNR_linear;
    
    % Generate white Gaussian noise
    noise = sqrt(noise_power) * randn(size(x_t));
    
    % Add noise to signal
    x_noisy = x_t + noise;
    t_new = t;
    
    % Calculate actual SNR
    actual_SNR_dB = 10 * log10(mean(x_t.^2) / mean(noise.^2));
    
    % Store parameters
    params.operation = 'Add Random Noise';
    params.SNR_dB = SNR_dB;
    params.actual_SNR_dB = actual_SNR_dB;
    params.noise_power = noise_power;
    
    % Plot comparison
    figure('Name', 'Add Random Noise', 'NumberTitle', 'off');
    
    subplot(3, 1, 1);
    plot(t, x_t, 'b-', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal');
    grid on;
    
    subplot(3, 1, 2);
    plot(t, noise, 'k-', 'LineWidth', 0.5);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Noise (Power = %.4f)', noise_power));
    grid on;
    
    subplot(3, 1, 3);
    plot(t_new, x_noisy, 'r-', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Noisy Signal (SNR = %.2f dB)', actual_SNR_dB));
    grid on;
    
    % Display operation info
    fprintf('\n--- Operation Results ---\n');
    fprintf('Target SNR: %.2f dB\n', SNR_dB);
    fprintf('Actual SNR: %.2f dB\n', actual_SNR_dB);
    fprintf('Signal Power: %.6f\n', signal_power);
    fprintf('Noise Power: %.6f\n', noise_power);
    fprintf('Original Signal - Mean: %.4f, Std: %.4f\n', mean(x_t), std(x_t));
    fprintf('Noisy Signal - Mean: %.4f, Std: %.4f\n', mean(x_noisy), std(x_noisy));
    fprintf('✅ Noise addition completed!\n');
end