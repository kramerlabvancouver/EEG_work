%%UNFINISHED>>> NOT FUNCTIONAL> 
function ALLEEG=make_study(check)

if(check='yes')
    

study_path='Z:\19_Carson_Berry\Study Data\Edited\clean\Ear_ref'; 
filename= {'Participant_C01_Trial_A.set';...
    'Participant_C01_Trial_C.set';...
    'Participant_C01_Trial_K.set';...
    'Participant_C01_Trial_Z.set';...
    'Participant_C02_Trial_A.set';...
    'Participant_C02_Trial_C.set';...
    'Participant_C02_Trial_K.set';...
    'Participant_C02_Trial_Z.set';...
    'Participant_C03_Trial_A.set';...
    'Participant_C03_Trial_C.set';...
    'Participant_C03_Trial_K.set';...
    'Participant_C03_Trial_Z.set';...
    'Participant_C04_Trial_A.set';...
    'Participant_C04_Trial_C.set';...
    'Participant_C04_Trial_K.set';...
    'Participant_C04_Trial_Z.set';...
    'Participant_C05_Trial_A.set';...
    'Participant_C05_Trial_C.set';...
    'Participant_C05_Trial_K.set';...
    'Participant_C05_Trial_Z.set';...
    'Participant_C06_Trial_A.set';...
    'Participant_C06_Trial_C.set';...
    'Participant_C06_Trial_K.set';...
    'Participant_C06_Trial_Z.set';...
    'Participant_C07_Trial_A.set';...
    'Participant_C07_Trial_C.set';...
    'Participant_C07_Trial_K.set';...
    'Participant_C07_Trial_Z.set';...
    'Participant_C09_Trial_A.set';...
    'Participant_C09_Trial_C.set';...
    'Participant_C09_Trial_K.set';...
    'Participant_C10_condition_1.set';...
    'Participant_C10_condition_3.set';...
    'Participant_C11_condition_4.set';...
    'Participant_C12_condition_1.set';...
    'Participant_C12_condition_2.set';...
    'Participant_C13_condition_1.set';...
    'Participant_C13_condition_3.set';...
    'Participant_C10_condition_2.set';...
    'Participant_C10_condition_4.set';...
    'Participant_C11_condition_1.set';...
    'Participant_C11_condition_2.set';...
    'Participant_C14_condition_2.set';...
    'Participant_C14_condition_3.set';...
    'Participant_C15_condition_2.set';...
    'Participant_C15_condition_3.set';...
    'Participant_C16_condition_3.set';...
    'Participant_C16_condition_4.set';...
    'Participant_C11_condition_3.set';...
    'Participant_C12_condition_3.set';...
    'Participant_C13_condition_2.set';...
    'Participant_C14_condition_1.set';...
    'Participant_C15_condition_1.set';...
    'Participant_C15_condition_4.set';...
    'Participant_C17_condition_2.set';...
    'Participant_C17_condition_4.set';...
    'Participant_C18_condition_2.set';...
    'Participant_C18_condition_3.set';...
    'Participant_C20_condition_2.set'};
    

[STUDY ALLEEG] = std_editset( STUDY, [], 'commands', { ...
	{ 'index' 1 'load' [study_path filesep() filename(1)] 'subject' 'C01' 'condition' '3' }, ...
	{ 'index' 2 'load' [study_path filesep() filename(2)] 'subject' 'C01' 'condition' '1' }, ...
    { 'index' 3 'load' [study_path filesep() filename(3)] 'subject' 'C01' 'condition' '4' }, ...
    { 'index' 4 'load' [study_path filesep() filename(4)] 'subject' 'C01' 'condition' '2' }, ...
    
    { 'index' 5 'load' [study_path filesep() filename(5)] 'subject' 'C02' 'condition' '3' }, ...
	{ 'index' 6 'load' [study_path filesep() filename(6)] 'subject' 'C02' 'condition' '1' }, ...
    { 'index' 7 'load' [study_path filesep() filename(7)] 'subject' 'C02' 'condition' '4' }, ...
    { 'index' 8 'load' [study_path filesep() filename(8)] 'subject' 'C02' 'condition' '2' }, ...
    
    { 'index' 9 'load' [study_path filesep() filename(9)] 'subject' 'C03' 'condition' '3' }, ...
	{ 'index' 10 'load' [study_path filesep() filename(10)] 'subject' 'C03' 'condition' '1' }, ...
    { 'index' 11 'load' [study_path filesep() filename(11)] 'subject' 'C03' 'condition' '4' }, ...
    { 'index' 12 'load' [study_path filesep() filename(12)] 'subject' 'C03' 'condition' '2' }, ...
    
    { 'index' 13 'load' [study_path filesep() filename(13)] 'subject' 'C04' 'condition' '3' }, ...
	{ 'index' 14 'load' [study_path filesep() filename(14)] 'subject' 'C04' 'condition' '1' }, ...
    { 'index' 15 'load' [study_path filesep() filename(15)] 'subject' 'C04' 'condition' '4' }, ...
    { 'index' 16 'load' [study_path filesep() filename(16)] 'subject' 'C04' 'condition' '2' }, ...
    
    { 'index' 17 'load' [study_path filesep() filename(17)] 'subject' 'C05' 'condition' '3' }, ...
	{ 'index' 18 'load' [study_path filesep() filename(18)] 'subject' 'C05' 'condition' '1' }, ...
    { 'index' 19 'load' [study_path filesep() filename(19)] 'subject' 'C05' 'condition' '4' }, ...
    { 'index' 20 'load' [study_path filesep() filename(20)] 'subject' 'C05' 'condition' '2' }, ...
    
    });

else
    %%load study
    
end



end
    