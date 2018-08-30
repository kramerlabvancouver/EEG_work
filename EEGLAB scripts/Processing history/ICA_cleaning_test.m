% EEGLAB history file generated on the 16-Aug-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG.setname='raw';
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C01_Trial_A.set' 'Participant_C01_Trial_C.set' 'Participant_C01_Trial_K.set' 'Participant_C01_Trial_Z.set'},'filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG.setname='ICA';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG.setname='ICA';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Participant_C01_Trial_A.set' 'Participant_C01_Trial_C.set' 'Participant_C01_Trial_K.set' 'Participant_C01_Trial_Z.set' 'Participant_C02_Trial_A.set' 'Participant_C02_Trial_C.set' 'Participant_C02_Trial_K.set' 'Participant_C02_Trial_Z.set' 'Participant_C03_Trial_A.set' 'Participant_C03_Trial_C.set' 'Participant_C03_Trial_K.set' 'Participant_C03_Trial_Z.set' 'Participant_C04_Trial_A.set' 'Participant_C04_Trial_C.set' 'Participant_C04_Trial_K.set' 'Participant_C04_Trial_Z.set' 'Participant_C05_Trial_A.set' 'Participant_C05_Trial_C.set' 'Participant_C05_Trial_K.set' 'Participant_C06_Trial_A.set' 'Participant_C06_Trial_C.set' 'Participant_C06_Trial_K.set' 'Participant_C07_Trial_A.set' 'Participant_C07_Trial_C.set' 'Participant_C07_Trial_Z.set' 'Participant_C09_Trial_K.set'},'filepath','Z:\\19_Carson_Berry\\Study Data\\Edited\\processed\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
pop_topoplot(EEG,0, [1:30] ,'ICA',[5 6] ,0,'electrodes','on');
pop_comperp( ALLEEG, 0, 2,[],'addavg','off','addstd','off','addall','on','diffavg','off','diffstd','off','chans',[],'tplotopt',{'ydir' -1});
figure; pop_plottopo(EEG, [1:30] , 'ICA', 0, 'ydir',1);
pop_prop( EEG, 0, [1  2], NaN, {'freqrange' [2 50] });
figure; pop_erpimage(EEG,0, [1],[[]],'Comp. 1',10,10,{ 'chan32'},[],'type' ,'yerplabel','','erp','on','cbar','on','topo', { mean(EEG.icawinv(:,[1]),2) EEG.chanlocs EEG.chaninfo } );
figure; pop_erpimage(EEG,0, [2],[[]],'Comp. 2',10,10,{ 'chan32'},[],'type' ,'yerplabel','','erp','on','cbar','on','topo', { mean(EEG.icawinv(:,[2]),2) EEG.chanlocs EEG.chaninfo } );
EEG = pop_subcomp( EEG, [2], 0);
EEG.setname='C01_Trial_C';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 29,'retrieve',3,'study',0); 
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
