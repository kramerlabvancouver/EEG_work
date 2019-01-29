% EEGLAB history file generated on the 27-Aug-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG.setname='raw';
EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename','Participant_C01_condition_3b.set','filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\to_process\\');
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'lookup','C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
EEG = eeg_checkset( EEG );
