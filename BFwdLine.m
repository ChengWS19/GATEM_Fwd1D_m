function [Bt,Et]= BFwdLine(cmd,src,rec,t)

    ndipole = cmd.ndipole;
    l_source = sqrt( (src(1)-src(3))^2 + (src(2)-src(4))^2 );
    dl = l_source/ndipole;
    dx = -(src(1)-src(3))/ndipole;
    dy = -(src(2)-src(4))/ndipole;
    Elecpole = zeros(ndipole,4);
    for i = 1: ndipole
        Elecpole(i,1) = src(1) + (i-1)*dx + dx/2;
        Elecpole(i,2) = src(2) + (i-1)*dy + dy/2;
    end
    Elecpole(:,3) = (src(3)-src(1))/l_source;
    Elecpole(:,4) = (src(4)-src(2))/l_source;

    Bt = zeros(1,3);    Et = zeros(1,3);
    for i = 1: ndipole
        [Bt0,Et0]= BdBtFwdElecPole( cmd.caltype, cmd.res, cmd.thickness, cmd.nlayer, Elecpole(i,1), Elecpole(i,2), Elecpole(i,3), Elecpole(i,4), rec(1), rec(2), rec(3), t);
        Bt = Bt + Bt0;
        Et = Et + Et0;
    end

    Bt = Bt*dl;  
    Et = Et*dl;  
end