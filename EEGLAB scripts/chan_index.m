function [ index ] = chan_index( EEG, chan_name )
%CHAN_INDEX returns the index of the channel name from an EEGLAB structure.Returns 0 if not found in
%struct. 
%

chan_labels = {EEG.chanlocs.labels}.'; %make a simple cell array out of the cell array within the EEG.chanlocs struct
index= find(strcmpi(chan_labels, char(chan_name))); %(case insensitive) compare strings to the electrode name we want (FZ).
          if(isempty(index))
             index=0;
          end

end

