%% All subjects plotting
i = 1; 
m = 1;
n = 1;
 
for i=1:length(ALLEEG);
    if isequal(rem(i,2),0);
        display(i)
        CHEPS(m).dataset = i;
        CHEPS(m).times = ALLEEG(i).times;
        CHEPS(m).data = ALLEEG(i).data;
        CHEPS(m).trial_averages = mean(ALLEEG(i).data,3);
        CHEPS(m).grand_averages = mean(CHEPS(m).trial_averages,1);
        m = m + 1;
        display(m)
        
    else
        display(i)
        LEPS(n).dataset = i;
        LEPS(n).times = ALLEEG(i).times;
        LEPS(n).data = ALLEEG(i).data;
        LEPS(n).trial_averages = mean(ALLEEG(i).data,3); %averages
        LEPS(n).grand_averages = mean(LEPS(n).trial_averages,1);
        display(n)
        n = n + 1;
    end
end

 
 
 
%making a matrix where all the data wil go into 
nchan = 30;
nsamp = 12000;
nsubj=i/4;
alldata_CHEPS = zeros(nchan,nsamp,nsubj);
alldata_LEPS = zeros(nchan,nsamp,nsubj);
 
 
for subject = 1:nsubj
   alldata_CHEPS(:,:,subject) = CHEPS(subject).trial_averages;
   display('...done');
   alldata_LEPS(:,:,subject) = LEPS(subject).trial_averages; 
end
 
grand_averages_CHEPS = mean( alldata_CHEPS, 3 );
grand_averages_LEPS = mean( alldata_LEPS, 3 );
 
% Average across subjects LEPS movie 
data = mean(grand_averages_LEPS,3);
srate = 4000; 
elec_locs = EEG.chanlocs;
 
[Movie_LEPS,Colormap_2] = eegmovie(data,srate,elec_locs,'movieframes',[4000:20:6800],'startsec',-1,'time','on','vert',[0]);
seemovie(Movie_LEPS,1,Colormap_2)
 
 
% Average across subjects NB movie 
data = mean(grand_averages_CHEPS,3);
srate = 4000; 
elec_locs = EEG.chanlocs;
 
[Movie_CHEPS,Colormap_2] = eegmovie(data,srate,elec_locs,'movieframes',[4000:20:6800],'startsec', -1,'time','on','vert',[0]);
seemovie(Movie_CHEPS,1,Colormap_2)
seemovie(Movie_LEPS,1,Colormap_2)