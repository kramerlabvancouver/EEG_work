%
%	Example of a very basic setup for measuring data.
%

% Step 1: Setup library.( 'usb', 'bluetooth', 'network' or 'wifi' )
library = TMSi.Library('usb');

% Step 2: Find device to connect to. Keep on trying every second.
while numel(library.devices) == 0
    library.refreshDevices();
    pause(1);
end

% Step 3: Get first device an retrieve information about device.
device = library.getFirstDevice();

% Step 4: Create a sampler with which we are going to retrieve samples.
sampler = device.createSampler();

% Step 5: Set settings for sampler.
%   This step is optional, you can set the SampleRate and/or
%   ReferenceCalculation. When you don't use this command, the maximum
%   SampleRate will be set. The ReferenceCalculation is set to 'true' by
%   default.

% sampler.setSampleRate(1024); %Hz
% sampler.setReferenceCalculation(true);

% Step 6: Connect to device through the sampler.
sampler.connect();

% Step 7: Start sampling.
sampler.start();

% Step 8: Sample 10 times.
for i=1:10
    samples = sampler.sample();
end

% Step 9: Stop sampler.
sampler.stop();

% Step 10: Disconnect with device.
sampler.disconnect();

% Step 11: Cleanup library.
library.destroy();