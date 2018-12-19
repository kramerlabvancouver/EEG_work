function m_reference( pathname)
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

avg_count=0; %init avg_count that counts the instances where both mastoids are not available. 
      
%iterate through files
      for k=1:length_filename(1)
          %subject = file_struct_list.name  %% this iterates over the elements of the cell array, one-by-one, setting the `filename` variable like a loop variable
          
          % save(debugging_variables);
          
          filename=deblank(filename_list(k, :));
          [~,filename_text,~]= fileparts(strcat(pathname,'\',filename));
          
          EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
          EEG = pop_loadset('filename',filename,'filepath',pathname); %loads the specified file into eeglab
          
          [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET);
          EEG = eeg_checkset( EEG );
          
          
          num_chan=EEG.nbchan; % get number of channels
          
          % To plot the N1 latencies we will rereference to FZ
          chan_labels = {EEG.chanlocs.labels}.'; %make a simple cell array out of the cell array within the EEG.chanlocs struct
                
                          %To plot the N2P2 latencies we will reference to m1/m2
             M1_index= find(strcmpi(chan_labels, 'M1'));
             M2_index= find(strcmpi(chan_labels, 'M2'));                                

             if((isempty(M1_index)==0)&&(isempty(M2_index)==0))
                 %referencing to M1 and M2
                 EEG = pop_reref( EEG, [M1_index M2_index] ,'keepref','on'); %rereference to M1/M2
                 [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
                 EEG = eeg_checkset( EEG );
                 EEG.setname=strcat(filename_text,'_Ear_ref');
                 
                 %save
                 EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
                 EEG = eeg_checkset( EEG );
                 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
                 eeglab redraw;
                 
                 
             else
                 %referencing to average because M1/M2 are not
                 %recorded.
                 
                 EEG = pop_reref( EEG, []); %rereference to average
                 [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
                 EEG = eeg_checkset( EEG );
                 EEG.setname=strcat(filename_text,'_Avg_ref');
           
                 EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
                 EEG = eeg_checkset( EEG );
                 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
                 eeglab redraw;
                 avg_count=avg_count+1;               
                
             end
             
            
      end
      fprintf('Number of recordings without mastoids: %i \n', avg_count);
             
      fprintf('All done Rereferencing!');
end





