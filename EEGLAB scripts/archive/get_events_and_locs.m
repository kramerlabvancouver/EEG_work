%A function to cheat being good code: 

function get_events_and_locs(pathname)

%A script that uses EEGLAB's computational engine to process .set files.
% Processing includes: 
% 1. Importing Events from Digi
% 2. Importing electrode Locations from file
% 3. Filtering highpass (0.5 Hz), lowpass (40 Hz)
% 4. Epoching based on events
% 5. Rereferencing to average
% 6. Displaying Topoplot of the epoch average for each electrode
% 7. Saves (overwrites) the files in the folder where they are located. 
% Inputs: pathname - the directory location of the folder holding the .set
% and .fdt files you want to process. Eg. 'Z:\19_Carson_Berry\EEG':
% Outputs: Saved files, topoplots. 
% Files to be check manually for noise after processing and before ICA. 

file_struct_list = dir([pathname filesep() '*.set']);  %% get list of .set files in the pathname specified

filename_cell_list = {file_struct_list.name};  %% extract the filenames into a cellarray

filename_list=deblank(char(filename_cell_list));

    length_filename=size(filename_list);
      [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  
      
      for k=1:length_filename(1)
          %subject = file_struct_list.name  %% this iterates over the elements of the cell array, one-by-one, setting the `filename` variable like a loop variable
          
          % save(debugging_variables);
          
          filename=deblank(filename_list(k, :));
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
                  if(EEG.nbchan==32)
                      EEG = pop_chanedit(EEG, 'load',{'Z:\19_Carson_Berry\EEG\MATLAB\trunk\src\cap locations\32_channel_locs_noice.ced' 'filetype' 'autodetect'}); %if this program is being run on a MAC- this location file path will need to use \\ instead of \
                      EEG = eeg_checkset( EEG );                    
                  else
                      fprintf('Error: unknown number of channels (%i) in %s', EEG.nbchan, filename);
                      EEG=pop_chanedit(EEG, 'lookup','C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');

                  end
              end
          end
          
          figure; pop_plottopo(EEG, [1:EEG.nbchan] , strcat(filename_text, '_epoched_rereferenced'), 0, 'ydir',1); %plot topomap of all the electrodes
          
          
          %%PREP_pipeline
          %resample to 1000 Hz
          EEG = pop_resample( EEG, 1000);
          EEG = pop_prepPipeline(EEG, struct('detrendChannels', 1:EEG.nbchan, 'detrendCutoff', 1, 'detrendStepSize', 0.02, 'detrendType', 'High Pass', 'lineNoiseChannels', 1:EEG.nbchan, 'lineFrequencies', 60:60:480, 'Fs', 1000, 'p', 0.01, 'fScanBandWidth', 2, 'taperBandWidth', 2, 'taperWindowSize', 4, 'pad', 0, 'taperWindowStep', 1, 'fPassBand', [0  500], 'tau', 100, 'maximumIterations', 10));
          
          %%Filter again
          EEG = pop_eegfiltnew(EEG, [],1,26400,1,[],0); %highpass filter from 1 Hz upwards
                  
          %%Epoch data
          EEG = pop_epoch( EEG, {  Event_chan  }, [-1  2], 'newname', [filename_text '_PREPd' '_epoched'], 'epochinfo', 'yes');
          EEG = pop_rmbase( EEG, [-1000     0]);
          
          %% save
          EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
          EEG = eeg_checkset( EEG );
          [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
          eeglab redraw;
          
      end
      
      fprintf('All done Processing!');
end