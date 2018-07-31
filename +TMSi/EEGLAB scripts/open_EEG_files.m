%A script that opens all files in a folder in EEGLAB for manual inspection
%by a trained user prior to running ICA. 
% Inputs: pathname - the directory location of the folder holding the .set
% and .fdt files you want to process. Eg. 'Z:\19_Carson_Berry\EEG':
% Outputs: Saved files


function open_EEG_files(pathname)

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
          
%           [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', 'raw');
%           EEG = eeg_checkset( EEG );
%           
%          
%           %save
%           EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
%           EEG = eeg_checkset( EEG );
          [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG);
          
          eeglab redraw;
         % EEG=ALLEEG(CURRENTSET);
      end
          EEG = eeg_retrieve( ALLEEG, CURRENTSET );
          eeglab redraw;
      
      fprintf('All done Processing!');
      [ALLEEG EEG CURRENTSET ALLCOM] = eeglab
end