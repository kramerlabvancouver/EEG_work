function  filename_list  = get_file_list( pathname, filetype )
%%get_file_list- A function to provide a char list of all the specified
%%filetypes in a folder given by pathname. 
%   Inputs: 

%             pathname- type char
%             - A windows style directory location of the folder of interest. 
%             eg. 'Z:\19_Carson_Berry\EEG\MATLAB\trunk\src'
%             
%             
%            filetype - type char 
%            - a filetype 
%            eg. 'jpg'
% 
%     Outputs: 
%             
%             filename_list char array 
%                 an array of strings containing the names of all the wanted files in the folder. 

file_struct_list = dir([pathname filesep() '*.' filetype]);  %% get list of .set files in the pathname specified
filename_cell_list = {file_struct_list.name};  %% extract the filenames into a cellarray
filename_list=deblank(char(filename_cell_list));


end

