function  savedata(prefix,caltype,rec,nrec,times,Bt,Et)
    outfile_Etcomx=[prefix,'_',caltype,'_Ex.dat'];
    outfile_Etcomy=[prefix,'_',caltype,'_Ey.dat'];
    outfile_Etcomz=[prefix,'_',caltype,'_Ez.dat'];
    outfile_Btcomx=[prefix,'_',caltype,'_Bx.dat'];
    outfile_Btcomy=[prefix,'_',caltype,'_By.dat'];
    outfile_Btcomz=[prefix,'_',caltype,'_Bz.dat'];
    outprefix_rec={'x';'y';'z'};
    format1=['%s,',repmat('%f,',1,nrec),'\n'];
    format2=['%e,',repmat('%e,',1,nrec),'\n'];
    % Ex
    fid1=fopen(outfile_Etcomx,'w');
    for i=1:size(rec,2)
        fprintf(fid1,format1,outprefix_rec{i,:},rec(:,i));
    end
    fprintf(fid1,format2,[times',Et(:,1:3:3*nrec)]');
    fclose(fid1);
    % Ey
    fid1=fopen(outfile_Etcomy,'w');
    for i=1:size(rec,2)
        fprintf(fid1,format1,outprefix_rec{i,:},rec(:,i));
    end
    fprintf(fid1,format2,[times',Et(:,2:3:3*nrec)]');
    fclose(fid1);
    % Ez
    fid1=fopen(outfile_Etcomz,'w');
    for i=1:size(rec,2)
        fprintf(fid1,format1,outprefix_rec{i,:},rec(:,i));
    end
    fprintf(fid1,format2,[times',Et(:,3:3:3*nrec)]');
    fclose(fid1);
    % Bx
    fid1=fopen(outfile_Btcomx,'w');
    for i=1:size(rec,2)
        fprintf(fid1,format1,outprefix_rec{i,:},rec(:,i));
    end
    fprintf(fid1,format2,[times',Bt(:,1:3:3*nrec)]');
    fclose(fid1);
    % By
    fid1=fopen(outfile_Btcomy,'w');
    for i=1:size(rec,2)
        fprintf(fid1,format1,outprefix_rec{i,:},rec(:,i));
    end
    fprintf(fid1,format2,[times',Bt(:,2:3:3*nrec)]');
    fclose(fid1);
    % Bz
    fid1=fopen(outfile_Btcomz,'w');
    for i=1:size(rec,2)
        fprintf(fid1,format1,outprefix_rec{i,:},rec(:,i));
    end
    fprintf(fid1,format2,[times',Bt(:,3:3:3*nrec)]');
    fclose(fid1);
end