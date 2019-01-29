function [max_val,max_index,min_val, min_index]=get_comp_peaks(EEG, comp, N2_index, P2_index)

mean_comp_activity=mean(EEG.icaact(comp,EEG.srate:EEG.srate*2,:),3); %Save the mean comp activity between 

     [max_val_glob, max_index_glob]=max(mean_comp_activity);
     [min_val_glob, min_index_glob]=min(mean_comp_activity);


     [max_val_inner, max_index_inner]=max(mean_comp_activity(N2_index:P2_index));
     [min_val_inner, min_index_inner]=min(mean_comp_activity(N2_index:P2_index));

     if(max_index_glob==(max_index_inner+N2_index-1))
         %max matches
         max_val=max_val_glob;
         max_index=max_index_glob;
         %min doesn't necessarily match
          min_val=min_val_glob;
          min_index=min_index_glob;
          
         fprintf('Comp %i had max between N2P2 \n', comp);
     elseif(min_index_glob==(min_index_inner+N2_index-1))
         %min matches
         min_val=min_val_glob;
         min_index=min_index_glob;
          %max doestn't necessarily match
         max_val=max_val_glob;
         max_index=max_index_glob;
         fprintf('Comp %i had min between N2P2 \n', comp);
         
     else
         max_val=max_val_inner;
         min_val=min_val_inner;
         max_index=max_index_inner+N2_index-1;
         min_index=min_index_inner+N2_index-1;
       fprintf('Defaulted to max/min in N2P2\n ');
                  
     end
     
     

end