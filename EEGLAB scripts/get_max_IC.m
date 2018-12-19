function max_comp_num = get_max_IC(EEG) 
%%A function that gets the main independent component that is time locked
%%to the stimulus. This is accomplished by obtaining the maximum largest
%%contribution to the ERP as shown in the "figure; pop_envtopo(EEG, [-100
%%600] ,'limcontrib',[-100 600],'compsplot',[7],'title', 'Largest ERP
%%components of Participant_x_condition_y_Ear_ref','electrodes','off');"
%%command. The component with the maximum mean power of the back-projection
%%will be used. 

%inputs: 
 %EEG structure
 
 %outputs: 
    % component number that corresponds to the most important component of
    % back projection. 
    
 %variables: 
 % cmpvaroder - the order of maximum to minimum of (maxmimum mean power of
 % back projection) of each component
 
% cmpvars- the maxmimum mean power of back projection for each component. 

% figure; [cmpvarorder, cmpvars, cmpframes, cmptimes, cmpsplotted, sortvar]=envtopo(EEG.data, EEG.icaweights*EEG.icasphere , 'chanlocs', EEG.chanlocs(EEG.chaninfo.icachansind), 'timerange', [-100  800] ,'limcontrib',[100 700],'sortvar', 'mp','compsplot',[7],'title', ['Largest ERP components of ' EEG.setname],'electrodes', 'off');

if(EEG.condition=='1'||EEG.condition=='2')

figure; [cmpvarorder, cmpvars,cmpframes,cmptimes, cmpsplotted]=pop_envtopo(EEG, [-100  800] ,'limcontrib',[350 600],'compsplot',[7],'title', ['Largest CHEPS ERP components of ' EEG.setname],'electrodes','off', 'sortvar', 'pv');
    
elseif ( EEG.condition=='3'||EEG.condition=='4')   
figure; [cmpvarorder, cmpvars,cmpframes,cmptimes, cmpsplotted ]=pop_envtopo(EEG, [-100  800] ,'limcontrib',[150 400],'compsplot',[7],'title', ['Largest LEPS ERP components of ' EEG.setname],'electrodes','off', 'sortvar', 'pv');
    

end

cmpvars=flipud(cmpvars); %flip the components so that the index corresponds to the component which the (maxmimum mean power of back projection) activation is shown for. 

max_comp_pp=cmpvars(cmpvarorder(1));
max_comp_num=cmpvarorder(1);
max_comp_time=cmptimes(cmpvarorder(1)); %max component activity (seconds)


end
