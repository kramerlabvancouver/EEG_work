% EEGLAB history file generated on the 29-Aug-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_fileio('/Users/oscarortizangulo/Desktop/Project 601 - Neurophysiological study of neuropathic pain after SCI/con_004/IB_CHEPS_con_004.vhdr');
EEG.setname='S04_IB';
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'lookup','/Users/oscarortizangulo/Downloads/eeglab14_1_1b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'S  2'  }, [-1  2], 'newname', 'S04_IB epochs', 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, [17 22] );
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, 1,30,3300,0,[],1);
EEG.setname='S04_IB epochs_final';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'extended',1,'interupt','on');
EEG = eeg_checkset( EEG );
figure; pop_timtopo(EEG, [-1000  1999], [NaN], 'ERP data and scalp maps of S04_IB epochs_final');
EEG = eeg_checkset( EEG );
pop_selectcomps(EEG, [1:30] );
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, [1   2   3  30], 0);
EEG = pop_loadset('filename','S04_IB.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\IB data from Oscar\\con_004\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
