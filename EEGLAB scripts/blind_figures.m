function  blind_figures(pathname)
%Blind Figures
% A function that plots the ERP latencies of interest for an anonymous
% reviewer to measure. 
%The latencies of interest are induced by painful stimuli and are: 
% N1: Contralateral electrode to stimulation (ie C3 if right arm, C4 if
% left arm stimulated) vs FZ. 
%
% N2P2: CZ vs Average(M1,M2)
%
%Inputs: Folder containing the saved .set and .fdt files. 
%Dominant hand: left or right

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
         
          save_name = horzcat(filename_text,'.fig');  %name file to save
                  
          [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', 'raw');
          EEG = eeg_checkset( EEG );
          
                   
          num_chan=EEG.nbchan; 
         
          
          % To plot the N1 latencies we will rereference to FZ
          chan_labels = {EEG.chanlocs.labels}.'; %make a simple cell array out of the cell array within the EEG.chanlocs struct
          FZ_index= find(strcmpi(chan_labels, char('FZ'))); %(case insensitive) compare strings to the electrode name we want (FZ).
          C3_index= find(strcmpi(chan_labels, 'C3')); 
          
          %rereference to FZ
          EEG = pop_reref( EEG, FZ_index,'keepref','on');
          [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
          EEG = eeg_checkset( EEG );
          
          % plotting Figure
          figure;
          subplot(3,1,1);
          pop_plottopo(EEG, C3_index , [EEG.filename ' ' 'C3 vs FZ'], 0, 'ydir',1);
          %hold on;
          EEG = eeg_checkset( EEG );
     
          
          
          M1_index= find(strcmpi(chan_labels, 'M1'));
          M2_index= find(strcmpi(chan_labels, 'M2'));
          CZ_index= find(strcmpi(chan_labels, 'CZ'));
          
         if(~isempty(M1_index)&&~isempty(M2_index))
               EEG = pop_reref( EEG, [M1_index M2_index] ,'keepref','on'); %rereference to M1/M2
              [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
              EEG = eeg_checkset( EEG );
              %plot Cz vs M1/m2
              fprintf('Plotting with M1/M2 references\n');
              subplot(3,1,3);
              pop_plottopo(EEG, CZ_index, [filename_text ' ' ' CZ vs M1/M2-Ref'], 0, 'ydir',1);
                       
                   
         elseif(~isempty(M1_index)&&isempty(M2_index)) % if only M2 index is empty
                EEG = pop_reref( EEG, [M1_index] ,'keepref','on'); %rereference to M1/M2
              [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
              EEG = eeg_checkset( EEG );
              %plot Cz vs M1/m2
              fprintf('Plotting with M1 references\n');
               subplot(3,1,3); 
               pop_plottopo(EEG, CZ_index , [filename_text ' ' ' CZ vs M1-Ref'], 0, 'ydir',1);
              eeglab redraw;
             
                
         elseif(isempty(M1_index)&&~isempty(M2_index)) %if only M1 index is empty
                EEG = pop_reref( EEG, [M2_index] ,'keepref','on'); %rereference to M1/M2
              [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
              EEG = eeg_checkset( EEG );
              %plot Cz vs M1/m2
              fprintf('Plotting with M2 references\n');
               subplot(3,1,3); pop_plottopo(EEG, CZ_index , [filename_text ' ' 'CZ vs M2-Ref'], 0, 'ydir',1);
              eeglab redraw;
             
        
         elseif(isempty(M1_index)&&isempty(M2_index))   %referencing to average because M1/M2 are not
                      %recorded. 
              EEG = pop_reref( EEG, []); %rereference to average
              [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
              EEG = eeg_checkset( EEG );
              %plot Cz vs M1/m2
              fprintf('Plotting average Ref\n');
               subplot(3,1,3); pop_plottopo(EEG, CZ_index , [filename_text ' ' 'CZ vs Average Ref'], 0, 'ydir',1);
              eeglab redraw;
              
            fprintf('Missing both mastoids in %s file. Referencing to avg \n', filename_text);
        
                    
         else fprintf('Unexpected number of channels (%i), please review %s \n', num_chan, EEG.filename);
           
         end
                    
      end
      
      fprintf('All done Plotting!');
end


