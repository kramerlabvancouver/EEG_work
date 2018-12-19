% load ALLEEG_mast_nov21.mat 
% NRS_master=csvread('CvL_stim_NRS.csv'); %row1: Header (Participant #, Trial
%                                         %#, Stim #
                      
NRS_master=NRS_master_backup;

for i=1:length(ALLEEG) %go through each file stored in ALLEEG_mast study
    
    EEG=ALLEEG_mast(i);
    
    temp1=uint8(ALLEEG(i).subject); max_comp(i).subnum=str2num(char([temp1(2:end)])); %get the participant number
    
    
    max_comp(i).comp=get_max_IC(EEG); %get the component that accounts for the most variance within the ROI (350:600 for cheps, 200:450 LEPS)
    fprintf('Max component is %i. \n', max_comp(i).comp);
    %%test
    %      for zz=1:10
    %          max_comp(i).comp=zz;
                                                            %0s     : 1 S 
     max_comp(i).mean_comp=mean(EEG.icaact(max_comp(i).comp,EEG.srate:EEG.srate*2,:),3); %Save the mean (max) component activation across all trial
     
     max_comp(i).CZ_index= find(strcmpi({ALLEEG_mast(1,i).chanlocs.labels}.', 'CZ'));
  
     max_comp(i).cz_mean=mean(EEG.data(max_comp(i).CZ_index,EEG.srate:EEG.srate*2,:),3);
     
     check_start_time=500;
     check_end_time=2500;
     
    [max_comp(i).ave_max, max_comp(i).ave_max_index]=max(max_comp(i).mean_comp(check_start_time:check_end_time));    %get the max location of the average (n2 or p2)
    [max_comp(i).ave_min, max_comp(i).ave_min_index]=min(max_comp(i).mean_comp(check_start_time:check_end_time));    %get the min location of the average (n2 or p2)
    
%       figure; plot(1:length(max_comp(i).mean_comp), max_comp(i).mean_comp);
%       figure; pop_topoplot(EEG, 0, max_comp(i).comp, [EEG.setname ' '  max_comp(i).topology]); 
%     fprintf('Condition %c\n', EEG.condition);
    %%Figure out if component is N2 or P2 "shape"
    if(max_comp(i).ave_max_index>max_comp(i).ave_min_index) %check if max is after min, if yes, then matches N2P2 form. 
        max_comp(i).topology='normal';
    else max_comp(i).topology='reverse';
    end
    
    %%----------------------------------------------------------------
    %_________________GET COMPONENT TRIAL ACTIVITY____________________
    time_max0=(max_comp(i).ave_max_index-EEG.srate*60/1000+EEG.srate+check_start_time);
    time_max1=(max_comp(i).ave_max_index+EEG.srate*60/1000+EEG.srate+check_start_time);
    time_min0=(max_comp(i).ave_min_index-EEG.srate*60/1000+EEG.srate+check_start_time);
    time_min1=(max_comp(i).ave_min_index+EEG.srate*60/1000+EEG.srate+check_start_time);
    
    for j=1:EEG.trials
        max_comp(i).trial_max(j)=rms(EEG.icaact(max_comp(i).comp,time_max0:time_max1,j)); %get the RMS of the ica activation of each trial from 60 ms before n2 to 60 ms after n2
        %           max_comp(i).trial_max_index(j)=(max_comp(i).trial_max_index(j)-4000)/4; % index time in ms
        max_comp(i).trial_min(j) =rms(EEG.icaact(max_comp(i).comp,time_min0:time_min0,j));  %get the RMS of the ica activation of each trial from 60 ms before p2 to 60 ms after n2
        %           max_comp(i).trial_min_index(j)=(max_comp(i).trial_min_index(j)-4000)/4;  % index time in ms
    end
    %_________________________________________________________________
    
    j=length(max_comp(i).trial_max);
%      while(j>20)            %MAKE SURE NO EXTRA TRIALS ARE INCLUDED> 
%          max_comp(i).trial_max(j)=[];
%          max_comp(i).trial_min(j)=[];
%          j=j-1;
%      end
    
    %%find the index of removed epochs from each dataset (to ignore these
    %%from NRS data)
    max_comp(i).rejected_epochs=get_removed_epochs(EEG);
    
    
    
    
    %%Check if the number of pre-edit trials is >21 (==22). If it is -
    %%ignore the last trial (of the component activation data). Do this
    %%only if trial 22 hasn't been rejected previously. 
    
    if((EEG.trials+length(max_comp(i).rejected_epochs))>21&&(isempty(find(max_comp(i).rejected_epochs==22)))||(EEG.trials+length(max_comp(i).rejected_epochs))>20&&(isempty(find(max_comp(i).rejected_epochs==21))))
        max_comp(i).trial_max(end)=[];
        max_comp(i).trial_min(end)=[];
    end
    
    
    
    
    %%Check for epoch "1"'s that likely don't correspond to a stimulus %%and remove them from the "remove list"
    
    
    indx=0;
    indx=find( max_comp(i).rejected_epochs==1);
    if indx~=0
        max_comp(i).rejected_epochs(indx)=[]; %remove the epoch corresponding to 1 from our considertion
        max_comp(i).rejected_epochs = max_comp(i).rejected_epochs -1;
    end
    
       %%Make removed trials map correctly to pain ratings involved %%in correlation.
   
     nrs_trial_index=(str2num(EEG.condition)-1)*19+max_comp(i).subnum;
    
    
    
    for k=1:length(max_comp(i).rejected_epochs)
        if(max_comp(i).rejected_epochs(k)<20) %only overwrite NRS value if it actually pertains to a stim (not a shutdown effect)
        NRS_master(nrs_trial_index,max_comp(i).rejected_epochs(k)+2)=NaN;
        end
    end
    
    
  
    
end 

%NRS_master(nrs_trial_index,:)=NRS_master_backup(nrs_trial_index,:);

%ALLEEG=ALLEEG_mast; 
for(i=1:length(ALLEEG_mast))
%      nrs_trial_index=(str2num(ALLEEG(i).condition)-1)*19+max_comp(i).subnum; %-max_comp(i).trial_min(1:end)-max_comp(i).trial_min(1:20)
%    [nonans_row, nonans_col]=find(~isnan(NRS_master(nrs_trial_index,3:end)));
%    
%    h=figure;
%    %            Trial data should be good.                     Only take
%    %             relevant NRS data  
%    scatter(max_comp(i).trial_max(1:end),  NRS_master(nrs_trial_index,nonans_col(1:length(max_comp(i).trial_max)))); %(1:length(max_comp(i).trial_max))
%    xlabel('Component activity by trial')
%     ylabel('NRS')
%    title_text= [[ALLEEG(i).subject '-' EEG.condition] ' Correlation between component ' num2str(max_comp(i).comp) ' activity and pain by trial'];
%    title(title_text);
%    lsline; 
% %     
    nrs_trial_index=(str2num(ALLEEG_mast(i).condition)-1)*19+max_comp(i).subnum;
    [nonans_row, nonans_col]=find(~isnan(NRS_master(nrs_trial_index,3:end)));
    
    

%want to correlate with N2 
try 
    if(strcmp(max_comp(i).topology,'reverse'))
        max_comp(i).N2_correlation_coefficients=corrcoef(max_comp(i).trial_max(1:end), NRS_master(nrs_trial_index,nonans_col(1:length(max_comp(i).trial_min))));
        max_comp(i).P2_correlation_coefficients=corrcoef(max_comp(i).trial_min(1:end), NRS_master(nrs_trial_index,nonans_col(1:length(max_comp(i).trial_max))));
        max_comp(i).cor_mean=max_comp(i).mean_comp*(-1); %get corrected mean
        disp('reverse');
    else
        max_comp(i).P2_correlation_coefficients=corrcoef(max_comp(i).trial_max(1:end), NRS_master(nrs_trial_index,nonans_col(1:length(max_comp(i).trial_min))));
        max_comp(i).N2_correlation_coefficients=corrcoef(max_comp(i).trial_min(1:end), NRS_master(nrs_trial_index,nonans_col(1:length(max_comp(i).trial_max))));
        max_comp(i).cor_mean=max_comp(i).mean_comp; %get corrected mean
        disp('normal');
    end
    max_comp(i).P2_correlation_coefficients=max_comp(i).P2_correlation_coefficients(2,1);
    max_comp(i).N2_correlation_coefficients=max_comp(i).N2_correlation_coefficients(2,1);
catch 
    warning('Probable dim mismatch between trial number and NRS number, assigning coefficient=NaN');
      max_comp(i).P2_correlation_coefficients=NaN;
    max_comp(i).N2_correlation_coefficients=NaN;
end

% P2_coefficient_array(i)=max_comp(i).correlation_coefficients;
figure; pop_topoplot(ALLEEG_mast(i), 0, max_comp(i).comp, [ALLEEG_mast(i).setname ' '  max_comp(i).topology]); 
end

%P2_coefficient_array=P2_coefficient_array'; 
mean_N2_correlation=mean([max_comp(i).N2_correlation_coefficients]);
mean_P2_correlation=mean([max_comp(i).P2_correlation_coefficients]);


figure; boxplot([max_comp.P2_correlation_coefficients],{max_comp.subnum});
hold on; title('P2 Correlation coefficients with NRS by subject'); 
hold on; ylabel('Correlation coefficient');
hold on; xlabel('Subject Number');
hold on; legend('P2 correlation Coefficients, mean:0.062'); %,'P2 Correlation Coefficients, mean:0.025');

h=figure; boxplot([max_comp.N2_correlation_coefficients],{ALLEEG_mast.condition},'Labels',{'LEPs Placebo','CHEPs Placebo','LEPs Capsaicin','CHEPs Capsaicin'}); 
hold on; ylabel('Correlation coefficient (R)');
hold on; title('N2 Correlation coefficients with NRS by condition'); 
savefig(h, 'N2 NRS correlation by condition'); close(h);



% mean()+EEG.srate+check_start_time
% max_index=max_comp(1:end).ave_max_index;
    
                




cond1=find([ALLEEG.condition]=='1');
cond2=find([ALLEEG.condition]=='2');
cond3=find([ALLEEG.condition]=='3');
cond4=find([ALLEEG.condition]=='4');                 
             
mean1=mean(cat(1,max_comp(cond1).cor_mean)); [~,cheps_n2_mindex]=min(mean1);[~,cheps_n2_maxdex]=max(mean1);
mean2=mean(cat(1,max_comp(cond2).cor_mean)); [~,cheps_n2_mindex_cap]=min(mean2);[~,cheps_n2_maxdex_cap]=max(mean2);
mean3=mean(cat(1,max_comp(cond3).cor_mean)); [~,leps_n2_mindex]=min(mean3); [~,leps_n2_maxdex]=max(mean3);
mean4=mean(cat(1,max_comp(cond4).cor_mean)); [~,leps_n2_mindex_cap]=min(mean4); [~,leps_n2_maxdex_cap]=max(mean4);

cheps_n2_mindex=cheps_n2_mindex/4; cheps_n2_maxdex=cheps_n2_maxdex/4;
cheps_n2_mindex_cap=cheps_n2_mindex_cap/4; cheps_n2_maxdex_cap=cheps_n2_maxdex_cap/4;

leps_n2_mindex=leps_n2_mindex/4;   leps_n2_maxdex=leps_n2_maxdex/4;
leps_n2_mindex_cap=leps_n2_mindex_cap/4;   leps_n2_maxdex_cap=leps_n2_maxdex_cap/4;

cz_mean1=mean(cat(1,max_comp(cond1).cz_mean)); [~,cheps_n2cz_mindex]=min(cz_mean1);[~,cheps_n2cz_maxdex]=max(cz_mean1);
cz_mean2=mean(cat(1,max_comp(cond2).cz_mean)); [~,cheps_n2cz_mindex_cap]=min(cz_mean2);[~,cheps_n2cz_maxdex_cap]=max(cz_mean2);
cz_mean3=mean(cat(1,max_comp(cond3).cz_mean)); [~,leps_n2cz_mindex]=min(cz_mean3);[~,leps_n2cz_maxdex]=max(cz_mean3);
cz_mean4=mean(cat(1,max_comp(cond4).cz_mean)); [~,leps_n2cz_mindex_cap]=min(cz_mean4);[~,leps_n2cz_maxdex_cap]=max(cz_mean4);

cheps_n2cz_mindex=cheps_n2cz_mindex/4; cheps_n2cz_maxdex=cheps_n2cz_maxdex/4;
cheps_n2cz_mindex_cap=cheps_n2cz_mindex_cap/4; cheps_n2cz_maxdex_cap=cheps_n2cz_maxdex_cap/4;

leps_n2cz_mindex=leps_n2cz_mindex/4;   leps_n2cz_maxdex=leps_n2cz_maxdex/4;
leps_n2cz_mindex_cap=leps_n2cz_mindex_cap/4;   leps_n2cz_maxdex_cap=leps_n2cz_maxdex_cap/4;

%%Plot component and ERP data together
x=0:0.25:1000;
yline=20;

figure; 

ax1=subplot(2,2,1)
plot(x,mean1); 
hold on; plot(x,cz_mean1);

title('CHEPs Placebo "N2P2" component mean');
line([cheps_n2_mindex cheps_n2_mindex],[-yline yline], 'linestyle', ':'); line([cheps_n2_maxdex cheps_n2_maxdex],[-yline yline], 'linestyle', ':');
line([cheps_n2cz_mindex cheps_n2cz_mindex],[-yline yline], 'linestyle', ':', 'Color', 'red'); line([cheps_n2cz_maxdex cheps_n2cz_maxdex],[-yline yline], 'linestyle', ':', 'Color', 'red');


ax2=subplot(2,2,3) 
plot(x,mean2);
hold on; plot(x,cz_mean2);

title('CHEPs Capsaicin "N2P2" component mean');
line([cheps_n2_mindex cheps_n2_mindex],[-yline yline], 'linestyle', ':');line([cheps_n2_maxdex cheps_n2_maxdex],[-yline yline], 'linestyle', ':');
line([cheps_n2cz_mindex_cap cheps_n2cz_mindex_cap],[-yline yline], 'linestyle', ':', 'Color', 'red'); line([cheps_n2cz_maxdex_cap cheps_n2cz_maxdex_cap],[-yline yline], 'linestyle', ':', 'Color', 'red');


ax3=subplot(2,2,2) 
plot(x,mean3);
hold on; plot(x,cz_mean3);

title('LEPs Placebo "N2P2" component mean');
line([leps_n2_mindex leps_n2_mindex],[-yline yline], 'linestyle', ':'); line([leps_n2_maxdex leps_n2_maxdex],[-yline yline], 'linestyle', ':');
line([leps_n2cz_mindex leps_n2cz_mindex],[-yline yline], 'linestyle', ':', 'Color', 'red'); line([leps_n2cz_maxdex leps_n2cz_maxdex],[-yline yline], 'linestyle', ':', 'Color', 'red');


ax4=subplot(2,2,4) 
plot(x,mean4);
hold on; plot(x,cz_mean4);

title('LEPs Capsaicin "N2P2" component mean');
line([leps_n2_mindex leps_n2_mindex],[-yline yline], 'linestyle', ':'); line([leps_n2_maxdex leps_n2_maxdex],[-yline yline], 'linestyle', ':');
line([leps_n2cz_mindex_cap leps_n2cz_mindex_cap],[-yline yline], 'linestyle', ':', 'Color', 'red'); line([leps_n2cz_maxdex_cap leps_n2cz_maxdex_cap],[-yline yline], 'linestyle', ':', 'Color', 'red');


legend(ax1,{'N2P2 Component','CZ Electrode Activity','N2 Component Min', 'P2 Component Max','N2 CZ Min', 'P2 CZ Max'})
linkaxes([ax3,ax1,ax2,ax4],'y')


%%disp average ICAACT of max_comp.comp
%         %Icaweight chan, comp?
% for i=1:length(ALLEEG) 
% max_comp(i).n2_weights=mean(ALLEEG(i).icawinv(:,max_comp(i).comp),2);
% max_comp(i).p1_weights=mean(ALLEEG(i).icawinv(:,p1_max_comp(i).comp),2);
% 
% end
% 
% mean_n2_weights=mean(cat(1,[max_comp.n2_weights])); %because channel locations are not consistent - the datasets cannot concatenate. 
% 
% figure; topoplot(max_comp(1).n2_weights, ALLEEG(1).chanlocs);







