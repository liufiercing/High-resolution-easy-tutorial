clc;clear;close all;
%% Ԥ�����
set(0,'defaultfigurecolor','w');FONTSIZE=18;   FONTNAME='Times New Roman'; LINEWIDTH=2;

N=60;       %% ����ϵ��������
trace =30;    %%ģ�͵���
%% ��Ʒ���ϵ��ģ��
% reflectivity
modle_name = '1wedge1';
% 
[ref]= reflectivity_modling(N, modle_name, trace);
%% wavelet
dt=0.001;
fm=30;   trun_time=0.04;  t=-trun_time:dt:trun_time;
w=(1-2*(pi*fm*t).^2).*exp(-(pi*fm*t).^2);
nWaveSampPoint=length(w);
W_temp=convmtx(w',length(ref(:,1)));
WW=W_temp(((nWaveSampPoint-1)/2)+1:end-((nWaveSampPoint-1)/2),:);     % full_freq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �޻�
seis=WW*ref;
seis=pnoise(seis,0.1);   %%����
%% WW*r=seis  ,r  ���ʶ�����  |a-b| + mu|a|
% I = eye(100)
% r = pinv(WW'*WW + I)*WW'*seis;
% r = pinv(WW'*WW)*WW'*seis;
%% SolverFunc
% �������
mu2 = 0;
mu1 = 0.05;
maxiter = 150;
p = 1;
tol = 10e-20;
D = 0;
%% ���WW*r=seis 
r_inv = zeros(size(ref));
for i = 1 : size(seis,2)
    [r_inv(:,i)] = SolverFunc(seis(:,i),WW,mu1,mu2,D,maxiter,p,tol);
end
%%
figure 
subplot(1,3,1)
title('ԭʼģ��')
wigb(ref)

subplot(1,3,2)
title('�ϳ�����')
wigb(seis)

subplot(1,3,3)
title('���ݽ��')
wigb(ref)


%%