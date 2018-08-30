% EEGLAB history file generated on the 28-Aug-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG.setname='raw';
EEG = eeg_checkset( EEG );
EEG.setname='ICA';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C01_Trial_A.set' 'Participant_C01_Trial_C.set' 'Participant_C01_Trial_K.set' 'Participant_C01_Trial_Z.set' 'Participant_C02_Trial_A.set' 'Participant_C02_Trial_C.set' 'Participant_C02_Trial_K.set' 'Participant_C02_Trial_Z.set' 'Participant_C03_Trial_A.set' 'Participant_C03_Trial_C.set' 'Participant_C03_Trial_K.set' 'Participant_C03_Trial_Z.set' 'Participant_C04_Trial_A.set' 'Participant_C04_Trial_C.set' 'Participant_C04_Trial_K.set' 'Participant_C04_Trial_Z.set' 'Participant_C05_Trial_A.set' 'Participant_C05_Trial_C.set' 'Participant_C05_Trial_K.set' 'Participant_C06_Trial_A.set' 'Participant_C06_Trial_C.set' 'Participant_C06_Trial_K.set' 'Participant_C06_Trial_Z.set' 'Participant_C07_Trial_A.set' 'Participant_C07_Trial_C.set' 'Participant_C07_Trial_K.set' 'Participant_C07_Trial_Z.set' 'Participant_C09_Trial_C.set' 'Participant_C09_Trial_K.set'},'filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\(t)werk\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
pop_selectcomps(EEG, [1:30] );
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, [1], 0);
EEG.setname='C01_Z_pruned';
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG.setname='Participant_C01_Trial_Z ICA';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C01_Trial_A.set' 'Participant_C01_Trial_C.set' 'Participant_C01_Trial_K.set' 'Participant_C01_Trial_Z.set'},'filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\processed\\C01\\');
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C01_Trial_A.set' 'Participant_C01_Trial_C.set' 'Participant_C01_Trial_K.set' 'Participant_C01_Trial_Z.set'},'filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\test\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [13 14] , 'Participant_C01_Trial_Z ICA', 0, 'ydir',1);
