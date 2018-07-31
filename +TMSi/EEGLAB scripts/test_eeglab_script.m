% EEGLAB history file generated on the 05-Jun-2018
% ------------------------------------------------
function test_eeglab_script(filename, pathname)
    EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
    fprintf('filename: %s, pathname: %s \n', filename, pathname);
    EEG = pop_loadset('filename',filename,'filepath',pathname);
    EEG = eeg_checkset( EEG );
    EEG = pop_chanevent(EEG, 19,'oper','X<254','edge','leading','edgelen',1,'duration','on','delchan','off','nbtype',1);
    EEG = eeg_checkset( EEG );
    EEG = pop_select( EEG,'nochannel',{'Digi' 'Saw'});
    EEG.setname='june_4_precap_LEPS_1-2';
    EEG = eeg_checkset( EEG );
    EEG=pop_chanedit(EEG, 'insert',4,'changefield',{4 'labels' 'ExG5'},'load',{'C:\\Users\\Kip\\Desktop\\Mariah\\19 channel locs_noice.ced' 'filetype' 'autodetect'},'delete',4);
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',filename,'filepath',pathname);
    EEG = eeg_checkset( EEG );
    EEG = pop_editset(EEG, 'setname', 'june_4_precap_LEPS_1-3', 'comments', strvcat('1) Data events imported and digi and saw removed','(step 1-2).',' ','2) Channel locs added and F3 removed (because we forgot to add it in again oops; step 3).'));
    EEG = eeg_checkset( EEG );
    EEG = pop_eegfiltnew(EEG, [],0.5,26400,1,[],0);
    EEG.setname='june_4_precap_LEPS_1-4';
    EEG = eeg_checkset( EEG );
    EEG = pop_eegfiltnew(EEG, [],50,1056,0,[],0);
    EEG = eeg_checkset( EEG );
    pop_eegplot( EEG, 1, 1, 1);
    EEG = pop_epoch( EEG, {  'chan19'  }, [-1  2], 'newname', 'june_4_precap_LEPS_1-5_e', 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-1000     0]);
    EEG = eeg_checkset( EEG );
    EEG = pop_reref( EEG, []);
    EEG.setname='june_4_precap_LEPS_1-6_e__averef';
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',filename,'filepath', pathname);
    EEG = eeg_checkset( EEG );
    EEG = pop_editset(EEG, 'setname', 'june_4_precap_LEPS_1-7_e_ICA__averef', 'comments', strvcat('Parent dataset: june_4_precap_LEPS_1-4',' ','Parent dataset "june_4_precap_LEPS_1-4": ----------','1) Data events imported and digi and saw removed','(step 1-2).',' ','2) Channel locs added and F3 removed (because we','forgot to add it in again oops; step 3).',' ','3) Filters added (0.5-50; step 4).',' ','4) Epochs extracted and baselines removed (step 5).',' ','5) Re-referenced to the average (step 6).',' ','6) Run ICA (step 7).'));
    EEG = eeg_checkset( EEG );
end