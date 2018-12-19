function [ SNR ] = calc_SNR( EEG, chan_name )
%CALC_SNR 
%calculates Signal to Noise Ratio for a given EEGLAB data file that has
%been filtered, epoched, and cleaned (of bad components). 
% Outputs SNR of given channel 

    %Gets chan index of electrode of interest (EOI)
    
       
        chan_num=chan_index(EEG,chan_name);
    if(chan_num==0) 
        warning('No c3 chan');
        chan_num=chan_index(EEG,'C1');
    end

    cheps_start=0.3; cheps_end=0.65;
    leps_start=0.15; leps_end=0.55;
    
    cheps_c3=0.25; cheps_c3_end=0.475;
    leps_c3=0.1; leps_c3_end=0.325;
    
    if(strcmp(chan_name,'CZ'))
        if(EEG.condition=='1'||EEG.condition=='2');
            start_time=cheps_start; end_time=cheps_end;
        else
            start_time=leps_start; end_time=leps_end;
        end
    else %C3 or C1
        if(EEG.condition=='1'||EEG.condition=='2');
            start_time=cheps_c3; end_time=cheps_c3_end;
        else
            start_time=leps_c3; end_time=leps_c3_end;
        end
    end

% pre_trig_sd=std(EEG.data(chan_num,1:EEG.srate,:));
pre_trig_rms=rms(mean(EEG.data(chan_num,1:EEG.srate,:), 3),2); % get the RMS pre-stimulus of channel of interest. 
    post_trig_rms=rms(mean(EEG.data(chan_num,(EEG.srate*start_time+EEG.srate):(EEG.srate*end_time+EEG.srate),:), 3),2);


SNR=20*log10(post_trig_rms/pre_trig_rms);

% for i=1:EEG.trials
% [Post_stim_peaks(i).peaks Post_stim_peaks(i).max_loc]=findpeaks((EEG.data(chan_num,EEG.srate:EEG.srate*2,i))); %Find the biggest peaks (uV) from time=0 to 1 s. 
% [Post_stim_peaks(i).min Post_stim_peaks(i).min_loc]=findpeaks(-(EEG.data(chan_num,EEG.srate:EEG.srate*2,i))); Post_stim_peaks(i).min=-Post_stim_peaks(i).min;  %Find the biggest valleys (uV) from time=0 to 1 s. 
%               
% 
% %need to get RMS of peak signal (N2-P2 complex)
% 
% 
% %Post_stim_peaks(i).loc=(Post_stim_peaks(i).loc/EEG.srate)*1000; %gives time in ms before trigger
% 
% figure; 
% plot( Post_stim_peaks(i).max_loc, Post_stim_peaks(i).peaks, 'o' );
% hold on;
% plot((EEG.data(chan_num,EEG.srate:EEG.srate*2,i)))
% hold on; 
% plot( Post_stim_peaks(i).min_loc, Post_stim_peaks(i).min, 'x' );
% 
% 
% 
% end

%% Find maxes/mins of avg signals
[Post_stim_peaks.avg_peaks Post_stim_peaks.avg_max_loc]=findpeaks(cast(mean(EEG.data(chan_num,EEG.srate:EEG.srate*2.5,:),3),'double'),'MinPeakDistance', EEG.srate/1000*50 ); %Find the biggest peaks (uV) from time=0 to 1 s. 
[Post_stim_peaks.avg_min Post_stim_peaks.avg_min_loc]=findpeaks(cast(-mean(EEG.data(chan_num,EEG.srate:EEG.srate*2.5,:),3), 'double'),'MinPeakDistance', EEG.srate/1000*50); Post_stim_peaks.avg_min=-Post_stim_peaks.avg_min;%Find the biggest peaks (uV) from time=0 to 1 s. 

