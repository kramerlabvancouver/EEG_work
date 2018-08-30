%% Final PLotting Cz Pz - mastoid referenced and C3 C4 TO FZ + GFP ... 
    %Need to have all files organized into two (almost identical) studies. One
    %referenced to FZ, the other referenced to mastoids (ears). 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;



[STUDY ALLEEG] = pop_loadstudy('filename', 'CvL_mas_ref.study', 'filepath', 'Z:\19_Carson_Berry\Study Data\Edited\clean\Ear_ref');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

ALLEEG_mast = ALLEEG;
EEG_mast = EEG;

[STUDY ALLEEG] = pop_loadstudy('filename', 'CvL_fz_study.study', 'filepath', 'Z:\19_Carson_Berry\Study Data\Edited\clean\FZ_ref');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];


ALLEEG_Fz = ALLEEG;
EEG_Fz = EEG;


time_index_start= find(EEG(1).times == -250); % find the 250 ms pre trigger
time_index_end = find(EEG(1).times == 1000); %find the end

%% plotting everything
    for i=1:length(ALLEEG);
     
        %Get channel indices
        CZ_index= find(strcmpi({EEG(1,i).chanlocs.labels}.', 'CZ'));
        C3_index= find(strcmpi({EEG(1,i).chanlocs.labels}.', 'C3'));
        C4_index= find(strcmpi({EEG(1,i).chanlocs.labels}.', 'C4'));
        PZ_index= find(strcmpi({EEG(1,i).chanlocs.labels}.', 'PZ'));  
        
        
        cololims= [min(min(mean(ALLEEG_mast(1,i).data([CZ_index],:,:)))) max(max(mean(ALLEEG_mast(1,i).data([CZ_index],:,:))))];
        figlim = max(abs(cololims));
        figlims =[ -figlim figlim];
        
        filename = horzcat(ALLEEG_mast(i).setname,'.fig');
        
        h = figure;
        suptitle (ALLEEG_mast(1,i).setname);
        subplot(18,1,[1 2 3]);
        pop_erpimage(ALLEEG_mast(1,i),1, [CZ_index],[[]],'Cz',10,1,{},[],'' ,'yerplabel','\muV','erp','on','limits',[0 1000 NaN NaN NaN NaN NaN NaN] ,'cbar','on');
        subplot(18,1,[5 6 7]);
        pop_erpimage(ALLEEG_mast(1,i),1, [PZ_index],[[]],'Pz',10,1,{},[],'' ,'yerplabel','\muV','erp','on','limits',[0 1000 NaN NaN NaN NaN NaN NaN] ,'cbar','on');
        hold on;
        subplot(18,1,[9 10 11]);
        pop_erpimage(ALLEEG_Fz(1,i),1, [C3_index],[[]],'C3',10,1,{},[],'' ,'yerplabel','\muV','erp','on','limits',[0 1000 NaN NaN NaN NaN NaN NaN] ,'cbar','on');
        hold on;
        subplot(18,1,[13 14 15]);
        pop_erpimage(ALLEEG_Fz(1,i),1, [C4_index],[[]],'C4',10,1,{},[],'' ,'yerplabel','\muV','erp','on','limits',[0 1000 NaN NaN NaN NaN NaN NaN] ,'cbar','on');
        subplot(18,1,[17 18]);
        title('Global Field Power');
        plot(EEG_mast(1,i).times(time_index_start:time_index_end), std(mean(ALLEEG_mast(1,i).data(:,time_index_start:time_index_end,:),3)), 'k', 'linewidth', 2);
        xlabel('Time(ms)');
        ylabel('GFP');
        display('...done');
        
        savefig(h,filename,'compact'); 
        close(h);
        
    end


timtopo(EEG,'chan_locs',[0 1000],[200 300 400],'title',[13 15])
