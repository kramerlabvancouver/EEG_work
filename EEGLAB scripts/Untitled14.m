%%BACKPROJECT COMPONENT ACTIVITY 

%choose component 3 from ALLCHEPS CONCATENATED DATA (PCA)

ALLCHEPS=ALLEEG(1);
ALLLEPS=ALLEEG(2);


for i=1:size(ALLCHEPS.data,3)

    trial_activity(i)=mldivide(ALLCHEPS.icawinv(:,3),ALLCHEPS.data(1:30,:,i));

end

mean_trial_activity=mean(trial_activity);