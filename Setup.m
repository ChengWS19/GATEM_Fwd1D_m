clear;clc;close all
start=tic;
%% ��������ģ��
cmd = {};
cmd.model='model1';
cmd.nlayer = 2;
cmd.res = [100,10];
cmd.thickness = [200];
%% ����Դ�͵���������ʱ�䡢���յ�
cmd.I0 = 1;
cmd.t = logspace(-5, -2, 50);
% Դ
cmd.nsource = 1;
cmd.src = [-50, 0, 50, 0];
cmd.ndipole = 10;
% ���յ�
cmd.drec = 10;
cmd.rec(:,1)=100:cmd.drec:500;
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
cmd.numthreads=6;    % �����߳���
[times,Bt,Et] = GATEM_Fwd1D(cmd);
runtime=toc(start);
disp(['ʱ���ѹ�',num2str(runtime),'s'])
%% ���������������
savedata(cmd.model,cmd.caltype,cmd.rec,cmd.nrec,times,Bt,Et);
%% ��ͼ������
plotflag='Ex';
plotdata(cmd.model,cmd.caltype,plotflag,cmd.nrec,cmd.rec,times,Bt,Et);

