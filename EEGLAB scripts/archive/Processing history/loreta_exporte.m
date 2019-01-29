% EEGLAB history file generated on the 11-Sep-2018
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
figure; pop_plottopo(EEG, [1:30] , 'ICA', 0, 'ydir',1);
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, [1  2  3], 0);
EEG.setname='C06_A';
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
EEG.setname='Participant_C06_Trial_A ICA';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C06_Trial_A.set' 'Participant_C06_Trial_C.set' 'Participant_C06_Trial_K.set' 'Participant_C06_Trial_Z.set'},'filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\processed\\C06\\');
EEG = eeg_checkset( EEG );
EEG.setname='Participant_C06_Trial_A ICA';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG.setname='Participant_C06_Trial_A ICA';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C06_Trial_A.set' 'Participant_C06_Trial_C.set' 'Participant_C06_Trial_K.set' 'Participant_C06_Trial_Z.set'},'filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\clean\\Interpolated to 30 chan\\C06\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
pop_selectcomps(EEG, [1:23] );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',2,'study',0); 
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'extended',1,'interupt','on');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_dipfit_settings( EEG, 'hdmfile','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard_BESA.mat','coordformat','Spherical','mrifile','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\avg152t1.mat','chanfile','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','chansel',[1:30] );
EEG = pop_multifit(EEG, [1:30] ,'threshold',50,'rmout','on','dipplot','on','plotopt',{'normlen' 'on'});
EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',5,'study',0); 
pop_selectcomps(EEG, [1:30] );
pop_dipplot( EEG,[1:4 6 9 10 11 16 17 20 22 25 28 29:30] ,'rvrange',[0 50] ,'mri','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\avg152t1.mat','summary','on','num','on','projlines','on','normlen','on');
