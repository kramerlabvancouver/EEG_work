%
%   A script to check electrode impedances and recommend which electrodes need
%   attention. After the user confirms their readiness by pressing 'y', the
%   system begins to record all channels with impedance less than 100 kohm.
%   Requirements: TMSi Amplfier, Cap, 
%   Outputs: 
%   Author: Carson Berry (heavily using TMSi example scripts)
%   Date: May 16th, 2018

%Step 0
%Record a subset of Channels! User can define them here, or the list can be
%automatically defined by all those with impedances lower than 100 kohm. 
    
% Subset of channels to show
%channel_subset = [1 3 5 6]; % only show channels 1,3,5 and 6

%or if the user wants to change the electrodes measured and recorded
%everytime; 
%initialize array
channel_subet = [];
%populate string 
channel_subset = input('Please enter the channel numbers you wish to test and record: \n', 's');
%convert to an array of integers
channel_subset = str2num(channel_subset);



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
        
       
        %Loop around checking impedance until user is ready to continue
        impedance_check=1;
     while(impedance_check)
            % Step 7: Start imepdance mode sampling.
            MAX_IMPEDANCE=20;
            sampler.start(MAX_IMPEDANCE);  %value is kOhm used to control impedance indicators on the device. Valid values are: 2, 5, 10, 20, 50, 100, 200
            fprintf(' = Impedance mode sampling started.\n');

            % Step 8: Sample 50 times.
            for i=1:50
                samples = sampler.sample();
                fprintf(' = Sampled %d samples.\n', size(samples, 2));
            end
       
            
            % Step 9: Stop sampler.
            sampler.stop();
            fprintf(' = Sampling stopped.\n');
            
            %Step 9.5 import waveguard electrode numerical positions 
            %waveguardcapmap=readtable(Waveguard_cap_map.xlsx);
                Waveguardcapmap = importfile('Waveguard_cap_map.xlsx','Sheet1',1,64);
            
            %Step 10: Check impedances (samples) and inform user which electrodes
            %need more attention. 

            %Step 10.1: Get the size of Channel_Subset to use it as an
            %index in showing only the channels we care about. 
            
            L=length(channel_subset);
            
            for i=1:L
                %If underflow happened (not sure how), reset impedance to
                %0
                if( samples(channel_subset(i))> 4294967290)
                    samples(channel_subset(i))=0;
                end
                %printout high impedance electrodes
                if samples(channel_subset(i))>MAX_IMPEDANCE
                    
                    fprintf(' = High Impedance at %s \n', Waveguardcapmap{channel_subset(i),1});
                end
             
            end
            
            %Step 10.5 Plot Impedances for easy visual checking!
                bar(1:L,samples(channel_subset(i)));
            
            %Break from impedance checking loop if the user is ready to
            %continue.
            y=input('press "y" to record, "q" to quit');
            if (strcmp('y',y)||strcmp('q',y))
                 impedance_check=0;
            else
                impedance_check=1;
            end
                   
            
     end 
     catch matlabException
            warning(sprintf('Error while trying to sample.\n\tIdentifier: %s\n\tMessage: %s\n', matlabException.identifier, matlabException.message));

    end

    % Step 10: Disconnect with device.
    sampler.disconnect();
    fprintf(' = Sampler disconnected.\n');

catch matlabException
    warning(sprintf('Error while trying to create device/sampler.\n\tIdentifier: %s\n\tMessage: %s\n', matlabException.identifier, matlabException.message));
end




%Record a subset of Channels! User can define them here, or the list can be
%automatically defined by all those with impedances lower than 100 kohm. 
    
% Subset of channels to show
%channel_subset = [1 3 5 6]; % only show channels 1,3,5 and 6

% Poly5 file properties
	% file name:
file_name = 'example07.Poly5';
	% name of measurement:
measurement_name = 'Poly5 Example';

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
        % sampler.setSampleRate(2048);
        % sampler.setReferenceCalculation(true);

        % Step 6: Create a RealTimePlot.
        realTimePlot = TMSi.RealTimePlot('RealTimePlot Example', sampler.sample_rate, device.channels(channel_subset));
        realTimePlot.setWindowSize(10);
        realTimePlot.show();

        % Step 7: Create a Poly5 file to save samples to.
        poly5 = TMSi.Poly5(file_name, measurement_name, sampler.sample_rate, device.channels(channel_subset));

        % Step 8: Connect to device through the sampler.
        sampler.connect();

        % Step 9: Start sampling.
        sampler.start();
        
        % Step 10: Sample as long as plot is visible. Can be closed with 'q' or cross.
        while realTimePlot.is_visible
            samples = sampler.sample();

            % Step 11: Append samples to plot.
            realTimePlot.append(samples(channel_subset, :));

            % Step 12: Append and draw samples to poly5 file.
            poly5.append(samples(channel_subset, :));
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


run Example05.m 


    

