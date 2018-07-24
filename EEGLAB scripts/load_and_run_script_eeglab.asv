%A function that preprocesses all of the .set data files located in a
%folder specified by 'pathname' input
%input: pathname
%output: Modified new EEGLAB .set files, saved appropriately. 

function load_and_run_script_eeglab(pathname)

file_struct_list = dir([pathname filesep() '*.set']);  %% get list of .set files in the pathname specified

filename_cell_list = {file_struct_list.name};  %% extract the filenames into a cellarray

filename_list=deblank(char(filename_cell_list));

    length_filename=size(filename_list);
      [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  
    
for k=1:length_filename(1)
    %subject = file_struct_list.name  %% this iterates over the elements of the cell array, one-by-one, setting the `filename` variable like a loop variable
  
    % save(debugging_variables);
     
 [ALLEEG]= process_smallcap(deblank(filename_list(k, :)), pathname, ALLEEG, k); %% perform your processing on file #k in the 'pathname' folder
 
end

fprintf('All done Processing!'); 
end