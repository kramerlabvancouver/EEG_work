%
%   Example of plotting sampled data in real time.
%

% Step 1: Setup library and choose connection type ( 'usb', 'bluetooth', 'network' or 'wifi' ).
library = TMSi.Library('usb');

% Step 2: Find device to connect to. Keep on trying every second.
while numel(library.devices) == 0
    library.refreshDevices()
    pause(1);
end

try
    % Step 3: Get first device an retrieve information about device.
    device = library.getFirstDevice();

    % Step 4: Create a sampler with which we are going to retrieve samples.
    sampler = device.createSampler();

    try
        % Step 5: Set settings for sampler.
        % sampler.setSampleRate(2048);
        % sampler.setReferenceCalculation(true);

        % Step 6: Create a RealTimePlot.
        plot = TMSi.RealTimePlot('RealTimePlot Example', sampler.sample_rate, device.channels);
        
        plot.setWindowSize(5);   

        plot.show();
        
        % Step 7: Connect to device through the sampler.
        sampler.connect();

        % Step 8: Start sampling.
        sampler.start();

        % Step 9: Sample as long as plot is visible. 
				%   Can be closed with 'q' or window close cross.
		        %   All ranges can be set by 'r', a dialog allows to put in a range.
				%   Press 'a' for autoscale.
        while plot.is_visible
            samples = sampler.sample();
            
            % Step 10: Append samples to plot.
            plot.append(samples);
            plot.draw();
            
        end
        
    catch matlabException
        warning(sprintf('Error while trying to sample.\n\tIdentifier: %s\n\tMessage: %s\n', matlabException.identifier, matlabException.message));
    end

    % Step 11: Stop sampler.
    sampler.stop();

    % Step 12: Disconnect with device.
    sampler.disconnect();

catch matlabException
    warning(sprintf('Error while trying to create device/sampler.\n\tIdentifier: %s\n\tMessage: %s\n', matlabException.identifier, matlabException.message));
end

% Step 13: Cleanup library.
library.destroy();