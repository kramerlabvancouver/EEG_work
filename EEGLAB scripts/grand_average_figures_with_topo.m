%%make nice ERP plots of CZ, and contralateral (N1P1) electrode for every single recording....


%%To automatically load up both studies, set init=1 in command window and
%%press run! 
 
if(init==1)
    eeglab;
    
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    %load up mastoid referenced datasets in study form. You will have to
    %make these studies separately 
[STUDY ALLEEG] = pop_loadstudy('filename', 'CvL_mas_ref_good.study', 'filepath', 'C:\Users\carso\Documents\1. School\Coop ICORD\Ear_ref');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
ALLEEG_mast=ALLEEG;
 % load up FZ referenced datasets in study
[STUDY ALLEEG] = pop_loadstudy('filename', 'CvL_fz_ref_good.study', 'filepath', 'C:\Users\carso\Documents\1. School\Coop ICORD\FZ_ref');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
ALLEEG_Fz=ALLEEG;
eeglab redraw;
init=0;
end

%What colour grey we are using for figure backgrounds
grey=0.97;

%process latency data for adding lines to figures (manually extracted)
latency_hard_codes


time_index_start= find(EEG(1).times == -500); % find the 250 ms pre trigger
time_index_end = find(EEG(1).times == 1500); %find the end

