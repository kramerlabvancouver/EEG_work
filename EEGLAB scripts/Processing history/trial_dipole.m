% EEGLAB history file generated on the 24-Aug-2018
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
EEG = pop_subcomp( EEG, [1  2  3  4], 0);
EEG.setname='C01_K_pruned';
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG.setname='Participant_C01_Trial_K ICA';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C01_Trial_A.set' 'Participant_C01_Trial_C.set' 'Participant_C01_Trial_K.set' 'Participant_C01_Trial_Z.set'},'filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\processed\\C01\\');
EEG = eeg_checkset( EEG );
EEG.setname='raw';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C01_Trial_C.set' 'Participant_C01_Trial_K.set' 'Participant_C01_Trial_Z.set' 'Participant_C02_Trial_A.set' 'Participant_C02_Trial_C.set' 'Participant_C02_Trial_K.set' 'Participant_C02_Trial_Z.set' 'Participant_C03_Trial_A.set' 'Participant_C03_Trial_C.set' 'Participant_C03_Trial_K.set' 'Participant_C03_Trial_Z.set' 'Participant_C04_Trial_A.set' 'Participant_C04_Trial_C.set' 'Participant_C04_Trial_K.set' 'Participant_C04_Trial_Z.set' 'Participant_C05_Trial_A.set' 'Participant_C05_Trial_C.set' 'Participant_C05_Trial_K.set' 'Participant_C05_Trial_Z.set' 'Participant_C06_Trial_A.set' 'Participant_C06_Trial_C.set' 'Participant_C06_Trial_K.set' 'Participant_C06_Trial_Z.set' 'Participant_C07_Trial_A.set' 'Participant_C07_Trial_C.set' 'Participant_C07_Trial_K.set' 'Participant_C07_Trial_Z.set'},'filepath','Y:\\19_Carson_Berry\\Study Data\\Edited\\clean\\FZ_ref\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_dipfit_settings( EEG, 'hdmfile','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard_BESA.mat','coordformat','Spherical','mrifile','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\avg152t1.mat','chanfile','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','chansel',[1:EEG.nbchan] );
EEG = pop_multifit(EEG, [1:15] ,'threshold',80,'dipplot','on','plotopt',{'normlen' 'on'});
pop_dipplot( EEG,[1:15] ,'mri','C:\\Program Files\\MATLAB\\R2016b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\avg152t1.mat','summary','on','num','on','projimg','on','projlines','on','normlen','on');
% === History not supported for manual dipole fitting ===
pop_topoplot(EEG,0, [1:30] ,'Participant_C01_Trial_K_FZ_ref',[5 6] ,1,'electrodes','on');
