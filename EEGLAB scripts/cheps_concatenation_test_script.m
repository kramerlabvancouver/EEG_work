%%a test run of concatenating NRS data for by subjects Specifically for
%%CHEPS (as we may see a more pronounced p1 comp) 
ALLEEG_cheps=ALLEEG; 

c_indx=1;
for(ind=1:length(ALLEEG_cheps))
    
    if(ALLEEG_cheps(ind).condition=='1'||ALLEEG_cheps(ind).condition=='2')
       
        cheps_ind(c_indx)=ind; %save the ALLEEG file indexes that belong to CHEPS 
        c_indx=c_indx+1;
    end
    
end 

cheps_EEG=pop_mergeset(ALLEEG_cheps, cheps_ind, 0); 

 cheps_EEG = pop_runica(cheps_EEG ,'pca', 22, 'interupt','on');%'PCA',22,'extended', 1
 EEG=cheps_EEG;
 
 
 %%now leps....
 l_indx=1;
 for(ind=1:length(ALLEEG_cheps))
    
    if(ALLEEG_cheps(ind).condition=='3'||ALLEEG_cheps(ind).condition=='4')
       
        leps_ind(l_indx)=ind; %save the ALLEEG file indexes that belong to CHEPS 
        l_indx=l_indx+1;
    end
    
 end 

leps_EEG=pop_mergeset(ALLEEG_cheps, leps_ind, 0); 
 leps_EEG = pop_runica(leps_EEG ,'pca', 22, 'interupt','on');%'PCA',22,'extended', 1
EEG=leps_EEG;