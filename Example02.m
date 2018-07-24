%
%   Basic example with safe closing
%

% Step 1: Setup library and choose connection type ( 'usb', 'bluetooth', 'network' or 'wifi' ).
library = TMSi.Library('usb');

fprintf(' = Setup library.\n');

% Step 2: Find device to connect to. Keep on trying every second.
while numel(library.devices) == 0
    fprintf(' = Refreshing devices.\n');
    library.refreshDevices();
    pause(1);
end

try
    % Step 3: Get first device an retrieve information about device.
    device = library.getFirstDevice();
    fprintf(' = First device selected.\n');

    % Step 4: Create a sampler with which we are going to retrieve samples.
    sampler = device.createSampler();
    fprintf(' = Sampler created.\n');

    try
        % Step 5: Set settings for sampler. [OPTIONAL]
        % sampler.setSampleRate(2048);
        % sampler.setReferenceCalculation(true);

        % Step 6: Connect to device through the sampler.
        sampler.connect();
        fprintf(' = Sampler connected.\n');

        % Step 7: Start sampling.
        sampler.start();
        fprintf(' = Sampling started.\n');

        % Step 8: Sample 10 times.
        for i=1:10
            samples = sampler.sample();
            fprintf(' = Sampled %d samples.\n', size(samples, 2));
           
        end
    catch matlabException
        warning(sprintf('Error while trying to sample.\n\tIdentifier: %s\n\tMessage: %s\n', matlabException.identifier, matlabException.message));
    end

    % Step 9: Stop sampler.
    sampler.stop();
    fprintf(' = Sampling stopped.\n');

    % Step 10: Disconnect with device.
    sampler.disconnect();
    fprintf(' = Sampler disconnected.\n');

catch matlabException
    warning(sprintf('Error while trying to create device/sampler.\n\tIdentifier: %s\n\tMessage: %s\n', matlabException.identifier, matlabException.message));
end

% Step 11: Cleanup library.
library.destroy();
fprintf(' = Destroy library.\n');