%% Get the peaks of the derivative 
[Post_stim_peaks.deriv_peaks Post_stim_peaks.deriv_loc]=findpeaks(cast(diff(mean(EEG.data(chan_num,EEG.srate:EEG.srate*2,1:EEG.trials),3),1), 'double')); 
%Identify the maximum positive rate of change. For the N2P2 complex, this
%exists between the N2 and P2. 
[Deriv_max, Deriv_max_loc]=max(diff(mean(EEG.data(chan_num,EEG.srate:EEG.srate*2,1:EEG.trials),3),1));
% plot(1:4000, fft(diff(mean(EEG.data(chan_num,EEG.srate:EEG.srate*2,1:EEG.trials),3),1))); axis([-1 50 -30 30]);
% 
% plot(1:4000, fft(lowpass(diff(mean(EEG.data(chan_num,EEG.srate:EEG.srate*2,1:EEG.trials),3),1),30)); axis([-1 50 -30 30]);
% filtered_deriv=filtfilt(tempfilt,diff(mean(cast(EEG.data(chan_num,EEG.srate:EEG.srate*2,1:EEG.trials),'double'),3),1)*100);
% figure;
% plot(1:4000, filtered_deriv*10);
%% need to identify the minimum valley (N2) before the Deriv_max (maximum rate of
%change) and the Maximum peak (P2) after the the Deriv_max
j=1; 
i=1;
while(Post_stim_peaks.avg_max_loc(j)<Deriv_max_loc)
    j=j+1; %inc Post_stim_peak.avg_min_loc until we find the 
    
    if(Post_stim_peaks.avg_min_loc(j)<Deriv_max_loc)
    i=j; %capture the last min location that was less than the max Deriv_max_loc (location of the maximum rate of change). This should correspond to the N2 generally. 
    end
    
end

% %One last Max/min filter to make sure N2 and P2 are correct 
%  if(Post_stim_peaks.avg_peaks(j)>Post_stim_peaks.avg_peaks(j+1))
%      Post_stim_peaks.P2_amp=Post_stim_peaks.avg_peaks(j);
%      Post_stim_peaks.P2_loc=Post_stim_peaks.avg_max_loc(j);
% 
%  elseif(Post_stim_peaks.avg_peaks(j)<Post_stim_peaks.avg_peaks(j+1))
%      Post_stim_peaks.P2_amp=Post_stim_peaks.avg_peaks(j+1);
%      Post_stim_peaks.P2_loc=Post_stim_peaks.avg_max_loc(j+1);
%      
%  end
 
 %compare if min(j) is less than min(j-1). Yes= use j. 
%  if(Post_stim_peaks.avg_min(j)<Post_stim_peaks.avg_min(j-1))
%      Post_stim_peaks.N2_loc=Post_stim_peaks.avg_min_loc(j); 
%      Post_stim_peaks.N2_amp=Post_stim_peaks.avg_min(j);
%      
%      
%      %no= use j-1
%  elseif(Post_stim_peaks.avg_min(j)>Post_stim_peaks.avg_min(j-1))
%      Post_stim_peaks.N2_loc=Post_stim_peaks.avg_min_loc(j-1); 
%      Post_stim_peaks.N2_amp=Post_stim_peaks.avg_min(j-1);
%  end
    
% [Post_stim_peaks.N2_amp,Post_stim_peaks.N2_loc]=min( [Post_stim_peaks.avg_min(j) Post_stim_peaks.avg_min(j-1)]);

%% j should now contain the index of the sample after N2, and before (or at
%P2)
Post_stim_peaks.P2_loc=Post_stim_peaks.avg_max_loc(j);
Post_stim_peaks.P2_amp=Post_stim_peaks.avg_peaks(j);
Post_stim_peaks.N2_loc=Post_stim_peaks.avg_min_loc(i); 
Post_stim_peaks.N2_amp=Post_stim_peaks.avg_min(i);

%% getting the peak before N2 (to start the time of the N2:P2 waveform for
%the RMS calculation
try
Post_stim_peaks.N2_pre_loc=Post_stim_peaks.avg_min_loc(i-2);
Post_stim_peaks.N2_pre_amp=Post_stim_peaks.avg_min(i-2);


Post_stim_peaks.P2_post_loc=Post_stim_peaks.avg_max_loc(j+2);
Post_stim_peaks.P2_post_amp=Post_stim_peaks.avg_peaks(j+2);

catch
    disp('Error N2P2 identified too close to the boundry of the plot');
    disp('Reducing the Signal boundary to fixed latencies [100 600] ms');
    
    Post_stim_peaks.N2_pre_loc=EEG.srate+EEG.srate*0.1;

    
    
    Post_stim_peaks.P2_post_loc=EEG.srate+EEG.srate*0.6;
   
    
end


%% Plotting figs
figure;

plot(mean(EEG.data(chan_num,EEG.srate:EEG.srate*2,1:EEG.trials),3)); 
hold on; 
plot(diff(mean(EEG.data(chan_num,EEG.srate:EEG.srate*2,1:EEG.trials),3),1)*100);
plot( Post_stim_peaks.avg_max_loc, Post_stim_peaks.avg_peaks, 'o' );
hold on; 
plot( Post_stim_peaks.avg_min_loc, Post_stim_peaks.avg_min, 'x' );
hold on; 
plot( Post_stim_peaks.N2_loc, Post_stim_peaks.N2_amp, 'r*' );
hold on; plot( Post_stim_peaks.P2_loc, Post_stim_peaks.P2_amp, 'r*' )
title(char(EEG.setname));

%% get the post trigger RMS in the "window of interest" which will be before
%the deflection to N2 to after return to "0 V" after P2
%post_trig_rms=rms(mean(EEG.data(chan_num,(Post_stim_peaks.N2_pre_loc+EEG.srate):(Post_stim_peaks.P2_post_loc+EEG.srate),:), 3),2); 
%post_trig_rms=rms(mean(EEG.data(chan_num,(EEG.srate*0.1+EEG.srate):(EEG.srate*0.6+EEG.srate),:), 3),2); 

%SNR=20*log10(post_trig_rms/pre_trig_rms);





