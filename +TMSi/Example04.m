%
%   Example of plotting and saving to Poly5 file at the same time.
%

% Step 1: Setup library and choose connection type ( 'usb', 'bluetooth', 'network' or 'wifi' ).
library = TMSi.Library('usb');

% Step 2: Find device to connect to. Keep on trying every second.
while numel(library.devices) == 0
    library.refreshDevices();
    pause(1);
end

try
    % Step 3: Get first device an retrieve information about device.
    device = library.getFirstDevice();

    % Step 4: Create a sampler with which we are going to retrieve samples.
    sampler = device.createSampler();

    try
        % Step 5: Set settings for sampler.
         sampler.setSampleRate(2048);
         sampler.setReferenceCalculation(true);

        % Step 6: Create a RealTimePlot.
        realTimePlot = TMSi.RealTimePlot('RealTimePlot Example', sampler.sample_rate, device.channels);
        realTimePlot.setWindowSize(10);
        realTimePlot.show();

        % Step 7: Create a Poly5 file to save samples to.
        poly5 = TMSi.Poly5('example04.Poly5', 'Poly5 Example', sampler.sample_rate, device.channels);

        % Step 8: Connect to device through the sampler.
        sampler.connect();

        % Step 9: Start sampling.
        sampler.start();
        
        % Step 10: Sample as long as plot is visible. 
        %   Can be closed with 'q' or cross.
        %   All ranges can be set by 'r', a dialog allows to put in a range.
        %   Press 'a' for autoscale.
        
        while realTimePlot.is_visible
            samples = sampler.sample();

            % Step 11: Append samples to plot.
            realTimePlot.append(samples);

            % Step 12: Append and draw samples to poly5 file.
            poly5.append(samples);
            realTimePlot.draw();
        end

        % Step 13: Close file.
        poly5.close();
        
    catch matlabException
        warning(sprintf('Error while trying to sample.\n\tIdentifier: %s\n\tMessage: %s\n', matlabException.identifier, matlabException.message));
    end

    % Step 14: Stop sampler.
    sampler.stop();

    % Step 15: Disconnect with device.
    sampler.disconnect();

catch matlabException
    warning(sprintf('Error while trying to create device/sampler.\n\tIdentifier: %s\n\tMessage: %s\n', matlabException.identifier, matlabException.message));
end

% Step 16: Cleanup library.
library.destroy();