%
%	This example shows a practical application with the library.
%		The code shows a spectrogram of the signal. This example shows where and how to put in online processing.
%

function start()

subset=[1:16, 73, 74];
% Open device from USB
    library = TMSi.Library('usb');
    device = library.getFirstDevice();
    sampler = device.createSampler();

    % Display
    realTimePlot = TMSi.RealTimePlot('Real Time Plot', sampler.sample_rate, device.channels(subset));
    realTimePlot.show();
    
    % Connect and start sampler
    sampler.connect();
    sampler.start();

    % Spectogram settings
    window_size = 30;
    window_sec = 1;
    num_blocks = window_size / window_sec;
    window_samples = floor(window_sec * sampler.sample_rate);
    sample_buffer = zeros(device.num_channels, 0);

        
    % Figure for spectrum
    fig_handle = figure('Name', 'Spectral Density');
    plot_handle = imagesc('CData', 0);
    xlim([0 window_size-1]);
    ylim([0 sampler.sample_rate / 8]); %only show frequencies up to 1/4th of the sampling rate.
    colorbar();
    
    % Pre-allocate
    spectrogram = zeros(floor(window_samples / 2 + 1), num_blocks);
    at_block = 0;
    
    while realTimePlot.is_visible
        samples = sampler.sample;

        % Append samples to a buffer, so we have always have a minimum of window_samples.
        sample_buffer(:, size(sample_buffer, 2) + size(samples, 2)) = 0;
        sample_buffer(:, end-size(samples, 2) + 1:end) = samples;
        
        % As long as we have enough samples calculate FFT and plot it.
        
        while size(sample_buffer, 2) >= window_samples
            
            [x, y] = calcAmplitudeSignal( ...
                sampler.sample_rate, ...
                sample_buffer(1, 1:window_samples) ...
            );
            
            spectrogram(:, mod(at_block, num_blocks) + 1) = y;
            
            set(plot_handle, 'XData', 0:window_sec:window_size-1, 'YData', x, 'CData', spectrogram);
            caxis([0 5])

            drawnow;
            
            at_block = at_block + 1;
            sample_buffer = sample_buffer(:, window_samples + 1:end);
            
        end
        
        realTimePlot.append(samples(subset,:));
        realTimePlot.draw();
        
    end

    % Cleanup
    sampler.stop();
    sampler.disconnect();
    library.destroy();
end

function [x, y] = calcAmplitudeSignal(sample_rate, samples)
    % Calculate FFT;
    
    length = size(samples, 2);
 
    fft_y = fft(samples);
   
    P2 = abs(fft_y / length);
    P1 = P2(1:length / 2 + 1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = sample_rate * (0:(length / 2)) / length;
    
    x = f;
    y = P1;
end