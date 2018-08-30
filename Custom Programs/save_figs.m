%%Get all the figures in the folder and saves them as PDF
function save_figs(pathname)

file_struct_list = dir([pathname filesep() '*.fig']);  %% get list of .set files in the pathname specified
filename_cell_list = {file_struct_list.name};  %% extract the filenames into a cellarray
filename_list=deblank(char(filename_cell_list));

    length_filename=size(filename_list);
    
    
    %iterate through .fig files and open and print them...
    for k=1:length_filename(1)
        
         filename=deblank(filename_list(k, :));
          [~,filename_text,~]= fileparts(strcat(pathname,'\',filename));
          
         fig=openfig(filename);
         saveas(fig,filename_text,'pdf');
      
         
         close(gcf); %close current figure handle
                 
    end
    
    
end