function p1_comp=get_p1_comp(EEG, N2P2_comp,N2_index, P2_index)

for(i=1:size(EEG.icaact,1))
    if(i==N2P2_comp)
        check(i).max_val=0;
        check(i).max_index=0;
        check(i).min_val=0;
        check(i).min_index=0;
    else
    [check(i).max_val,check(i).max_index,check(i).min_val,check(i).min_index]=get_comp_peaks(EEG,i,N2_index, P2_index); %get all component max/min
    end
end

valid_max_range=find(N2_index<[check.max_index]<P2_index);
valid_min_range=find(N2_index<[check.min_index]<P2_index);


%get comp with largest max
[~,largest]=find([check.max_val]==max([check(valid_max_range).max_val]));

%get comp with smallest min
[~,smallest]=find([check.min_val]==min([check(valid_min_range).min_val]));

%choose which component is p1 based on index of max/min
if(abs(check(largest).max_val)>abs(check(smallest).min_val))
    p1_comp=largest;
else
    p1_comp=smallest;
end




end