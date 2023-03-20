function plotdata(prefix,caltype,flag,nrec,rec,times,Bt,Et)
    % 选取分量
    if strcmp(flag,'Ex')
        data=Et(:,1:3:3*nrec);
    elseif strcmp(flag,'Ey')
        data=Et(:,2:3:3*nrec);
    elseif strcmp(flag,'Ez')
        data=Et(:,3:3:3*nrec);
    elseif strcmp(flag,'Bx')
        data=Bt(:,1:3:3*nrec);
    elseif strcmp(flag,'By')
        data=Bt(:,2:3:3*nrec);
    elseif strcmp(flag,'Bz')
        data=Bt(:,3:3:3*nrec);        
    else
        disp('绘图标识错误，检查后重试')
        return
    end
    if strcmp(caltype,'ff')
        label='';
        temp='(T)';
    elseif strcmp(caltype,'df')    
        label='d';
        temp='/dt(V/m^2)';
    else 
        disp('计算类型错误，检查后重试')
        return
    end
    % 绘图及参数设置
    color=rdbuMap();
    label_fontsize = 16;
    legend_fontsize = 12;
    label_fontname ='times new roman';
    figure
    leg_str=cell(nrec,1);
    for i=1:nrec
        loglog(times,abs(data),'color',color(i,:));
        leg_str{i}=[' RecPos = (',num2str(rec(i,1)),',',num2str(rec(i,2)),',',num2str(rec(i,3)),')'];
        hold on
    end
    h=legend(leg_str);
    set(gcf,'unit','inches','position',[0.5 0.5 8 6])
    set(gca,'FontName',label_fontname,'FontSize',label_fontsize,'TickLength',[0.02 0.01],'LineWidth',2)
    xlabel('t/s','FontName',label_fontname,'FontSize',label_fontsize,'FontWeight','bold');
    ylabel([label,flag,temp],'FontName',label_fontname,'FontSize',label_fontsize,'FontWeight','bold');
    set(h,'FontName',label_fontname,'FontSize',legend_fontsize,'FontWeight','normal')
    legend('boxoff')
    % 保存图像
    myFileName=[prefix,'_',label,flag];
    print('-dtiff','-r300',[myFileName,'.tiff']);
    disp(['plot ',myFileName,' finished!']);
    hold off
end


