%
%   Example of impedance measurement.
%   Only available in REFA and REFA EXTENDED devices. 
%   Other TMSi devices have no impedance mode.
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
        % Step 5: Set settings for sampler.
        sampler.setImpedanceMode(true);

        % Step 6: Connect to device through the sampler.
        sampler.connect();
        fprintf(' = Sampler connected.\n');

        % Step 7: Start imepdance mode sampling.
        sampler.start(50);  %value is kOhm used to control impedance indicators on the device. Valid values are: 2, 5, 10, 20, 50, 100, 200
        fprintf(' = Impedance mode sampling started.\n');

        % Step 8: Sample 50 times.
        for i=1:50
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