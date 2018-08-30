% EEGLAB history file generated on the 22-Aug-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_loadset('filename','Participant_C06_condition_2.set','filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\');
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, 6,'keepref','on');
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, [13 19] ,'keepref','on');
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'lookup','C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
EEG = eeg_checkset( EEG );
