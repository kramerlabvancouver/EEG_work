

%%A function that produces a matrix, chan_presence, of the presence of all 32 channels in the
% locations of cleaned EEG .set files. This matrix will be AND-ed to a
% single 32x1 vector which will inform the minimum subset of channels that
% may be appropriate for analysis in LORETA. 
function chan_presence= get_location_matrix(pathname)

file_struct_list = dir([pathname filesep() '*.set']);  %% get list of .set files in the pathname specified

filename_cell_list = {file_struct_list.name};  %% extract the filenames into a cellarray

filename_list=deblank(char(filename_cell_list));

    length_filename=size(filename_list);

chan_presence=zeros(32,length_filename(1)); %allocate size of chan_presence matrix 

%channel list for CHEPS vs LEPS 64 Channel ANT neuro cap
%channel_list=transpose({'FP1' 'FPZ' 'FP2' 'F7' 'F3' 'FZ' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'M1' 'T7' 'C3' 'CZ' 'C4' 'T8' 'M2' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'PZ' 'P4' 'P8' 'POZ' 'O1' 'OZ' 'O2' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FC3' 'FC7' 'FC4' 'C5' 'C1' 'C2' 'C6' 'CP3' 'CPZ' 'CP4' 'P5' 'P1' 'P2' 'P6' 'PO5' 'PO3' 'PO4' 'PO6' 'FT7' 'FT8' 'TP7' 'TP8' 'PO7' 'P08'});

%Channel list for IB vs NB caps
                       % 1      2    3    4     5   6    7     8    9 
channel_list=transpose({'FP1' 'FP2' 'F7' 'F3' 'FZ' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'CZ' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'PZ' 'P4' 'P8' 'PO9' 'O1' 'OZ' 'O2' 'PO10'});

chan_number=32;




%start EEGLAB
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for i=1:length_filename(1)
    
  %%Open file in EEGlab
    filename=deblank(filename_list(i,:));
    [~,filename_text,~]= fileparts(strcat(pathname,'\',filename));
    EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
    EEG = pop_loadset('filename',filename,'filepath',pathname); %loads the specified file into eeglab
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', [filename_text 'ref_mas']);
    EEG = eeg_checkset( EEG );
    
    %%This loop aint pretty but it works. 
    %Finds index of matching channel name in Channel_list (good)
    %IndexC=strfind(channel_list(k),{EEG.chanlocs(k).labels}.');
      for k=1:chan_number %iterate over the channel list. 
    
          for j=1:EEG.nbchan
              if(strcmpi({EEG.chanlocs(j).labels}.',channel_list(k))&&~chan_presence(k,i)) %write to chan_presence if match
                  
                  chan_presence(k,i)=strcmpi({EEG.chanlocs(j).labels}.',channel_list(k));
                  
                  
                  
                  
              elseif(~strcmpi({EEG.chanlocs(j).labels}.',channel_list(k))&&chan_presence(k,i))
                  
                  break;
                  
                  %in case of a non-match %if current match is not positive, and we're checking number 5 ('FZ' for IBvsNB, 'F3' for ChepsvsLeps)
                  
              end
              
              
          end
          
      end
      
end

        
%         chan_proportion(:,2)=cell(sum(chan_presence, 2)/length_filename(1)); %finds the sum of instances in the channel 
%      
%         figure; bar(categorical(channel_list(1:32)),chan_proportion); % plots a shitty bar graph for those of you who have the labels memorized.

%Add channel Labels to chan_presence
chan_presence= [ channel_list num2cell(chan_presence)]; 
filename_cell_list_temp= [ ' ' filename_cell_list];
chan_presence= vertcat(filename_cell_list_temp, chan_presence(:,1:end));
end
       
        

