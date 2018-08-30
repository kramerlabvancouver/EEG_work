%A script that uses EEGLAB's computational engine to present figures to clean .set files that have already had ICA run.
% Processing includes: 
% 1. Opening file
% 2. Plotting component maps 
% 3.Checking if limits have been reached;  
% 4. -100 to 100 uV on any epoch (User will choose to mark epochs or not)
% 5. Plotting joint probability (+/- 4 SD)
% 6. Saves marked epochs 



function cleaning_folder(pathname)

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
          
          [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET);
          EEG = eeg_checkset( EEG );
          
          %rereference to average 
          EEG = pop_reref( EEG, []); %rereference to average
          [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
          EEG = eeg_checkset( EEG );
         
          % step 4- checking if limits have been reached (100 uV) 
          EEG = pop_eegthresh(EEG,1,[1:EEG.nbchan] ,-100,100,-1,1.9997,2,0);
          [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
          EEG = eeg_checkset( EEG );
       
          %Step 5 - checking if channels have exceeded 4 SD
          EEG = pop_jointprob(EEG,1,[1:EEG.nbchan] ,4,4,0,0,0,[],0);
  
          [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
          EEG = eeg_checkset( EEG );
          
          %save
          EEG = pop_saveset( EEG, 'savemode','resave');
          
          [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
          eeglab redraw;
          
      end
      
      fprintf('All done Processing!');
end