function removed_epochs=get_removed_epochs(EEG)
%%find the index of removed epochs from each dataset (to ignore these
    %%from NRS data)
    
    temp_index=strfind(EEG.history, 'pop_rejepoch( EEG, [')+length('pop_rejepoch( EEG, [');
    
    removed_epochs=[];
    for k=1:length(temp_index) %repeat for every individual instance of rejecting (one or more) channels
        z=1;
        while(EEG.history(temp_index+z)~=']')
            
            z=z+1;
        end
        l=length(str2num(EEG.history(temp_index:temp_index+z-1)));
        
        if(k==1)
            removed_epochs(1:l)=str2num(EEG.history(temp_index:temp_index+z-1));
            ll=l+1;
        else
            removed_epochs(ll:l+ll)=str2num(EEG.history(temp_index:temp_index+z-1));
        end
    end
    
    
    
end