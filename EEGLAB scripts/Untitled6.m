%%testing the merge of multiple EEG files to run ICA on and get *REALLY*
%%clean ICA components

cheps_index=find(ALLEEG.condition=='1'||'2');

CHEPS_merged=pop_mergeset(ALLEEG, cheps_index, 0);