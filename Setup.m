clear;clc;close all
start=tic;
%% ��������ģ��
cmd = {};
cmd.model='model1';
cmd.nlayer = 1;
cmd.res = [100];
cmd.thickness = [];
%% ����Դ�͵���������ʱ�䡢���յ�
cmd.I0 = 1;
cmd.t = logspace(-5, -2, 50);
% Դ
cmd.nsource = 1;
cmd.src = [-50 0 50 0];
cmd.ndipole = 20;
% ���յ�
cmd.drec = 10;
cmd.rec(:,1)=100:cmd.drec:100;
cmd.nrec=size(cmd.rec,1);
cmd.rec(:,2)=0:cmd.drec:0;
cmd.rec(:,3)=0:cmd.drec:0;
%% �������
if size(cmd.src,1)~=cmd.nsource
    disp('����Դ����������󣬼�������')
    return
end
%% ���ü������Ͳ���ʼ��������
cmd.caltype = 'ff';  % ffΪ��ֵ��dfΪ����
cmd.numthreads=0;    % �����߳���,����յ������أ������������ʱĬ�ϵ��̼߳�δ����
[times,Bt,Et] = GATEM_Fwd1D(cmd);
runtime=toc(start);
disp(['ʱ���ѹ�',num2str(runtime),'s'])
delete(gcp('nocreate'))
%% ���������������
savedata(cmd.model,cmd.caltype,cmd.rec,cmd.nrec,times,Bt,Et);
%% ��ͼ������
plotflag='Bz';
plotdata(cmd.model,cmd.caltype,plotflag,cmd.nrec,cmd.rec,times,Bt,Et);

