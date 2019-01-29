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
    % type - the type of ICA you want to use: 
    % eg. 'pca' - principal component analysis 
    %     'ica' - 
% Outputs: Saved files, topoplots. 
% Files to be check manually for noise after processing and before ICA. 

function runica_folder(pathname)

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
          
          [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', [filename_text ' ' 'ICA']);
          EEG = eeg_checkset( EEG );
          %eeg.nbchan-1 is the second last eeg channel, digi.
         
          %Runica
          EEG = pop_runica(EEG,'extended',1 ,'interupt','on');%'PCA',22,'extended', 1,
          EEG = eeg_checkset( EEG );
%           
          %save
          EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
          EEG = eeg_checkset( EEG );
          
          [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
          eeglab redraw;
          
       fprintf('\n\n\n %i percent done ICA-ing folder \n\n\n',k/length_filename(1)*100);   
          
      end
      
      fprintf('All done Processing!');
end