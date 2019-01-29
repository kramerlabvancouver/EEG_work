% EEGLAB history file generated on the 07-Sep-2018
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','Participant_C07_Trial_3.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG=pop_chanedit(EEG, 'append',5,'changefield',{6 'labels' 'test'},'changefield',{6 'labels' 'P08'},'lookup','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','changefield',{6 'labels' 'PO8'},'lookup','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
eeglab redraw;
