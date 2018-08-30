
% A script to make a simple movie from -100 to 600 in steps of 10 of
% whatever file is loaded up in EEGLAB
pnts = eeg_lat2point([-100:10:600]/1000, 1, EEG.srate, [EEG.xmin EEG.xmax]);
% Above, convert latencies in ms to data point indices
figure; [Movie,Colormap] = eegmovie(mean(EEG.data(1:30,(3600):40:(6400)),3), EEG.srate, EEG.chanlocs,'mode', '2D');
seemovie(Movie,-5,Colormap);