% EEGLAB history file generated on the 20-Aug-2018
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','Participant_C07_Trial_1.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\RAW DATA\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_chanevent(EEG, 32,'oper','X<255','edge','leading','edgelen',1,'duration','on','delchan','off','delevent','off','nbtype',1);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'Digi' 'Saw'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG=pop_chanedit(EEG, 'load',{'Z:\\19_Carson_Berry\\EEG\\MATLAB\\trunk\\src\\cap locations\\31_channel_locs_missing_F3.ced' 'filetype' 'autodetect'});
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = pop_eegfiltnew(EEG, [],0.5,26400,1,[],0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = pop_eegfiltnew(EEG, [],40,1320,0,[],0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'chan32'  }, [-1  2], 'newname', 'Continuous Data TMSi Name: Participant_C07_Trial_1 epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_reref( EEG, []);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'saveold','Z:\\19_Carson_Berry\\EEG\\MATLAB\\data\\test\\C07_trial_1.set','gui','off'); 
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_rejepoch( EEG, [1 2] ,0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'extended',1,'interupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
figure; pop_plottopo(EEG, [1:31] , 'Continuous Data TMSi Name: Participant_C07_Trial_1 epochs', 0, 'ydir',1);
EEG = eeg_checkset( EEG );
pop_topoplot(EEG,0, [1:31] ,'Continuous Data TMSi Name: Participant_C07_Trial_1 epochs',[6 6] ,0,'electrodes','on');
EEG = eeg_checkset( EEG );
pop_selectcomps(EEG, [1:31] );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_eegthresh(EEG,1,[1:31] ,-50,50,-1,1.9997,2,0);
EEG = pop_eegthresh(EEG,1,[1:31] ,-100,100,-1,1.9997,2,0);
EEG = pop_jointprob(EEG,1,[1:31] ,5,5,0,0,0,[],0);
EEG = pop_jointprob(EEG,1,[1:31] ,15,5,0,0,'set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''mantrial''), ''string'', num2str(sum(EEG.reject.rejmanual)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''threshtrial''), ''string'', num2str(sum(EEG.reject.rejthresh)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''freqtrial''), ''string'', num2str(sum(EEG.reject.rejfreq)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''consttrial''), ''string'', num2str(sum(EEG.reject.rejconst)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''enttrial''), ''string'', num2str(sum(EEG.reject.rejjp)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''kurttrial''), ''string'', num2str(sum(EEG.reject.rejkurt)));',[],0);
EEG = pop_rejkurt(EEG,1,[1:31] ,5,5,0,0,0,[],0);
EEG = pop_jointprob(EEG,1,[1:31] ,3,5,0,0,0,[],0);
EEG = pop_jointprob(EEG,1,[1:31] ,3,5,0,0,'set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''mantrial''), ''string'', num2str(sum(EEG.reject.rejmanual)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''threshtrial''), ''string'', num2str(sum(EEG.reject.rejthresh)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''freqtrial''), ''string'', num2str(sum(EEG.reject.rejfreq)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''consttrial''), ''string'', num2str(sum(EEG.reject.rejconst)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''enttrial''), ''string'', num2str(sum(EEG.reject.rejjp)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''kurttrial''), ''string'', num2str(sum(EEG.reject.rejkurt)));',[],0);
EEG = pop_rejspec( EEG, 1,'elecrange',[1:31] ,'method','multitaper','threshold',[-25 25] ,'freqlimits',[0 50] ,'eegplotcom','set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''mantrial''), ''string'', num2str(sum(EEG.reject.rejmanual)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''threshtrial''), ''string'', num2str(sum(EEG.reject.rejthresh)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''freqtrial''), ''string'', num2str(sum(EEG.reject.rejfreq)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''consttrial''), ''string'', num2str(sum(EEG.reject.rejconst)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''enttrial''), ''string'', num2str(sum(EEG.reject.rejjp)));set(findobj(''parent'', findobj(''tag'', ''rejtrialraw''), ''tag'', ''kurttrial''), ''string'', num2str(sum(EEG.reject.rejkurt)));','eegplotplotallrej',2,'eegplotreject',0);
EEG = pop_rejtrend(EEG,1,[1:31] ,12000,100,0.3,2,0);
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
eeglab redraw;
