%%Compare the variance of the latency between the 4 CvL conditions. 

%read peak data from file
peaks=csvread('Z:\21_Iara_De_Schoenmacker\Final Code\CvL Amp_Latency.csv',1,1);

%some 'magic' numbers from looking at the format of the file in excel. these represent the number of
%columns that the start of each section are offset from 0 are. 
leps3_offset=10;
cheps2_offset=22;
leps4_offset=32;


%getting all the latencies together for each condition. 
%Each column corresponds to: N2,P2,N1,P1 in that order. 
cheps_pl_latency=[peaks(:,2) peaks(:,4) peaks(:,7) peaks(:,9)];
cheps_cap_latency=[peaks(:,2+cheps2_offset) peaks(:,4+cheps2_offset) peaks(:,7+cheps2_offset) peaks(:,9+cheps2_offset)];

leps_pl_latency=[peaks(:,2+leps3_offset) peaks(:,4+leps3_offset) peaks(:,7+leps3_offset) peaks(:,9+leps3_offset)];
leps_cap_latency=[peaks(:,2+leps4_offset) peaks(:,4+leps4_offset) peaks(:,7+leps4_offset) peaks(:,9+leps4_offset)];

all_latency=[peaks(:,2) peaks(:,4) peaks(:,7) peaks(:,9) ...
    peaks(:,2+cheps2_offset) peaks(:,4+cheps2_offset) peaks(:,7+cheps2_offset) peaks(:,9+cheps2_offset) ...
    peaks(:,2+leps3_offset) peaks(:,4+leps3_offset) peaks(:,7+leps3_offset) peaks(:,9+leps3_offset) ...
    peaks(:,2+leps4_offset) peaks(:,4+leps4_offset) peaks(:,7+leps4_offset) peaks(:,9+leps4_offset)];

all_latency(all_latency==0)=NaN;

%remove the zeros
cheps_pl_latency(cheps_pl_latency==0)=NaN;
cheps_cap_latency(cheps_cap_latency==0)=NaN;
leps_pl_latency(leps_pl_latency==0)=NaN;
leps_cap_latency(leps_cap_latency==0)=NaN;

N2=[all_latency(:,1:4:16)];
P2=[all_latency(:,2:4:16)];
N1=[all_latency(:,3:4:16)];
P1=[all_latency(:,4:4:16)];

[cheps_greater_var, CvL_p]=vartest2(leps_pl_latency,cheps_pl_latency,'Tail','left');

[leps_pl_greater_var,L_PlvC_p]=vartest2(leps_pl_latency,leps_cap_latency,'Tail','right');

[cheps_pl_greater_var,C_PlvC_p]=vartest2(cheps_pl_latency,cheps_cap_latency,'Tail','right');


column={'N2 latency','P2 latency','N1 latency', 'P1 latency'};

for i=1:length(cheps_greater_var)
    
    if(cheps_greater_var(i)==1)
                fprintf('CHEPs has greater variance than LEPS placebo in %s with p= %i . \n',char(column(i)),CvL_p(i));
    end
    
    if(cheps_pl_greater_var(i)==1)
                fprintf('CHEPs placebo has greater variance than CHEPs Capsaicin in %s with p= %i . \n',char(column(i)),C_PlvC_p(i));
    end
    
    if(leps_pl_greater_var(i)==1)
           fprintf('LEPs placebo has greater variance than LEPS Capsaicin in %s with p= %i . \n',char(column(i)),L_PlvC_p(i));
    end
    
end

vartestn(cheps_cap_latency)
vartestn(cheps_pl_latency)
vartestn(leps_cap_latency)
vartestn(leps_pl_latency)


distinct_from_N2=P1-N2;
anova1(distinct_from_N2)
[t_dis_from_N2,p_n2]=ttest(P1,N2) %significant difference in all groups - therefore P1 might be distinct form N2. 


distinct_from_P2=P2-P1;
anova1(distinct_from_P2)
[t_dis_from_P2,p_p2]=ttest(P2,P1) %significant difference in all groups - therefore P1 might be distinct from P2. 



