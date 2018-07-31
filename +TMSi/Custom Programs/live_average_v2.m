%
%	This example shows a practical application with the library.
%		The code shows a spectrogram of the signal. This example shows where and how to put in online processing.
%

function live_average_v2()

% subset of channels for reading from. Will likely choose Cz nonly. 
subset=[1:32, 73, 74];
average_subset=1;
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
    %Number of stim with a safety factor of 2.25. For preallocating in avg
    %sum array. 
    %num_of_stim=45;
   % event_location=sampler.sample_rate; %want to check it after 1 second, and have the rest of the buffer (2 seconds) display
    
    %a flag to tell when a falling edge has occured on the digi channel. 
    event_happening=0;
    
    %how many data points to graph 
    window_samples = floor(window_sec * sampler.sample_rate);
    %initialize sample buffer to all channels for 12000 samples (3
    %seconds)
    sample_buffer = zeros(device.num_channels, window_samples);
    sample_buffer(73, 1:sampler.sample_rate)=255;
        
    % Figure for Average   
    
    count      = 0;

    %initialize timelock cell-array. Each cell will hold the average in one
    %condition
    avgsum= zeros(device.num_channels, window_samples);
    avgnum=0;
    average= [];
    %a variable to index the sample_buffer once an event has occured. 
    index=sampler.sample_rate+1;
    plot_flag=0;
    
    %One time allocation of time (eg 0:120000)
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
        
        %Initialize a new part of the buffer (as large as samples)
        %Overwrite the the previous part of the buffer.....(to progress it)
      %      sample_buffer(:, size(sample_buffer, 2) + size(samples, 2)) = 0;
        
         
          %Check if event happened in THIS sample-cycle. 
           if((samples(73,end)<255)&&event_happening==0)
                 event_happening=1;
                           
           end
           
           %Populate array to check if sample_buffer has been completely
           %filled. Dim: 1x74. 
            buffer_full=all(sample_buffer(:,1:end),2);
           
        if(event_happening==0)
               %Continue overwriting the first 4000 samples of the buffer.  No
                %need to flip the samples (newest is on the right)
                
                %Circshift writes rows backward by the size of samples. Old
                %values get sent to back of sample buffer, where they will
                %be overwritten later (?)
                sample_buffer = circshift(sample_buffer,-size(samples,2),2);
                sample_buffer(:,end-size(samples,2)+1:end)=zeros(device.num_channels, size(samples,2));  %clear rotated samples
                
                %Write new samples before time "0"
                sample_buffer(:, sampler.sample_rate-size(samples, 2) + 1:sampler.sample_rate) = samples;
            
            
            %if the entire sample_buffer is not (yet) full with samples and
            %event is happening
        elseif((buffer_full(73))~=1&&(event_happening==1)&&index<sampler.sample_rate*3)
                 %update sample buffer from the left side of sample_rate
                 %(time0)
                
            sample_buffer(:, index :index-1+size(samples,2)) = samples;
            
            %update index location
            index=index+size(samples,2); 
            
            %if index exceeds 12000 or the sample_buffer is full (use only DIGI channel for simplicity)!
        elseif((index>sampler.sample_rate*3)||(buffer_full(73))==1)
           
            index=sampler.sample_rate+1;             %reset index
            
            sample_buffer = sample_buffer(:, (end-window_samples+1):end);  %remove end of sample_buffer that is extra. 
           
            event_happening=0;                       %reset event_happening flag so another event can be read into
            %sample_buffer
            
            plot_flag=1;                             %Set plot flag
            
        else
            disp('Error: main cases not met in BCI loop');
        end
     
                   
      
             % When event occurs (digi<255), calculate average ERP and plot it 
             if(plot_flag==1)
                    
                %reset plot_flag 
                 plot_flag=0;
                 
                 
                 
                 avgnum =  avgnum +1;
                 avgsum= avgsum + sample_buffer(:, 1:end);
                 count=0;
                            
             %recalculate average
                average= avgsum ./ avgnum ; 
                
                figure(Avg_fig_handle)
                plot(time, average(average_subset, :));
               % drawnow 
               
               %Reset of the rest of sample_buffer
               sample_buffer(:,sampler.sample_rate+1:end)=zeros(74,sampler.sample_rate*2);
                
                
             end
            
             %Get rid of previous buffer samples
            
      %    sample_buffer = sample_buffer(:, (end-window_samples+1):end);
            RealTimePlot.show();
            RealTimePlot.append(samples(subset, :));
            RealTimePlot.draw();
     
        
    end    %end of while loop
    

    % Cleanup
    sampler.stop();
    sampler.disconnect();
    library.destroy();
    end
