%A script for processing multiple folders of files. EEGLAB recommends
%storing the files in a study in a series of folder, one for each
%participant. Eg folder_root ... \C01
%                            ... \C02  
% This file will provide an example for how to use many of the scripts
% created by Carson for processing of EEG datasets. 

%SET the pathname to the folder where the array of folders are located!
pathname='Z:\19_Carson_Berry\Study Data\Edited\to_process';
%'Z:\18_Oscar_Ortiz\Project 601 - Neurophysiological study of neuropathic pain after SCI';

%%Import channel location, filter [1 40]Hz, epoch data
process_EEG_folder(pathname);

%%Manually inspect data for extra epochs 
%Eg. for the 'Cheps vs Leps' study, we stimulated 20 times. So we reduced
%the number of epochs to 20, usually by removing the first and/or last
%epoch (for cheps) if there were more than 20. 


%%Interpolate any channels if necessary
%If a channel was consistently noisy (The way to quantitatively check this
%is to run the 'Tools'-> 'Reject_data_epochs' ->'Reject by extreme values' function
%from EEGLAB... If a channel has activity greater than +/- 100 uV (or even
%75) it is likely artifactual noise. 



%%Run ICA on the data
runica_folder(pathname);

%%Inspect the components- reject artifactual and ocular noise components.
% this can be done systematically through with the 'SASICA' toolbox. This
% is a tool that provides information about statistical assumptions around
% spatial/temporal autocorrelation and randomness. IT provides this
% information graphically for each component (whether it's outside 2 SD)
% and makes recommendations about which components to exclude. I generally
% included as much data as I could, only excluding the most noisy/random
% data with localized activations. 


%Rereference to FZ
fz_reference(pathname); 

%get filenames to add to study. 
files_to_add=get_file_list(pathname, 'set');
%save the files from pathname to the FZ study. 



%%Add the new files to the FZ study. 
%...make a program to do this? 

%%Rereference to mastoids/ears
m_reference(pathname); 

%%Add the new files to the mastoid study 
%...make a program to do this? 



%%Run a script to calculate the SNR of each recording. Will generate
%%figures of the SNR by trial, participant, and condition, saving the last
%%two. 
SNR_script;


%%Print ERP data from master studies. Will save 1 figure for each recording in the current
%%matlab path. 
latency_print_script; 







