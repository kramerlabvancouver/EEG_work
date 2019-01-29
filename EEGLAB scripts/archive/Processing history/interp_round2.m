% EEGLAB history file generated on the 10-Sep-2018
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',{'Participant_C07_Trial_1.set' 'Participant_C07_Trial_3.set'},'filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\interp_missing_chan\\');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'study',0); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_interp(EEG, ALLEEG(2).chanlocs, 'spherical');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG=pop_chanedit(EEG, 'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',1,'delete',33);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:63] , 'Participant_C07_Trial_1 interp', 0, 'ydir',1);
ALLEEG = pop_delset( ALLEEG, [1] );
[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,2);
EEG = pop_loadset('filename','Participant_C07_Trial_1.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\interp_missing_chan\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_interp(EEG, ALLEEG(2).chanlocs, 'spherical');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'FP1' 'FPZ' 'FP2' 'F7' 'FZ' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'M1' 'T7' 'C3' 'CZ' 'C4' 'T8' 'M2' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'PZ' 'P4' 'P8' 'POZ' 'O1' 'OZ' 'O2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
ALLEEG = pop_delset( ALLEEG, [1] );
[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,2);
EEG = pop_loadset('filename','Participant_C07_Trial_1.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\interp_missing_chan\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename','Participant_C07_condition_4.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\interp_missing_chan\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = pop_loadset('filename','Participant_C07_condition_2.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\interp_missing_chan\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'retrieve',1,'study',0); 
EEG=pop_chanedit(EEG, 'changefield',{1 'labels' 'fp1'},'changefield',{2 'labels' 'fpz'},'changefield',{3 'labels' 'fp2'},'changefield',{4 'labels' 'f7'},'changefield',{5 'labels' 'fZ'},'changefield',{5 'labels' 'fz'},'changefield',{6 'labels' 'f4'},'changefield',{7 'labels' 'f8'},'changefield',{8 'labels' 'fc5'},'changefield',{9 'labels' 'fc1'},'changefield',{10 'labels' 'fc2'},'changefield',{11 'labels' 'fc6'},'changefield',{12 'labels' 'm1'},'changefield',{13 'labels' 't7'},'changefield',{14 'labels' 'c3'},'changefield',{15 'labels' 'cz'},'changefield',{16 'labels' 'c4'},'changefield',{17 'labels' 't8'},'changefield',{18 'labels' 'm2'},'changefield',{19 'labels' 'cp5'},'changefield',{20 'labels' 'cp1'},'changefield',{21 'labels' 'cp2'},'changefield',{22 'labels' 'cp6'},'changefield',{23 'labels' 'p7'},'changefield',{24 'labels' 'p3'},'changefield',{25 'labels' 'pz'},'changefield',{26 'labels' 'p4'},'changefield',{27 'labels' 'p8'},'changefield',{28 'labels' 'poz'},'changefield',{29 'labels' 'o1'},'changefield',{30 'labels' 'oz'},'changefield',{31 'labels' 'o2'},'changefield',{32 'labels' 'f3'});
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_interp(EEG, ALLEEG(2).chanlocs, 'spherical');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
eeglab redraw;
