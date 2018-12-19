%%make nice ERP plots of CZ, and contralateral (N1P1) electrode. 

%ALLEEG_mast
%ALLEEG_Fz





time_index_start= find(EEG(1).times == -250); % find the 250 ms pre trigger
time_index_end = find(EEG(1).times == 1000); %find the end

% plotting each trial recording 
for i=1:length(ALLEEG)
    
    %Get channel indices
    CZ_index(i)= find(strcmpi({ALLEEG_mast(i).chanlocs.labels}.', 'CZ'));
    try
        if(strcmp(ALLEEG_Fz(i).subject,'C15'))
            C3_index(i)= find(strcmpi({ALLEEG_Fz(1,i).chanlocs.labels}.', 'C4'));
        else
        C3_index(i)= find(strcmpi({ALLEEG_Fz(1,i).chanlocs.labels}.', 'C3'));
        end
        
    catch
        
        warning('missing c3');
        C3_index(i)=NaN;
    continue;
    end
    
    %C4_index(i)= find(strcmpi({ALLEEG_Fz(1,i).chanlocs.labels}.', 'C4'));
    
    CZ_data(i,:)=mean(ALLEEG_mast(1,i).data([CZ_index(i)],:,:),3);
    C3_data(i,:)=mean(ALLEEG_Fz(1,i).data([C3_index(i)],:,:),3);
    %C4_data(i,:)=mean(ALLEEG_Fz(1,i).data([C4_index(i)],:,:),3);
    
%             cololims= [min(min(mean(ALLEEG_mast(1,i).data([CZ_index],:,:)))) max(max(mean(ALLEEG_mast(1,i).data([CZ_index],:,:))))];
%             figlim = max(abs(cololims));
%             figlims =[ -figlim figlim];
%     
%             filename = horzcat(ALLEEG_mast(i).setname,'.fig');
%     
%             h = figure;
%     %         suptitle (ALLEEG_mast(1,i).setname);
%             subplot(18,1,[1]);
%             title(ALLEEG_mast(1,i).setname);
%             hold on
%     
%             subplot(18,1,[2:6]);
%             pop_erpimage(ALLEEG_mast(1,i),1, [CZ_index(i)],[[]],'Cz',10,1,{},[],'' ,'yerplabel','\muV','erp','on','limits',[-250 1000 NaN NaN NaN NaN NaN NaN] ,'cbar','on');
%     
%             subplot(18,1,[7:11]);
%             pop_erpimage(ALLEEG_Fz(1,i),1, [C3_index(i)],[[]],'C3',10,1,{},[],'' ,'yerplabel','\muV','erp','on','limits',[-250 1000 NaN NaN NaN NaN NaN NaN] ,'cbar','on');
%             hold on;
%     
%             subplot(18,1,[12:16]);
%             pop_erpimage(ALLEEG_Fz(1,i),1, [C4_index(i)],[[]],'C4',10,1,{},[],'' ,'yerplabel','\muV','erp','on','limits',[-250 1000 NaN NaN NaN NaN NaN NaN] ,'cbar','on');
%             hold on;
%     
%     
%             subplot(18,1,[17 18]);
%             title('Global Field Power');
%             plot(EEG_mast(1,i).times(time_index_start:time_index_end), std(mean(ALLEEG_mast(1,i).data(:,time_index_start:time_index_end,:),3)), 'k', 'linewidth', 2);
%             xlabel('Time(ms)');
%             ylabel('GFP');
%             disp('...done');
%     
%            % savefig(h,filename,'compact');
%             close(h);
%     
end

  %%Plot stuff 

    cond1=find([ALLEEG.condition]=='1');
    cond2=find([ALLEEG.condition]=='2');
    cond3=find([ALLEEG.condition]=='3');
    cond4=find([ALLEEG.condition]=='4');
    
      datadd_cz_cheps=(1:length(ALLEEG));  
    
    remove=[find(strcmp({ALLEEG.subject},'C08'))]; 
    datadd_cz_cheps(remove)=[];
     
    
    
% h=plot_erp_CI(CZ_data(cond1,:),'Cheps CZ ERP');
%%CZ electrode!
   for gg=1:1 
       
       upperYlim=20;
       lowerYlim=-20;
       
   mean_cz_pl=mean(CZ_data(cond1,:));                            %mean data
    SEM_cz_pl=std(CZ_data(cond1,:))/sqrt(size(CZ_data(cond1,:),1));    %Standard Error
    CI95_pl=tinv([0.025 0.975],size(CZ_data(cond1,:),1)-1);                               %T-Score
    ERP_CI95_pl=bsxfun(@times, SEM_cz_pl,CI95_pl(:));  %Confidence Intervals 
    
    mean_cz_cap=mean(CZ_data(cond2,:));                            %mean data
    SEM_cz_cap=std(CZ_data(cond2,:))/sqrt(size(CZ_data(cond2,:),1));    %Standard Error
    CI95_cap=tinv([0.025 0.975],size(CZ_data(cond2,:),1)-1);                               %T-Score
    ERP_CI95_cap=bsxfun(@times, SEM_cz_cap,CI95_cap(:));  %Confidence Intervals 
    
    

    x=-1000:0.25:1999.75;
    
    lower_pl=mean_cz_pl+ERP_CI95_pl(1,:);
    upper_pl=mean_cz_pl+ERP_CI95_pl(2,:);
    lower_cap=mean_cz_cap+ERP_CI95_cap(1,:);
    upper_cap=mean_cz_cap+ERP_CI95_cap(2,:);
    fig1=figure;
    plot(x,mean_cz_pl,'color','b'); 
    hold on; 
    plot(x,mean_cz_cap,'color', 'r') 
    set(gca,'ylim',[lowerYlim upperYlim]);
    hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    plot(x,upper_pl,'color','w');
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    hold on; title('CHEPS CZ Average ERP');
    
    hold on;
    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
     legend({'CHEPS Placebo CZ Grand Average','CHEPS Capsaicin CZ Grand Average'});      
     hold off;
       
       
       %%LEPS Plots 
       
        mean_cz_pl=mean(CZ_data(cond3,:));                            %mean data
    SEM_cz_pl=std(CZ_data(cond3,:))/sqrt(size(CZ_data(cond3,:),1));    %Standard Error
    CI95_pl=tinv([0.025 0.975],size(CZ_data(cond3,:),1)-1);                               %T-Score
    ERP_CI95_pl=bsxfun(@times, SEM_cz_pl,CI95_pl(:));  %Confidence Intervals 
    
    mean_cz_cap=mean(CZ_data(cond4,:));                            %mean data
    SEM_cz_cap=std(CZ_data(cond4,:))/sqrt(size(CZ_data(cond4,:),1));    %Standard Error
    CI95_cap=tinv([0.025 0.975],size(CZ_data(cond4,:),1)-1);                               %T-Score
    ERP_CI95_cap=bsxfun(@times, SEM_cz_cap,CI95_cap(:));  %Confidence Intervals 
    
    

    x=-1000:0.25:1999.75;
    
    lower_pl=mean_cz_pl+ERP_CI95_pl(1,:);
    upper_pl=mean_cz_pl+ERP_CI95_pl(2,:);
    lower_cap=mean_cz_cap+ERP_CI95_cap(1,:);
    upper_cap=mean_cz_cap+ERP_CI95_cap(2,:);
    fig2=figure;
    plot(x,mean_cz_pl,'color','b');
    hold on; set(gca,'ylim',[lowerYlim upperYlim]); hold on;
    hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    plot(x,mean_cz_cap,'color', 'r')
    hold on;
    plot(x,upper_pl,'color','w');
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    hold on; title('LEPS CZ Average ERP');
    
    
    hold on;
    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
       legend({'LEPS Placebo CZ Grand Average','LEPS Capsaicin CZ Grand Average'})
       hold off;
   end
       %%Contralateral Electrode average! C3 (and a few C4's!)
    
    %list of ALLEEG datasets to (not)use. 
    %Recordings ignored: C08 (ALL)
    %CZ:CHEPS C02
      %:LEPs: C14
    %CHEPS: electrode C3: C06, C09, C15 (C4)
    %LEPS: electrode C3: C15 (C4)
    
    %only participants: 1,7,10,11,13,15,16,17,20 had N1/P1 signal in all conditions. 
    
    ALLEEG=ALLEEG_Fz;
    
    %%get data for C3
    
    %get only matched pairs:
     datadd_c3=(1:length(ALLEEG_Fz));
     remove_unmatched=[find(strcmp({ALLEEG.subject},'C02')),...
         find(strcmp({ALLEEG.subject},'C03')),...
         find(strcmp({ALLEEG.subject},'C04')),...
         find(strcmp({ALLEEG.subject},'C06')),...
         find(strcmp({ALLEEG.subject},'C08')),...
         find(strcmp({ALLEEG.subject},'C09')),...
         find(strcmp({ALLEEG.subject},'C14')),...
         find(strcmp({ALLEEG.subject},'C19'))];
    datadd_c3(remove_unmatched)=[];
    process_c3_matched=datadd_c3;
    
    
    %get all
    
    datadd_c3=(1:length(ALLEEG_Fz));
    remove_leps=[find(strcmp({ALLEEG.subject},'C08'))]; 
    datadd_c3(remove_leps)=[];
    process_leps_c3=datadd_c3;
    
    datadd_c3=(1:length(ALLEEG_Fz));
    remove_cheps= [find(strcmp({ALLEEG.subject},'C08')), find(strcmp({ALLEEG.subject},'C06')),  find(strcmp({ALLEEG.subject},'C09'))];
    datadd_c3(remove_cheps)=[];
    process_cheps_c3=datadd_c3;
    
    
    %%plot all C3 available
    for gg=1:1
    %%Plot data for C3 CHEPS
    
    c_pl_index=intersect(process_cheps_c3,cond1);
    mean_c3_pl=mean(C3_data(c_pl_index,:));                            %mean data
    SEM_c3_pl=std(C3_data(c_pl_index,:))/sqrt(size(C3_data(c_pl_index,:),1));    %Standard Error
    CI95_pl=tinv([0.025 0.975],size(C3_data(c_pl_index,:),1)-1);                               %T-Score
    ERP_CI95_pl=bsxfun(@times, SEM_c3_pl,CI95_pl(:));  %Confidence Intervals 
    
    c_cap_index=intersect(process_cheps_c3,cond2);
    mean_c3_cap=mean(C3_data(c_cap_index,:));                            %mean data
    SEM_c3_cap=std(C3_data(c_cap_index,:))/sqrt(size(C3_data(c_cap_index,:),1));    %Standard Error
    CI95_cap=tinv([0.025 0.975],size(C3_data(c_cap_index,:),1)-1);                               %T-Score
    ERP_CI95_cap=bsxfun(@times, SEM_c3_cap,CI95_cap(:));  %Confidence Intervals 
    
    x=-1000:0.25:1999.75;
    
    lower_pl=mean_c3_pl+ERP_CI95_pl(1,:);
    upper_pl=mean_c3_pl+ERP_CI95_pl(2,:);
    lower_cap=mean_c3_cap+ERP_CI95_cap(1,:);
    upper_cap=mean_c3_cap+ERP_CI95_cap(2,:);
    fig3=figure;
    plot(x,mean_c3_pl,'color','b'); 
    hold on; set(gca,'ylim',[-8 8]);
      hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    hold on;
     plot(x,mean_c3_cap,'color', 'r');
     hold on;
    plot(x,upper_pl,'color','w'); 
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    hold on; title('CHEPS C3 Average ERP');
   
    hold on;
    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
    legend({'CHEPS Placebo C3 Grand Average','CHEPS Capsaicin C3 Grand Average'})
    hold off;
  
    %%LEPS C3 Plot 
    c_pl_index=intersect(process_cheps_c3,cond3);
    mean_c3_pl=mean(C3_data(c_pl_index,:));                            %mean data
    SEM_c3_pl=std(C3_data(c_pl_index,:))/sqrt(size(C3_data(c_pl_index,:),1));    %Standard Error
    CI95_pl=tinv([0.025 0.975],size(C3_data(c_pl_index,:),1)-1);                               %T-Score
    ERP_CI95_pl=bsxfun(@times, SEM_c3_pl,CI95_pl(:));  %Confidence Intervals 
    
    c_cap_index=intersect(process_cheps_c3,cond4);
    mean_c3_cap=mean(C3_data(c_cap_index,:));                            %mean data
    SEM_c3_cap=std(C3_data(c_cap_index,:))/sqrt(size(C3_data(c_cap_index,:),1));    %Standard Error
    CI95_cap=tinv([0.025 0.975],size(C3_data(c_cap_index,:),1)-1);                               %T-Score
    ERP_CI95_cap=bsxfun(@times, SEM_c3_cap,CI95_cap(:));  %Confidence Intervals 
    
    x=-1000:0.25:1999.75;
    
    lower_pl=mean_c3_pl+ERP_CI95_pl(1,:);
    upper_pl=mean_c3_pl+ERP_CI95_pl(2,:);
    lower_cap=mean_c3_cap+ERP_CI95_cap(1,:);
    upper_cap=mean_c3_cap+ERP_CI95_cap(2,:);
    fig4=figure;
    plot(x,mean_c3_pl,'color','b');    
    hold on; set(gca,'ylim',[-8 8]);
    hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    hold on;   
    plot(x,mean_c3_cap,'color', 'r')
    hold on;
    plot(x,upper_pl,'color','w');
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    hold on; title('LEPS C3 Average ERP');
    

    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
    legend({'LEPS Placebo C3 Grand Average','LEPS Capsaicin C3 Grand Average'})
    hold off;
    
    end
 
   %%Plot only C3 from participants with signal in placebo conditions "MATCHED"
    for gg=1:1
    %%Plot data for C3 CHEPS
    
    c_pl_index=intersect(process_c3_matched,cond1);
    mean_c3_pl_cheps=mean(C3_data(c_pl_index,:)); %mean data
    mean_c3_pl_cheps_all=mean(C3_data(
    SEM_c3_pl=std(C3_data(c_pl_index,:))/sqrt(size(C3_data(c_pl_index,:),1));    %Standard Error
    CI95_pl=tinv([0.025 0.975],size(C3_data(c_pl_index,:),1)-1);                               %T-Score
    ERP_CI95_pl=bsxfun(@times, SEM_c3_pl,CI95_pl(:));  %Confidence Intervals 
    
    c_cap_index=intersect(process_c3_matched,cond2);
    mean_c3_cap_cheps=mean(C3_data(c_cap_index,:));                            %mean data
    SEM_c3_cap=std(C3_data(c_cap_index,:))/sqrt(size(C3_data(c_cap_index,:),1));    %Standard Error
    CI95_cap=tinv([0.025 0.975],size(C3_data(c_cap_index,:),1)-1);                               %T-Score
    ERP_CI95_cap=bsxfun(@times, SEM_c3_cap,CI95_cap(:));  %Confidence Intervals 
    
    x=-1000:0.25:1999.75;
    
    lower_pl=mean_c3_pl_cheps+ERP_CI95_pl(1,:);
    upper_pl=mean_c3_pl_cheps+ERP_CI95_pl(2,:);
    lower_cap=mean_c3_cap_cheps+ERP_CI95_cap(1,:);
    upper_cap=mean_c3_cap_cheps+ERP_CI95_cap(2,:);
    fig3=figure;
    plot(x,mean_c3_pl_cheps,'color','b'); 
    hold on; set(gca,'ylim',[-8 8]);
      hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    hold on;
     plot(x,mean_c3_cap_cheps,'color', 'r');
     hold on;
    plot(x,upper_pl,'color','w'); 
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    %x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    hold on; title('CHEPS C3 Average ERP - Matched Subjects Only');
   
    hold on;
    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
   % x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
    legend({'CHEPS Placebo C3 Grand Average','CHEPS Capsaicin C3 Grand Average'})
    hold off;
  
    %%LEPS C3 Plot 
    c_pl_index=intersect(process_c3_matched,cond3);
    mean_c3_pl_leps=mean(C3_data(c_pl_index,:));                            %mean data
    SEM_c3_pl=std(C3_data(c_pl_index,:))/sqrt(size(C3_data(c_pl_index,:),1));    %Standard Error
    CI95_pl=tinv([0.025 0.975],size(C3_data(c_pl_index,:),1)-1);                               %T-Score
    ERP_CI95_pl=bsxfun(@times, SEM_c3_pl,CI95_pl(:));  %Confidence Intervals 
    
    c_cap_index=intersect(process_c3_matched,cond4);
    mean_c3_cap_leps=mean(C3_data(c_cap_index,:));                            %mean data
    SEM_c3_cap=std(C3_data(c_cap_index,:))/sqrt(size(C3_data(c_cap_index,:),1));    %Standard Error
    CI95_cap=tinv([0.025 0.975],size(C3_data(c_cap_index,:),1)-1);                               %T-Score
    ERP_CI95_cap=bsxfun(@times, SEM_c3_cap,CI95_cap(:));  %Confidence Intervals 
    
    x=-1000:0.25:1999.75;
    
    lower_pl=mean_c3_pl_leps+ERP_CI95_pl(1,:);
    upper_pl=mean_c3_pl_leps+ERP_CI95_pl(2,:);
    lower_cap=mean_c3_cap_leps+ERP_CI95_cap(1,:);
    upper_cap=mean_c3_cap_leps+ERP_CI95_cap(2,:);
    fig4=figure;
    plot(x,mean_c3_pl_leps,'color','b');    
    hold on; set(gca,'ylim',[-8 8]);
    hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    hold on;   
    plot(x,mean_c3_cap_leps,'color', 'r')
    hold on;
    plot(x,upper_pl,'color','w');
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
  %  x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    hold on; title('LEPS C3 Average ERP - Matched Subjects Only');
    

    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
  %  x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
    legend({'LEPS Placebo C3 Grand Average','LEPS Capsaicin C3 Grand Average'})
    hold off;
   
    
    end
    
    %Matched 12 subjects: 
    cheps_pl_n1_lat=328.5;
    cheps_pl_p1_lat=411.25;
    cheps_pl_n3_lat=492.75;
    cheps_pl_p4_lat=537.75;
    
    leps_pl_n1_lat=172.25;
    leps_pl_p1_lat=249.5;
    leps_pl_n3_lat=304.25;
    leps_pl_p4_lat=369.75;
    
    %can either use these time points in EEGLAB STUDY function 
%          - study -> plot channel measures
%             -> ERP -> Params -> Plot Scalp topo at time: (cheps_pl_n1_lat)
%             -> select all channels 
%             -> PLOT ERP (ALL SUBJECTS)
    
    %need to plot scalp maps of these N1 and P1 subjects. 
    for i=1:length(process_c3_matched)
    figure; pop_topoplot(mean(ALLEEG.data,3),1,[cheps_p1_n1_lat,cheps_pl_p1_lat,cheps_pl_n3_lat,cheps_pl_P4_lat],'Not the average'); 
    figure; timtopo(ALLEEG(process_c3_matched(i)).data, ALLEEG(process_c3_matched(i)).chanlocs,[-1000 1999.75 -50 50],[300,400])
    end
    