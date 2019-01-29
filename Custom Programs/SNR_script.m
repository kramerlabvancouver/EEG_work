
%% Get SNR of all files loaded up in EEGLAB
%define Channel of interest 
chan_name='CZ';
for i=1:length(ALLEEG)
     
    SNR_s(i).name=ALLEEG(i).setname;
    SNR_s(i).snr= calc_SNR(ALLEEG(i), chan_name);
    SNR_s(i).subject=ALLEEG(i).subject;
    temp1=uint8(ALLEEG(i).subject); 
    SNR_s(i).subnum=str2num(char([temp1(2:end)]));
    SNR_s(i).condition=ALLEEG(i).condition;
    
    
    
end 
%Atest=rot90(sort([SNR_s.subnum], 'descend'),-1);
A_mean=mean([SNR_s.snr]);

% %% Plot the SNR and average
% total=0;   count_1=1; count_2=1; count_3=1; count_4=1; Condition_1_snr=0; Condition_2_sum= 0; Condition_3_sum=0; Condition_4_sum=0; figure;
% for i=1:length(SNR_s)
%     total=SNR_s(i).snr+total; plot(i, SNR_s(i).snr,'.'); hold on;
%     
%     if(SNR_s(i).condition=='1')
%         Condition_1_snr(count_1)=SNR_s(i).snr;
%         count_1=count_1+1;
%     elseif(SNR_s(i).condition=='2')
%         Condition_2_snr(count_2)=SNR_s(i).snr;
%         count_2=count_2+1;
%     elseif(SNR_s(i).condition=='3')
%         Condition_3_snr(count_3)=SNR_s(i).snr;
%         count_3=count_3+1;
%     elseif(SNR_s(i).condition=='4')
%         Condition_4_snr(count_4)=SNR_s(i).snr;
%         count_4=count_4+1;
%     end
%     
% end; avg=total/length(SNR_s);

%avg1= Condition_1_snr/count_1; avg2= Condition_2_sum/count_2; avg3= Condition_3_sum/count_3; avg4= Condition_4_sum/count_4;
%%
% 
% ylabel('Signal to noise ratio (dB)')
% xlabel('Trials (#)')
% title('N2P2 SNR by Trial Number')
% 



%does not work... group (SNR_s.condition) problematic
h=figure;
gscatter([1:length(SNR_s)], [SNR_s.snr], char({SNR_s.condition}));


h=figure;
boxplot([SNR_s.snr], char({SNR_s.condition}));
xlabel('Condition')
ylabel('Signal to noise ratio (dB)')
title('C3 SNR by Condition');
savefig(h,'SNR_condition');
close(h); 
%% prep for figure
x=ones(length(SNR_s)).*(1+(rand(length(SNR_s))*0.1-0.1)/5);

%Dot colours for Participant plot
           %blue black red green
% dot_colour=['b'   'k'  'r'  'g'];
dot_colour2=[0.2   0.5   0.851 %light blue
                0 0 1 %blue   
                1   0   0 %red
                0.64  0.13 0.09    ];  %mahogany

%% Participant figure plot
h=figure; 
boxplot([SNR_s.snr], char({SNR_s.subject}),'Colors', 'k');
hold on; 
i=1; xx=1;
while(xx<=length(SNR_s))
scatter(x(xx,1).*SNR_s(xx).subnum,[SNR_s(xx).snr], 'filled', 'MarkerFaceColor', dot_colour2(str2double(SNR_s(xx).condition),:)); 
%f1.MarkerFaceAlpha = 0.4;
i=i+1;xx=xx+1;
hold on 
end

set(gca,'FontSize',8);
minline=refline(0,3);
minline.Color='r';
minline.LineStyle='--';
ylabel('Signal to noise ratio (dB)')
xlabel('Participant')
title([chan_name ' SNR by Participant']);
legend({'LEPS+Placebo', 'CHEPS+Placebo','LEPS+Cap','CHEPS+Cap'}, 'Location', 'northeast');

savefig(h,'SNR_participant');
close(h);


%%2way ANOVA to see if different between groups/factors
%factors as columns, groups as rows
%ie
%     placebo  Capsaicin
%     (1)   1   (2)
%        ...              cheps
%        20                  
%     (3)   1     (4)           leps 
%        ...
%        20
%

SNR_t=SNR_s;
%remove 8,9,16 for direct comparison 
SNR_t(find([SNR_t.subnum]==8))=[];
SNR_t(find([SNR_t.subnum]==9))=[];
SNR_t(find([SNR_t.subnum]==16))=[];

g3={SNR_t(find([SNR_t.condition]=='3')).snr}';
g1={SNR_t(find([SNR_t.condition]=='1')).snr}';
g4={SNR_t(find([SNR_t.condition]=='4')).snr}';
g2={SNR_t(find([SNR_t.condition]=='2')).snr}';

cheps=[g1 g2]; 
leps= [g3 g4];

snr_anova_table=cell2mat(vertcat(cheps,leps));
number_of_participants=20-3;


[~,~,stats]=anova2(snr_anova_table,number_of_participants);
%not significant. 


