% EEGLAB history file generated on the 12-Jul-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_loadset('filename','Participant_C01_Trial_2.set','filepath','C:\\Users\\Kip\\Desktop\\Mariah\\(2) EDITED DATA\\(1) Legit Trials\\C01\\Condition 2\\');
EEG = eeg_checkset( EEG );
EEG = pop_chanevent(EEG, 32,'oper','X<255','edge','leading','edgelen',1,'delchan','off','nbtype',1);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_select( EEG,'nochannel',{'Digi' 'Saw'});
EEG.setname='Participant_C01_condition_2_1-2';
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG=pop_chanedit(EEG, 'insert',5,'changefield',{5 'labels' 'ExG5'},'load',{'C:\\Users\\Kip\\Desktop\\Mariah\\32_channel_locs_noice.ced' 'filetype' 'autodetect'},'delete',5);
EEG = eeg_checkset( EEG );
EEG = pop_editset(EEG, 'setname', 'Participant_C01_condition_2_1-3');
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','Participant_C01_condition_2_1-3.set','filepath','C:\\Users\\Kip\\Desktop\\Mariah\\(2) EDITED DATA\\(1) Legit Trials\\C01\\Condition 2\\');
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, [],0.5,26400,1,[],0);
EEG.setname='Participant_C01_condition_2_1-4';
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, [],50,1056,0,[],0);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_select( EEG,'nochannel',{'p8'});
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_epoch( EEG, {  'chan32'  }, [-1  2], 'newname', 'Participant_C01_condition_2_1-5_e', 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
EEG.setname='Participant_C01_condition_2_1-6_e';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
