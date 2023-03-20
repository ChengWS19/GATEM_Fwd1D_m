function [hw,ew]= HwFwdElecPole( omg, rho, th, nlayer, x, y, z )
    u0 = 4*pi*1e-7;
    delta = log(10)/10;
    [Hankel0,Hankel1,~,~]=module_coe();
    r = sqrt(x^2+y^2);
    KK1 = zeros(nlayer,1);
    M = zeros(size(Hankel0,2),1);
    M1 = zeros(nlayer,1);
    for i = 1: nlayer
        KK1(i,1) = complex(0, omg*u0/rho(i));
    end
    for i = 1: size(Hankel0,2)
        M(i,1) = exp((i-59)*delta)/r;
    end
    hi1 = complex(0,0); hi4 = complex(0,0); hi5 = complex(0,0);
    hi6 = complex(0,0); hi7 = complex(0,0); hi8 = complex(0,0);
    hi9 = complex(0,0); hi10 = complex(0,0); 
    for i = 1: size(Hankel0,2)
        for j = 1: nlayer
            M1(j) = sqrt(M(i,1)^2-KK1(j,1));
        end
        % R* R
        rr1 = complex(1,0);
        r1 = complex(1,0);
        for j=nlayer:-1:2
            ctemp1=M1(j-1,1)/M1(j,1);
            rr1=coth(M1(j-1,1)*th(j-1)+acoth(ctemp1*rr1));
            ctemp2=rho(j-1)/rho(j);
            r1=coth(M1(j-1,1)*th(j-1)+acoth(ctemp1*ctemp2*r1));
        end
        % 
        ctemp = M(i,1)+M1(1,1)/rr1;
        hi1 = M(i,1)/ctemp*exp(M(i,1)*z)*Hankel1(1,i) + hi1;
        hi4 = M(i,1)^2/ctemp*exp(M(i,1)*z)*Hankel0(1,i) + hi4;
        hi5 = M(i,1)^2/ctemp*exp(M(i,1)*z)*Hankel1(1,i) + hi5;
        hi6 = 1/ctemp*exp(M(i,1)*z)*Hankel1(1,i)+hi6;
        hi7 = M(i,1)*M1(1,1)/r1*exp(M(i,1)*z)*Hankel0(1,i)+hi7;
        hi8 = M1(1,1)/r1*exp(M(i,1)*z)*Hankel1(1,i)+hi8;
        hi9 = M(i,1)/ctemp*exp(M(i,1)*z)*Hankel0(1,i)+hi9;

%         hi10 = M(i,1)*M1(1,1)/rr1*exp(M(i,1)*z)*Hankel1(1,i)+hi10;
        hi10 = M(i,1)^2*exp(M(i,1)*z)*Hankel1(1,i)+hi10;
    
    end
    hi1 = hi1/r; hi4 = hi4/r; hi5 = hi5/r;
    hi6 = hi6/r; hi7 = hi7/r; hi8 = hi8/r;
    hi9 = hi9/r; hi10 = hi10/r;
    cosp = x/r; sinp = y/r;
    
    iwu=complex(0,omg*u0);
    er=1/2/pi*cosp*(iwu/r*hi6-rho(1)*hi7+rho(1)/r*hi8);
    ep=1/2/pi*sinp*(iwu/r*hi6-iwu*hi9+rho(1)/r*hi8);
    ez=0; % ez=1/2/pi*cosp*(iwu*hi1-rho(1)*hi10); 
    hr = -1/2/pi * sinp * (hi1/r-hi4);
    hp = 1/2/pi * cosp * hi1/r;
    hz = 1/2/pi * sinp * hi5;

    hx = hr * cosp - hp * sinp;
    hy = hr * sinp + hp * cosp;
    hw = [hx, hy, hz];
    ex = er * cosp - ep * sinp;
    ey = er * sinp + ep * cosp;
    ew = [ex, ey, ez];
end


