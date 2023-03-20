clear;clc;close all
start=tic;
%% 设置正演模型
cmd = {};
cmd.model='model1';
cmd.nlayer = 1;
cmd.res = [100];
cmd.thickness = [];
%% 设置源和电流、采样时间、接收点
cmd.I0 = 1;
cmd.t = logspace(-5, -2, 50);
% 源
cmd.nsource = 1;
cmd.src = [-50 0 50 0];
cmd.ndipole = 20;
% 接收点
cmd.drec = 10;
cmd.rec(:,1)=100:cmd.drec:100;
cmd.nrec=size(cmd.rec,1);
cmd.rec(:,2)=0:cmd.drec:0;
cmd.rec(:,3)=0:cmd.drec:0;
%% 参数检查
if size(cmd.src,1)~=cmd.nsource
    disp('发射源坐标输入错误，检查后重试')
    return
end
%% 设置计算类型并开始计算流程
cmd.caltype = 'ff';  % ff为场值，df为导数
cmd.numthreads=0;    % 并行线程数,与接收点个数相关，输入非正整数时默认单线程即未并行
[times,Bt,Et] = GATEM_Fwd1D(cmd);
runtime=toc(start);
disp(['时间已过',num2str(runtime),'s'])
delete(gcp('nocreate'))
%% 保存各个分量数据
savedata(cmd.model,cmd.caltype,cmd.rec,cmd.nrec,times,Bt,Et);
%% 绘图并保存
plotflag='Bz';
plotdata(cmd.model,cmd.caltype,plotflag,cmd.nrec,cmd.rec,times,Bt,Et);

