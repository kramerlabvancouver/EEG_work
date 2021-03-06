% EEGLAB history file generated on the 12-Jul-2018
% ------------------------------------------------
%A function to process 28 (supposed to be 32 standard) channel EEG data from the 'smallcap'. It has
%several broken electrodes, including F3 and P8. M1 and M2 rarely work on
%the mastoids, but may work well on the ears.... This function assumes no
%M1, M2 electrode use. This function is called from
%load_and_run_script_eeglab and is used to process each file in a folder. 
function[ALLEEG]= process_smallcap(filename, pathname, ALLEEG, CURRENTSET)
[~,filename_text,~]= fileparts(strcat(pathname,'\',filename));

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_loadset('filename',filename,'filepath',pathname); %loads the specified file into eeglab

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', 'raw');
EEG = eeg_checkset( EEG );
%eeg.nbchan-1 is the second last eeg channel, digi. 

EEG = pop_chanevent(EEG, EEG.nbchan-1,'oper','X<255','edge','leading','edgelen',1,'duration','on','delchan','off','delevent', 'on','nbtype',1);
EEG = eeg_checkset( EEG );
Event_chan=strcat('chan',int2str(EEG.nbchan-1));

EEG = pop_select( EEG,'nochannel',{'Digi' 'Saw'});  %remove digi and saw channels
EEG.setname = strcat(filename_text, '_no_digi');          %sets name to filename with '_no_digi' appended to end
EEG = eeg_checkset( EEG );
%this line will work on any kramer computer networked to the z: drive. 
    if(EEG.nbchan==29)
        EEG = pop_chanedit(EEG, 'load',{'Z:\19_Carson_Berry\EEG\MATLAB\trunk\src\cap locations\29 channel, missing f3, m1, m2.ced' 'filetype' 'autodetect'}); %if this program is being run on a MAC- this location file path will need to use \\ instead of \
        EEG = eeg_checkset( EEG );
    else
        if(EEG.nbchan==31)
        EEG = pop_chanedit(EEG, 'load',{'Z:\19_Carson_Berry\EEG\MATLAB\trunk\src\cap locations\31_channel_locs_missing_F3.ced' 'filetype' 'autodetect'}); %if this program is being run on a MAC- this location file path will need to use \\ instead of \
        EEG = eeg_checkset( EEG );    
        else
            fprintf('Error: unknown number of channels (%i) in %s', EEG.nbchan, filename);
        end
    end
% EEG = pop_eegfiltnew(EEG, [],0.5,26400,1,[],0); %highpass filter from 0.5 Hz upwards
% EEG.setname=strcat(filename_text,'_highpass');
% EEG = eeg_checkset( EEG );

EEG = pop_eegfiltnew(EEG, [],40,1056,0,[],0); %lowpass filter at 40 Hz (cutoff at 45 Hz)
EEG = eeg_checkset( EEG );

EEG = eeg_checkset( EEG );
%EEG = pop_saveset( EEG, 'filename',filename_text,'filepath',pathname);

EEG = pop_select( EEG,'nochannel',{'p8'});    %remove p8 cuz it's noisy. 
EEG = eeg_checkset( EEG );

              
EEG = pop_epoch( EEG, {  Event_chan  }, [-1  2], 'newname', strcat(filename_text,'_epoched'), 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );

EEG = pop_rmbase( EEG, [-1000     0]);

EEG = pop_reref( EEG, []);
EEG.setname=strcat(filename_text,'_reref');


figure; pop_plottopo(EEG, [1:EEG.nbchan] , strcat(filename_text, '_epoched_rereferenced'), 0, 'ydir',1); %plot topomap of all the electrodes

%Runica 
%EEG = pop_runica(EEG, 'extended',1,'interupt','on');
EEG = eeg_checkset( EEG );

%save
%EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
EEG = eeg_checkset( EEG );
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
eeglab redraw;

end