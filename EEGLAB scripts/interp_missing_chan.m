function [ done ] = interp_missing_chan( pathname )
%%A function that interpolates all the missing channels in each EEG dataset
% between chan 1:32. 

%%a 2d char array containing the files ending with .set in the folder
%pathname. 
filename_list=get_file_list(pathname,'set');

%%an array with the full 64 channel list. We will only be using 1:32
channel_list={'FP1' 'FPZ' 'FP2' 'F7' 'F3' 'FZ' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'M1' 'T7' 'C3' 'CZ' 'C4' 'T8' 'M2' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'PZ' 'P4' 'P8' 'POZ' 'O1' 'OZ' 'O2' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FC3' 'FC7' 'FC4' 'C5' 'C1' 'C2' 'C6' 'CP3' 'CPZ' 'CP4' 'P5' 'P1' 'P2' 'P6' 'PO5' 'PO3' 'PO4' 'PO6' 'FT7' 'FT8' 'TP7' 'TP8' 'PO7' 'P08'};
%channel_list=transpose(channel_list);


%get the number of files in the folder 
length_filename=size(filename_list);

chan_presence=zeros(32,length_filename(1));
mroot=matlabroot; %get matlab root

%start EEGLAB
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for i=1:length_filename(1)
    
    %%Open appropriate file in EEGlab. 
    filename=deblank(filename_list(i, :));
    [~,filename_text,~]= fileparts(strcat(pathname,'\',filename));
    EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
    EEG = pop_loadset('filename',filename,'filepath',pathname); %loads the specified file into eeglab
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', [filename_text ' interp']);
    EEG = eeg_checkset( EEG );
    
    
    %Get cell array of all the channels in use
   % chan_labels = {EEG.chanlocs.labels}.';
    
   %%Series of loops to populate chan_presence
    %Finds index of matching channel name in Channel_list (good)
    %IndexC=strfind(channel_list(k),{EEG.chanlocs(k).labels}.');
    for k=1:32 %iterate over the channel list.
        
        for j=1:EEG.nbchan
            if(strcmpi({EEG.chanlocs(j).labels}.',channel_list(k))&&~chan_presence(k,i)) %write to chan_presence if match
                
                chan_presence(k,i)=strcmpi({EEG.chanlocs(j).labels}.',channel_list(k));
                
            elseif(~strcmpi({EEG.chanlocs(j).labels}.',channel_list(k))&&chan_presence(k,i)) %if current match is not a match, but somthing has previously matched at this index
                %increment j index to EEG.nbchan to skip the rest of the
                %loop
                break;
                
            else   %in case of a non-match do nothing
            end
        end
    end
    
    %%Locate which channels are missing (seen as a zero in the 'x' row of the i column) 
    chan_missing=find(~chan_presence); %index of all missing channels. 
    chan_to_add=(chan_missing<=32*i)&(chan_missing>32*(i-1)); %a 1D array of 1's and 0's if it's appropriate to 
    chan_to_add=mod(chan_to_add.*chan_missing,32*(i-1)); %convert the relevant values to indices of value- need a way to get rid of zeroes. 
    replacement_array=chan_to_add(chan_to_add~=0); %get rid of all the zero entries for this dataset
   
    backup_locs=EEG.chanlocs; %SAVE A backup of the chan_locs. 
    load good_chanlocs.mat;
    
    %make all electrode locations uppercase to prevent any inconsistencies 
    good_chanlocs=upper(good_chanlocs.labels');
    EEG.chanlocs=upper(backup_locs.labels');
    
    
    if(~isempty(replacement_array)) % if there are no files to interpolate, skip to the next file. 
    
        %%Add back missing channels! 
    for x=1:size(replacement_array)    
        
%          EEG=pop_chanedit(EEG, 'insert',replacement_array(x),... %add back a new channel in the correct place
%              'changefield',{(replacement_array(x)) 'labels' char(channel_list(replacement_array(x)))},... %change the name of the new electrode location to it's proper place
%              'lookup',[mroot '\\toolbox\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp']); %lookup the value of this replacement. 
%          
         %%INTERPOLATE Missing channels 
         
         fprintf('Added %s channel \n\n ...Interpolating\n',char(channel_list(replacement_array(x))));
         EEG=pop_interp(EEG, good_chanlocs, 'spherical');
        
    end
        
     EEG.comments = pop_comments(EEG.comments,'',['Removed channels were added back from nothing and interpolated...'  char(channel_list(replacement_array(:)))],1);
    
    %%save dataset before moving onto next one!
     EEG = pop_saveset( EEG, 'filename',filename_text,'filepath', pathname);
     EEG = eeg_checkset( EEG );
     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET); %copy changes to alleeg
     eeglab redraw;
    end
end

done=1;
disp('done processing');
end

