%A script that uses EEGLAB's computational engine to create dipoles from IC's.
% Processing includes: 
% 

function dipole_folder(pathname)

file_struct_list = dir([pathname filesep() '*.set']);  %% get list of .set files in the pathname specified
filename_cell_list = {file_struct_list.name};  %% extract the filenames into a cellarray
filename_list=deblank(char(filename_cell_list));
    length_filename=size(filename_list);
    
      [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  
      
      for k=1:length_filename(1)
          %subject = file_struct_list.name  %% this iterates over the elements of the cell array, one-by-one, setting the `filename` variable like a loop variable
                    
          filename=deblank(filename_list(k, :));
          [~,filename_text,~]= fileparts(strcat(pathname,'\',filename));
          
          EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
          EEG = pop_loadset('filename',filename,'filepath',pathname); %loads the specified file into eeglab
          
         
          EEG = eeg_checkset( EEG );
          EEG = pop_dipfit_settings( EEG, 'hdmfile','C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard_BESA.mat','coordformat','Spherical','mrifile','C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\avg152t1.mat','chanfile','C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','chansel',[1:EEG.nbchan] );
          EEG = pop_multifit(EEG, [1:size(EEG.icaweights,1)] ,'threshold',100,'dipplot','on','plotopt',{'normlen' 'on'});
          pop_dipplot( EEG,[1:EEG.nbchan] ,'mri','C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\avg152t1.mat','summary','on','num','on','projimg','on','projlines','on','normlen','on');
          % === History not supported for manual dipole fitting ===
         % pop_topoplot(EEG,0, [1:EEG.nbchan] ,EEG.setname,[5 6] ,1,'electrodes','on');
          
          
              
               %save new dipole info
          EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
          EEG = eeg_checkset( EEG );
          [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
          eeglab redraw;
          
      fprintf('All done Processing %s!', filename_text);
          
      end
      
      fprintf('All done Processing %s!', pathname);
end