% plotting each trial recording 
for i=1:length(ALLEEG)
    
    %Get channel indices
    CZ_index(i)= find(strcmpi({ALLEEG_mast(i).chanlocs.labels}.', 'CZ'));
    try
        if(strcmp(ALLEEG_Fz(i).subject,'C15'))
            C3_index(i)= find(strcmpi({ALLEEG_Fz(1,i).chanlocs.labels}.', 'C4'));
            C4_index(i)= find(strcmpi({ALLEEG_Fz(1,i).chanlocs.labels}.', 'C3'));
        else
        C3_index(i)= find(strcmpi({ALLEEG_Fz(1,i).chanlocs.labels}.', 'C3'));
        C4_index(i)= find(strcmpi({ALLEEG_Fz(1,i).chanlocs.labels}.', 'C4'));
        end
        
    catch
        
        warning('missing c3');
        C3_index(i)=NaN;
    continue;
    end
    
    %C4_index(i)= find(strcmpi({ALLEEG_Fz(1,i).chanlocs.labels}.', 'C4'));
    sample_start=2001;
    sample_end=8001;
    CZ_data(i,:)=mean(ALLEEG_mast(1,i).data([CZ_index(i)],sample_start:sample_end,:),3);
    C3_data(i,:)=mean(ALLEEG_Fz(1,i).data([C3_index(i)],sample_start:sample_end,:),3);
    C4_data(i,:)=mean(ALLEEG_Fz(1,i).data([C4_index(i)],sample_start:sample_end,:),3);
    %C4_data(i,:)=mean(ALLEEG_Fz(1,i).data([C4_index(i)],:,:),3);
    

end

  %%Plot stuff 

    cond1=find([ALLEEG.condition]=='1');
    cond2=find([ALLEEG.condition]=='2');
    cond3=find([ALLEEG.condition]=='3');
    cond4=find([ALLEEG.condition]=='4');
    
      datadd_cz_cheps=(1:length(ALLEEG));  
    
      %remove bad dataset
    remove=[find(strcmp({ALLEEG.subject},'C08'))]; 
    datadd_cz_cheps(remove)=[];
     
    
    
% h=plot_erp_CI(CZ_data(cond1,:),'Cheps CZ ERP');
%%CZ electrode!
   for gg=1:1 
       
       %set figure Ylim by inspection 
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
    
   
    %x=-1000:0.25:1999.75;
    x=-500:0.25:1000; %6001 samples long ...need to resize all the data_sets to plot, otherwise vector length mismatch
    
    
    lower_pl=mean_cz_pl+ERP_CI95_pl(1,:);
    upper_pl=mean_cz_pl+ERP_CI95_pl(2,:);
    lower_cap=mean_cz_cap+ERP_CI95_cap(1,:);
    upper_cap=mean_cz_cap+ERP_CI95_cap(2,:);
    fig1=figure;
    cz_cheps_plot=subplot(2,2,1); plot(x,mean_cz_pl,'color','b'); 
    set(gca,'Ydir','reverse');
    hold on; 
    plot(x,mean_cz_cap,'color', 'r') 
    set(gca,'ylim',[lowerYlim upperYlim]);
    set(gca,'Ydir','reverse');
    hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    plot(x,upper_pl,'color','w');
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    %add lines for peaks
    line([cheps_pl_n2_lat cheps_pl_n2_lat], [lowerYlim upperYlim], 'color', 'b'); 
    line([cheps_cap_n2_lat cheps_cap_n2_lat], [lowerYlim upperYlim], 'color', 'r');
    line([cheps_pl_p2_lat cheps_pl_p2_lat], [lowerYlim upperYlim], 'color', 'b'); 
    line([cheps_cap_p2_lat cheps_cap_p2_lat], [lowerYlim upperYlim], 'color', 'r');    
    
    hold on; title('CHEPS Average Vertex ERP');
    
    hold on;
    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
     l1=legend({'CHEPS Placebo CZ Grand Average','CHEPS Capsaicin CZ Grand Average'});      
     l1.Location='southwest';
    set(gca, 'fontsize', 11);
    set(gca, 'fontname', 'calibri');
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
    
        
    lower_pl=mean_cz_pl+ERP_CI95_pl(1,:);
    upper_pl=mean_cz_pl+ERP_CI95_pl(2,:);
    lower_cap=mean_cz_cap+ERP_CI95_cap(1,:);
    upper_cap=mean_cz_cap+ERP_CI95_cap(2,:);
    %fig2=figure;
    cz_leps_plot=subplot(2, 2, 3); plot(x,mean_cz_pl,'color','b');
    set(gca,'Ydir','reverse');
    hold on; set(gca,'ylim',[lowerYlim upperYlim]); hold on;
    hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    plot(x,mean_cz_cap,'color', 'r')
    hold on;
    plot(x,upper_pl,'color','w');
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    %add lines
    line([leps_pl_n2_lat leps_pl_n2_lat], [lowerYlim upperYlim], 'color', 'b'); 
    line([leps_cap_n2_lat leps_cap_n2_lat], [lowerYlim upperYlim], 'color', 'r');
    line([leps_pl_p2_lat leps_pl_p2_lat], [lowerYlim upperYlim], 'color', 'b'); 
    line([leps_cap_p2_lat leps_cap_p2_lat], [lowerYlim upperYlim], 'color', 'r');      
    
    hold on; title('LEPS Average Vertex ERP');
    
    
    hold on;
    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
       l2=legend({'LEPS Placebo CZ Grand Average','LEPS Capsaicin CZ Grand Average'});
       l2.Location='southwest';
    set(gca, 'color', [grey grey grey]);
    set(gca, 'fontsize', 11);
    set(gca, 'fontname', 'calibri');
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
    
    
    %get all, removing bad data
    
    datadd_c3=(1:length(ALLEEG_Fz));
    remove_leps=[find(strcmp({ALLEEG.subject},'C08'))]; 
    datadd_c3(remove_leps)=[];
    process_leps_c3=datadd_c3;
    
    datadd_c3=(1:length(ALLEEG_Fz));
    remove_cheps= [find(strcmp({ALLEEG.subject},'C08')), find(strcmp({ALLEEG.subject},'C06')),  find(strcmp({ALLEEG.subject},'C09'))];
    datadd_c3(remove_cheps)=[];
    process_cheps_c3=datadd_c3;
    
    
    %%plot all C3 available
%     for gg=1:1
%     %%Plot data for C3 CHEPS
%     
%     c_pl_index=intersect(process_cheps_c3,cond1);
%     mean_c3_pl=mean(C3_data(c_pl_index,:));                            %mean data
%     SEM_c3_pl=std(C3_data(c_pl_index,:))/sqrt(size(C3_data(c_pl_index,:),1));    %Standard Error
%     CI95_pl=tinv([0.025 0.975],size(C3_data(c_pl_index,:),1)-1);                               %T-Score
%     ERP_CI95_pl=bsxfun(@times, SEM_c3_pl,CI95_pl(:));  %Confidence Intervals 
%     
%     c_cap_index=intersect(process_cheps_c3,cond2);
%     mean_c3_cap=mean(C3_data(c_cap_index,:));                            %mean data
%     SEM_c3_cap=std(C3_data(c_cap_index,:))/sqrt(size(C3_data(c_cap_index,:),1));    %Standard Error
%     CI95_cap=tinv([0.025 0.975],size(C3_data(c_cap_index,:),1)-1);                               %T-Score
%     ERP_CI95_cap=bsxfun(@times, SEM_c3_cap,CI95_cap(:));  %Confidence Intervals 
%         
%     lower_pl=mean_c3_pl+ERP_CI95_pl(1,:);
%     upper_pl=mean_c3_pl+ERP_CI95_pl(2,:);
%     lower_cap=mean_c3_cap+ERP_CI95_cap(1,:);
%     upper_cap=mean_c3_cap+ERP_CI95_cap(2,:);
%     fig3=figure;
%     plot(x,mean_c3_pl,'color','b'); 
%     hold on; set(gca,'ylim',[-8 8]);
%       hold on; ylabel('Scalp Potential (uV)');
%     hold on; xlabel('Time (ms)');
%     hold on;
%      plot(x,mean_c3_cap,'color', 'r');
%      hold on;
%     plot(x,upper_pl,'color','w'); 
%     hold on; plot(x,lower_pl,'color','w'); 
%     hold on;
%     x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
%     hold on; title('CHEPS C3 Average ERP');
%    
%     hold on;
%     plot(x,upper_cap,'color','w');
%     hold on; plot(x,lower_cap,'color','w');
%     hold on;
%     x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
%     hold on; 
%     legend({'CHEPS Placebo C3 Grand Average','CHEPS Capsaicin C3 Grand Average'})
%     hold off;
%   
%     %%LEPS C3 Plot 
%     leps_pl_index=intersect(process_cheps_c3,cond3);
%     mean_c3_pl=mean(C3_data(leps_pl_index,:));                            %mean data
%     SEM_c3_pl=std(C3_data(leps_pl_index,:))/sqrt(size(C3_data(leps_pl_index,:),1));    %Standard Error
%     CI95_pl=tinv([0.025 0.975],size(C3_data(leps_pl_index,:),1)-1);                               %T-Score
%     ERP_CI95_pl=bsxfun(@times, SEM_c3_pl,CI95_pl(:));  %Confidence Intervals 
%     
%     leps_cap_index=intersect(process_cheps_c3,cond4);
%     mean_c3_cap=mean(C3_data(leps_cap_index,:));                            %mean data
%     SEM_c3_cap=std(C3_data(leps_cap_index,:))/sqrt(size(C3_data(leps_cap_index,:),1));    %Standard Error
%     CI95_cap=tinv([0.025 0.975],size(C3_data(leps_cap_index,:),1)-1);                               %T-Score
%     ERP_CI95_cap=bsxfun(@times, SEM_c3_cap,CI95_cap(:));  %Confidence Intervals 
%     
%     
%     lower_pl=mean_c3_pl+ERP_CI95_pl(1,:);
%     upper_pl=mean_c3_pl+ERP_CI95_pl(2,:);
%     lower_cap=mean_c3_cap+ERP_CI95_cap(1,:);
%     upper_cap=mean_c3_cap+ERP_CI95_cap(2,:);
%     fig4=figure;
%     plot(x,mean_c3_pl,'color','b');    
%     hold on; set(gca,'ylim',[-8 8]);
%     hold on; ylabel('Scalp Potential (uV)');
%     hold on; xlabel('Time (ms)');
%     hold on;   
%     plot(x,mean_c3_cap,'color', 'r')
%     hold on;
%     plot(x,upper_pl,'color','w');
%     hold on; plot(x,lower_pl,'color','w'); 
%     hold on;
%     x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
%     hold on; title('LEPS C3 Average ERP');
%     
% 
%     plot(x,upper_cap,'color','w');
%     hold on; plot(x,lower_cap,'color','w');
%     hold on;
%     x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
%     hold on; 
%     legend({'LEPS Placebo C3 Grand Average','LEPS Capsaicin C3 Grand Average'})
%     hold off;
%     
%     end
%  
   %%Plot only C3 from participants with signal in placebo conditions "MATCHED"
    for gg=1:1
    %% Plot data for C3 CHEPS
    
    c_pl_index=intersect(process_c3_matched,cond1);
    mean_c3_pl_cheps=mean(C3_data(c_pl_index,:)); %mean data
    SEM_c3_pl=std(C3_data(c_pl_index,:))/sqrt(size(C3_data(c_pl_index,:),1));    %Standard Error
    CI95_pl=tinv([0.025 0.975],size(C3_data(c_pl_index,:),1)-1);                               %T-Score
    ERP_CI95_pl=bsxfun(@times, SEM_c3_pl,CI95_pl(:));  %Confidence Intervals 
    
    c_cap_index=intersect(process_c3_matched,cond2);
    mean_c3_cap_cheps=mean(C3_data(c_cap_index,:));                            %mean data
    SEM_c3_cap=std(C3_data(c_cap_index,:))/sqrt(size(C3_data(c_cap_index,:),1));    %Standard Error
    CI95_cap=tinv([0.025 0.975],size(C3_data(c_cap_index,:),1)-1);                               %T-Score
    ERP_CI95_cap=bsxfun(@times, SEM_c3_cap,CI95_cap(:));  %Confidence Intervals 
    
    
    lower_pl=mean_c3_pl_cheps+ERP_CI95_pl(1,:);
    upper_pl=mean_c3_pl_cheps+ERP_CI95_pl(2,:);
    lower_cap=mean_c3_cap_cheps+ERP_CI95_cap(1,:);
    upper_cap=mean_c3_cap_cheps+ERP_CI95_cap(2,:);
    
    %fig3=figure;
    c3_cheps_plot=subplot(2,2,2); plot(x,mean_c3_pl_cheps,'color','b'); 
    set(gca,'Ydir','reverse');
    hold on; set(gca,'ylim',[-8 8]);
      hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    hold on;
     plot(x,mean_c3_cap_cheps,'color', 'r');
     hold on;
    plot(x,upper_pl,'color','w'); 
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    %add lines for peaks
    line([cheps_pl_n1_lat cheps_pl_n1_lat], [lowerYlim upperYlim], 'color', 'b'); 
    line([cheps_cap_n1_lat cheps_cap_n1_lat], [lowerYlim upperYlim], 'color', 'r');
    line([cheps_pl_p1_lat cheps_pl_p1_lat], [lowerYlim upperYlim], 'color', 'b'); 
    line([cheps_cap_p1_lat cheps_cap_p1_lat], [lowerYlim upperYlim], 'color', 'r');      
    
    hold on; title('CHEPS Average Contralateral ERP');
   
    hold on;
    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
   x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
    l3=legend({'CHEPS Placebo C3/C4 Grand Average','CHEPS Capsaicin C3/C4 Grand Average'});
    l3.Location='southwest';
    set(gca, 'fontsize', 11);
    set(gca, 'fontname', 'calibri');
    hold off;
  
    %% LEPS C3 Plot 
    leps_pl_index=intersect(process_c3_matched,cond3);
    mean_c3_pl_leps=mean(C3_data(leps_pl_index,:));                            %mean data
    SEM_c3_pl=std(C3_data(leps_pl_index,:))/sqrt(size(C3_data(c_pl_index,:),1));    %Standard Error
    CI95_pl=tinv([0.025 0.975],size(C3_data(leps_pl_index,:),1)-1);                               %T-Score
    ERP_CI95_pl=bsxfun(@times, SEM_c3_pl,CI95_pl(:));  %Confidence Intervals 
    
    leps_cap_index=intersect(process_c3_matched,cond4);
    mean_c3_cap_leps=mean(C3_data(leps_cap_index,:));                            %mean data
    SEM_c3_cap=std(C3_data(leps_cap_index,:))/sqrt(size(C3_data(leps_cap_index,:),1));    %Standard Error
    CI95_cap=tinv([0.025 0.975],size(C3_data(leps_cap_index,:),1)-1);                               %T-Score
    ERP_CI95_cap=bsxfun(@times, SEM_c3_cap,CI95_cap(:));  %Confidence Intervals 

    
    lower_pl=mean_c3_pl_leps+ERP_CI95_pl(1,:);
    upper_pl=mean_c3_pl_leps+ERP_CI95_pl(2,:);
    lower_cap=mean_c3_cap_leps+ERP_CI95_cap(1,:);
    upper_cap=mean_c3_cap_leps+ERP_CI95_cap(2,:);
    
    
    %% fig4=figure;
    c3_leps_plot=subplot(2,2,4); plot(x,mean_c3_pl_leps,'color','b');    
    set(gca,'Ydir','reverse');
    hold on; set(gca,'ylim',[-8 8]);
    hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    hold on;   
    plot(x,mean_c3_cap_leps,'color', 'r')
    hold on;
    plot(x,upper_pl,'color','w');
    hold on; plot(x,lower_pl,'color','w'); 
    hold on;
    x2=[x,fliplr(x)]; inbetween=[upper_pl, fliplr(lower_pl)]; fill(x2,inbetween,'b','FaceAlpha',0.1,'EdgeColor','none'); %set colour blue, transparency 10%, and no edgecolour
    %lines for peaks
    line([leps_pl_n1_lat leps_pl_n1_lat], [lowerYlim upperYlim], 'color', 'b'); 
    line([leps_cap_n1_lat leps_cap_n1_lat], [lowerYlim upperYlim], 'color', 'r');
    line([leps_pl_p1_lat leps_pl_p1_lat], [lowerYlim upperYlim], 'color', 'b'); 
    line([leps_cap_p1_lat leps_cap_p1_lat], [lowerYlim upperYlim], 'color', 'r');       
   hold on; title('LEPS Average Contralateral ERP');
    

    plot(x,upper_cap,'color','w');
    hold on; plot(x,lower_cap,'color','w');
    hold on;
   x2=[x,fliplr(x)]; inbetween=[upper_cap, fliplr(lower_cap)]; fill(x2,inbetween,'r','FaceAlpha',0.1,'EdgeColor','none'); %set colour red, transparency 10%, and no edgecolour
    hold on; 
    l4=legend({'LEPS Placebo C3/C4 Grand Average','LEPS Capsaicin C3/C4 Grand Average'});
    l4.Location='southwest';
    set(gca, 'color', [grey grey grey]);
    set(gca, 'fontsize', 11);
    set(gca, 'fontname', 'calibri');
    hold off;
   
    
    end
    

    

%% Make single subject figures from "representative" subject's averages

single_subject
    
    

function indx=ms2indx(time_in)
indx=time_in*4+2000;
end