SOI=14; %subject of interest, 9, 10, 12, 14 best
    figure; hold on;
    subplot (2,2,1); plot(x, CZ_data(cond1(SOI),:), 'color', 'b'); hold on; 
    plot(x, CZ_data(cond2(SOI),:),'color','r'); hold on;
    set(gca,'Ydir','reverse'); hold on;
    legend({'CHEPS Placebo', 'CHEPS Capsaicin'}, 'location', 'southwest');
    title('Single Subject, C14 Vertex Electrode ERP'); hold on;
     hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    
    subplot (2,2,3); plot(x, CZ_data(cond3(SOI),:), 'color', 'b'); hold on; 
    plot(x, CZ_data(cond4(SOI),:),'color','r'); hold on;
    set(gca,'Ydir','reverse'); hold on;
    legend({'LEPS Placebo', 'LEPS Capsaicin'}, 'location', 'southwest');
     hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    
    subplot (2,2,2); plot(x, C3_data(cond1(SOI),:), 'color', 'b'); hold on; 
    plot(x, C3_data(cond2(SOI),:),'color','r'); hold on;
    set(gca,'Ydir','reverse'); hold on;
    legend({'CHEPS Placebo', 'CHEPS Capsaicin'}, 'location', 'southwest'); 
    title('Single Subject, C14 Contralateral Electrode ERP'); hold on;
     hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
    
     subplot (2,2,4); plot(x, C3_data(cond3(SOI),:), 'color', 'b'); hold on; 
    plot(x, C3_data(cond4(SOI),:),'color','r'); hold on;
    set(gca,'Ydir','reverse'); hold on;
    legend({'LEPS Placebo', 'LEPS Capsaicin'}, 'location', 'southwest'); 

    
     hold on; ylabel('Scalp Potential (uV)');
    hold on; xlabel('Time (ms)');
        hold off;
    