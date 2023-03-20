function [out_B,out_E]= BdBtFwdElecPole( caltype, rho, h, nlayer, x0, y0, cos_a, sin_a, x, y, z, t )
    % cosfilter
    delta = log(10)/10;
    [~,~,coe_cos,coe_sin]=module_coe();
    % 坐标变换
    xal = (y-y0) * sin_a + (x-x0) * cos_a;
    yal = (y-y0) * cos_a - (x-x0) * sin_a;
    out_B = zeros(1,3);
    out_E = zeros(1,3);
    % ======================================================================
    % 计算简单坐标系下电偶极子的瞬变电磁响应
    Ht = zeros(1,3);Et = zeros(1,3);
    for k = 1: size(coe_cos,2)
        omg = exp((k-60)*delta)/t;
        [Hw,Ew]= HwFwdElecPole( omg, rho, h, nlayer, xal, yal, z );
        if strcmp(caltype,'ff')
            Ht = Ht + imag(Hw)/omg*coe_cos(1,k);
            Et = Et + imag(Ew)/omg*coe_cos(1,k);
        elseif strcmp(caltype,'df')
            Ht = Ht -imag(Hw)*coe_sin(1,k);
            Et = Et -imag(Ew)*coe_sin(1,k);
        end
    end
    % ======================================================================
    % 将倾斜坐标系的场值变换到整体坐标系
    Bt = 4*pi*1e-7*sqrt(2/pi)/t * Ht;
    out_B(1,1) = Bt(1,1)*cos_a - Bt(1,2)*sin_a;
    out_B(1,2) = Bt(1,1)*sin_a + Bt(1,2)*cos_a;
    out_B(1,3) = Bt(1,3);
    Et = sqrt(2/pi)/t * Et;
    out_E(1,1) = Et(1,1)*cos_a - Et(1,2)*sin_a;
    out_E(1,2) = Et(1,1)*sin_a + Et(1,2)*cos_a;
    out_E(1,3) = Et(1,3);
end