% EEGLAB history file generated on the 17-May-2018
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','may_15_unedited.set','filepath','Z:\\19_Carson_Berry\\EEG\\MATLAB\\trunk\\src\\data\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG=pop_chanedit(EEG, 'lookup','C:\\Users\\carso\\Documents\\MATLAB\\Add-Ons\\Collections\\eeglabdevelopers_eeglab\\code\\eeglabdevelopers-eeglab-c66aeff\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','changefield',{1 'labels' 'fp1'},'changefield',{2 'labels' 'fp2'},'changefield',{3 'labels' 'fp2'},'changefield',{2 'labels' 'fpz'},'changefield',{4 'labels' 'f7'},'changefield',{5 'labels' 'f3'},'changefield',{6 'labels' 'fz'},'changefield',{7 'labels' 'f4'},'changefield',{8 'labels' 'f8'},'changefield',{9 'labels' 'fc5'},'changefield',{10 'labels' 'fc1'},'changefield',{11 'labels' 'fc2'},'changefield',{12 'labels' 'fc6'},'changefield',{13 'labels' 'm1'},'changefield',{14 'labels' 't7'},'changefield',{15 'labels' 'c3'},'changefield',{16 'labels' 'c7'},'changefield',{17 'labels' 'c4'},'changefield',{18 'labels' 't8'},'changefield',{19 'labels' 'm2'},'changefield',{20 'labels' 'cp5'},'changefield',{21 'labels' 'cp1'},'changefield',{22 'labels' 'cp2'},'changefield',{23 'labels' 'cp6'},'changefield',{24 'labels' 'p7'},'changefield',{25 'labels' 'p3'},'changefield',{27 'labels' 'p'},'changefield',{26 'labels' 'pz'},'changefield',{27 'labels' 'p4'},'changefield',{28 'labels' 'p8'},'changefield',{29 'labels' 'p0z'},'changefield',{30 'labels' 'o1'},'changefield',{31 'labels' 'oz'},'changefield',{32 'labels' 'o2'},'changefield',{33 'labels' 'af7'},'changefield',{34 'labels' 'af3'},'changefield',{35 'labels' 'af4'},'changefield',{36 'labels' 'af8'},'changefield',{37 'labels' 'f5'},'changefield',{38 'labels' 'f1'},'changefield',{39 'labels' 'f2'},'changefield',{40 'labels' 'f6'},'changefield',{41 'labels' 'fc3'},'changefield',{42 'labels' 'fc7'},'changefield',{43 'labels' 'fc4'},'changefield',{44 'labels' 'c5'},'changefield',{45 'labels' 'c1'},'changefield',{46 'labels' 'c2'},'changefield',{47 'labels' 'cp3'},'changefield',{48 'labels' 'c6'},'changefield',{49 'labels' 'cz'},'changefield',{50 'labels' 'cp4'},'changefield',{50 'theta' '0'},'changefield',{51 'labels' 'p5'},'changefield',{52 'labels' 'p1'},'changefield',{53 'labels' 'p2'},'changefield',{54 'labels' 'p6'},'changefield',{55 'labels' 'po5'},'changefield',{56 'labels' 'po3'},'changefield',{57 'labels' 'po4'},'changefield',{58 'labels' 'po6'},'changefield',{59 'labels' 'ft7'},'changefield',{60 'labels' 'ft8'},'changefield',{61 'labels' 'tp7'},'changefield',{62 'labels' 'tp8'},'changefield',{63 'labels' 'po7'},'changefield',{64 'labels' 'po8'},'lookup','C:\\Users\\carso\\Documents\\MATLAB\\Add-Ons\\Collections\\eeglabdevelopers_eeglab\\code\\eeglabdevelopers-eeglab-c66aeff\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','changefield',{42 'labels' 'fcz'},'changefield',{16 'labels' 'cz'},'lookup','C:\\Users\\carso\\Documents\\MATLAB\\Add-Ons\\Collections\\eeglabdevelopers_eeglab\\code\\eeglabdevelopers-eeglab-c66aeff\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','changefield',{29 'labels' 'poz'},'changefield',{49 'labels' 'cpz'},'lookup','C:\\Users\\carso\\Documents\\MATLAB\\Add-Ons\\Collections\\eeglabdevelopers_eeglab\\code\\eeglabdevelopers-eeglab-c66aeff\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','setref',{'' 'cz'},'settype',{'' 'EEG'},'save','Z:\\19_Carson_Berry\\EEG\\MATLAB\\trunk\\src\\64_channel_first_location.ced');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'BIP65' 'BIP66' 'BIP67' 'BIP68' 'AUX69' 'AUX70' 'AUX71' 'AUX72'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
eeglab redraw;