function fz_reference( pathname)
%REREFERENCE_FOLDER A function that rereferences all of the .set EEGLAB
%files to the channels denoted by the objects found in the reference_set input 

%   Inputs: 
%       pathname- the system location of the folder containing the files
%       you wish to rereference 
%       
%      

%% Get files of type '.set'
file_struct_list = dir([pathname filesep() '*.set']);  %% get list of .set files in the pathname specified
filename_cell_list = {file_struct_list.name};  %% extract the filenames into a cellarray
filename_list=deblank(char(filename_cell_list));
length_filename=size(filename_list);

%%Start up EEGLAB
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  
      
%iterate through files
      for k=1:length_filename(1)
          %subject = file_struct_list.name  %% this iterates over the elements of the cell array, one-by-one, setting the `filename` variable like a loop variable
          
          % save(debugging_variables);
          
          filename=deblank(filename_list(k, :));
          [~,filename_text,~]= fileparts(strcat(pathname,'\',filename));
          
          EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
          EEG = pop_loadset('filename',filename,'filepath',pathname); %loads the specified file into eeglab
          
          [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', 'raw');
          EEG = eeg_checkset( EEG );
          
          
          % To plot the N1 latencies we will rereference to FZ
          chan_labels = {EEG.chanlocs.labels}.'; %make a simple cell array out of the cell array within the EEG.chanlocs struct
          FZ_index= find(strcmpi(chan_labels, char('FZ'))); %(case insensitive) compare strings to the electrode name we want (FZ).
          
          
          %rereference to FZ
          EEG = pop_reref( EEG, FZ_index,'keepref','on');
          [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
          EEG = eeg_checkset( EEG );
          EEG.setname=strcat(filename_text,'_FZ_ref');
          
          %save
          EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
          EEG = eeg_checkset( EEG );
          [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
          eeglab redraw;
          
      end
      
      fprintf('All done rereferencing!');
end




