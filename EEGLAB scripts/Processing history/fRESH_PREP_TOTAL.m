% EEGLAB history file generated on the 05-Sep-2018
% A history script used to learn how to script with PREP_Pipeline and
% multiple datasets. 
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',{'Participant_C06_condition_2.set' 'Participant_C06_condition_4.set' 'Participant_C06_Trial_1.set' 'Participant_C06_Trial_3.set'},'filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 500);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'overwrite','on','gui','off'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'retrieve',3,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 500);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'overwrite','on','gui','off'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'retrieve',2,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 500);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'overwrite','on','gui','off'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 500);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',2,'study',0); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',3,'study',0); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'retrieve',4,'study',0); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',2,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',3,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'retrieve',4,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = clean_rawdata(EEG, 5, [0.25 0.75], 0.8, 4, 5, 0.5);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'retrieve',5,'study',0); 
EEG = pop_eegfiltnew(EEG, [],1,1650,1,[],1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  }, [-1  2], 'newname', 'Participant_C06_Trial_3_no_digi resampled epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:25] , 'Participant_C06_Trial_3_no_digi resampled epochs', 0, 'ydir',1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'retrieve',4,'study',0); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'retrieve',5,'study',0); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'retrieve',4,'study',0); 
EEG = pop_prepPipeline(struct('detrendChannels', [1:EEG.nbchan], 'detrendCutoff', 1, 'detrendStepSize', 0.02, 'detrendType', 'High Pass', 'lineNoiseChannels', [1:EEG.nbchan], 'lineFrequencies', [60  120  180  240], 'Fs', 500, 'p', 0.01, 'fScanBandWidth', 2, 'taperBandWidth', 2, 'taperWindowSize', 4, 'pad', 0, 'taperWindowStep', 1, 'fPassBand', [0  250], 'tau', 100, 'maximumIterations', 10), 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'setname','C06_3_prepped','savenew','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\PREP test\\Participant_C06_Trial_3_prepd.set','gui','off'); 
eeglab('redraw');
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  }, [-1  2], 'newname', 'C06_3_prepped epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'C06_3_prepped epochs', 0, 'ydir',1);
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, [12 18] ,'keepref','on');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'C06_3_prepped epochs', 0, 'ydir',1);
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'C06_3_prepped epochs', 0, 'ydir',1);
EEG = eeg_checkset( EEG );
figure; pop_erpimage(EEG,1, [15],[[]],'CZ vs average C06_3',3,1,{},[],'' ,'yerplabel','\muV','erp','on','cbar','on','topo', { [15] EEG.chanlocs EEG.chaninfo } );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'retrieve',3,'study',0); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'retrieve',1,'study',0); 
EEG = pop_prepPipeline(struct('lineNoiseChannels', [1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32], 'lineFrequencies', [60  120  180  240], 'Fs', 500, 'p', 0.01, 'fScanBandWidth', 2, 'taperBandWidth', 2, 'taperWindowSize', 4, 'pad', 0, 'taperWindowStep', 1, 'fPassBand', [0  250], 'tau', 100, 'maximumIterations', 10), 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Participant_C06_condition_2_prepped','savenew','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\PREP test\\Participant_C06_Trial_2_prepd.set','gui','off'); 
eeglab('redraw');
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  }, [-1  2], 'newname', 'Participant_C06_condition_2_prepped epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 7,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 7,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:32] , 'Participant_C06_condition_2_prepped epochs', 0, 'ydir',1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 7,'retrieve',3,'study',0); 
EEG = pop_prepPipeline(, 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','Participant_C06_Trial_1_prep','savenew','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\PREP test\\Participant_C06_Trial_1_prepd.set','gui','off'); 
eeglab('redraw');
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  }, [-1  2], 'newname', 'Participant_C06_Trial_1_prep epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 8,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 8,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Participant_C06_Trial_1_prep epochs', 0, 'ydir',1);
EEG = pop_eegfiltnew(EEG, [],0.5,3300,1,[],0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 8,'savenew','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\PREP_test\\PREP test\\Participant_C06_Trial_1_prepd_0.5_filter.set','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Participant_C06_Trial_1_prep epochs', 0, 'ydir',1);
EEG = pop_eegfiltnew(EEG, [],1,1650,1,[],1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 9,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Participant_C06_Trial_1_prep epochs', 0, 'ydir',1);
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, 5,'keepref','on');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 9,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Participant_C06_Trial_1_prep epochs', 0, 'ydir',1);
pop_saveh( EEG.history, 'fRESH_PREP.m', 'Z:\19_Carson_Berry\EEG\MATLAB\trunk\src\EEGLAB scripts\Processing history\');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 9,'retrieve',8,'study',0); 
eeglab redraw;
