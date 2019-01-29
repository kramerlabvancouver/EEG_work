% EEGLAB history file generated on the 20-Aug-2018
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','C07_trial_1.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\test\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_eegthresh(EEG,1,[1:31] ,-25,25,-1,1.9997,2,0);
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
pop_saveh( ALLCOM, 'save_marks.m', 'Z:\19_Carson_Berry\EEG\MATLAB\trunk\src\EEGLAB scripts\Processing history\');
EEG = eeg_checkset( EEG );
figure; pop_timtopo(EEG, [-1000        1999.75], [NaN], 'ERP data and scalp maps of Continuous Data TMSi Name: Participant_C07_Trial_1 epochs');
EEG = eeg_checkset( EEG );
pop_topoplot(EEG,1, [-200:25:600] ,'Continuous Data TMSi Name: Participant_C07_Trial_1 epochs',[6 6] ,0,'electrodes','on');
eeglab redraw;
