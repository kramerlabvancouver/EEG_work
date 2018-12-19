function fig=plot_erp_CI(CZ_data, title)
    mean_cz=mean(CZ_data);                            %mean data
    SEM_cz=std(CZ_data)/sqrt(size(CZ_data,1));    %Standard Error
    CI95=tinv([0.025 0.975],size(CZ_data,1)-1);                               %T-Score
    ERP_CI95=bsxfun(@times, SEM_cz,CI95(:));  %Confidence Intervals 
    
                                                        
    x=-1000:0.25:1999.75;
    fig=figure;
    plot(x,mean_cz)
    hold on;
    plot(x,ERP_CI95+mean_cz);
    hold on;
    title(title);
    legend;
       hold off;

end