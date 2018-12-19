% EEGLAB history file generated on the 05-Sep-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG.setname='raw';
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C06_condition_2.set' 'Participant_C06_condition_4.set' 'Participant_C06_Trial_1.set' 'Participant_C06_Trial_3.set'},'filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 500);
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'savemode','resave');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_prepPipeline(, 
EEG.setname='Participant_C06_Trial_1_prep';
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  }, [-1  2], 'newname', 'Participant_C06_Trial_1_prep epochs', 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Participant_C06_Trial_1_prep epochs', 0, 'ydir',1);
EEG = pop_eegfiltnew(EEG, [],0.5,3300,1,[],0);
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Participant_C06_Trial_1_prep epochs', 0, 'ydir',1);
EEG = pop_eegfiltnew(EEG, [],1,1650,1,[],1);
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Participant_C06_Trial_1_prep epochs', 0, 'ydir',1);
EEG = pop_reref( EEG, 5,'keepref','on');
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Participant_C06_Trial_1_prep epochs', 0, 'ydir',1);
