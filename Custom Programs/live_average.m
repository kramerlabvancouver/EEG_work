%
%	This example shows a practical application with the library.
%		The code shows a spectrogram of the signal. This example shows where and how to put in online processing.
%

function live_average()

% subset of channels for reading from. Will likely choose Cz nonly. 
subset=[1:16, 73, 74];
average_subset=16;
% Open device from USB
    library = TMSi.Library('usb');
    device = library.getFirstDevice();
    sampler = device.createSampler();

    % Display
    RealTimePlot = TMSi.RealTimePlot('Real Time Plot', sampler.sample_rate, device.channels(subset));
   % RealTimePlot.window_size=3;_ 
    RealTimePlot.show();
    
    %Live digital Signal processing (DSP!)
    %Low pass FIR filter, attenuating signals greater than 50 hz
    %LPF=dsp.LowpassFilter('SampleRate', 4096, 'PassbandFrequency', 0.5, 'StopbandFrequency', 50); 
    
    % Connect and start sampler
    sampler.connect();
    sampler.start();

    % Average settings
    window_size = 3;
    window_sec = 3;
    num_blocks = window_size / window_sec;
    event_location=sampler.sample_rate; %want to check it after 1 second, and have the rest of the buffer (2 seconds) display
    
    %how many data points to graph 
    window_samples = floor(window_sec * sampler.sample_rate);
    sample_buffer = zeros(device.num_channels, window_samples);
    sample_buffer(73, :)=255;
        
    % Figure for Average
    %
    %plot_handle = imagesc('CData', 0);
   % 
   % ylim([0 sampler.sample_rate / 8]); %only show frequencies up to 1/4th of the sampling rate.
   % figure;
    
    % Pre-allocate
    %average_ERP = zeros(floor(window_samples / 2 + 1), num_blocks);
   % at_block = 0;
    
    
    count      = 0;

    %initialize timelock cell-array. Each cell will hold the average in one
    %condition
    avgsum=[];
    avgnum=[];
    average=[];
    time=0+(0:(window_samples-1))/sampler.sample_rate-1;
    
    Avg_fig_handle = figure('Name', 'Average CZ ERP'); %figure for the average 
    %plot_handle=plot(time,average);
    xlim([-1 window_size-1]);
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%
    %   Main online loop where incoming data is handled. 
    %%%%%%%%%%%%%%%%%%%%%%%    
    
    while RealTimePlot.is_visible
        
          
        samples = sampler.sample();
        
       
        count=count+1;
        
        %continuously update sample_buffer
        % Append samples to a buffer, so we have always have a minimum of window_samples.
        %We want our sample buffer to hold 12000 samples!
        %want to check our sample every 1 second... For an event. 
        
        %Initialize a new part of the buffer
        sample_buffer(:, size(sample_buffer, 2) + size(samples, 2)) = 0;
        %Fill the new part of the buffer. 
        %SPECIFY HERE IF YOU ONLY WANT TO PLOT THE AVERAGE OF A SINGLE
        %CHANNEL
        sample_buffer(:, end-size(samples, 2) + 1:end) = samples;
        
       
        
        % As long as we have enough samples calculate FFT and plot it.
         % while size(sample_buffer, 2) >= window_samples
           event_check= sample_buffer(73, event_location:event_location+event_location/2-1);
             % When event occurs (digi<255), calculate average ERP and plot it 
             if(all(event_check<255))
            
                  %initialize average;
                if(isempty(average))
                    avgsum=sample_buffer(:, (end-window_samples+1):end);
                    avgnum=1;
                  
                else
                    avgnum =  avgnum +1;
                   avgsum= avgsum + sample_buffer(:, (end-window_samples+1):end);
                    count=0;
                end
                
             
             average= avgsum ./ avgnum ; 
          %   filter_average=step(LPF,average(average_subset,:));
                figure(Avg_fig_handle)
                plot(time, average(average_subset, :));
               % drawnow 
                
                
             end
            
             %Get rid of previous buffer samples
          sample_buffer = sample_buffer(:, (end-window_samples+1):end);
            RealTimePlot.show();
            RealTimePlot.append(samples(subset, :));
            RealTimePlot.draw();
          
       %Draw figure
       
       
        
    end    
    

    % Cleanup
    sampler.stop();
    sampler.disconnect();
    library.destroy();
    end
