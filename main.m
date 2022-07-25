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
dt=0.001; % 1ms
fm=30;   trun_time=0.04;  t=-trun_time:dt:trun_time;
w=(1-2*(pi*fm*t).^2).*exp(-(pi*fm*t).^2);
nWaveSampPoint=length(w);
W_temp=convmtx(w',length(ref(:,1)));  %% ʱ��
WW=W_temp(((nWaveSampPoint-1)/2)+1:end-((nWaveSampPoint-1)/2),:);     % full_freq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �޻�  ��ת ʱ�� ������
seis=WW*ref;
%%
%seis=pnoise(seis,0.1);   %%����
% r = pinv(WW'*WW )*WW'*seis; % ���϶���
% r = pinv(WW'*WW + I)*WW'*seis;  % ���϶��� G
%% WW*r=seis  ,r  ���ʶ�����  |a-b| + mu|a|
% seis -> ref
% Ax = b A ���� 100000*56  56*1118888
% A'Ax = A'b
% x =  (A'A)^{-1}A'b
% I = eye(100)
%% SolverFunc  ADMM
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

%% ��ά
dt = 0.002;
[Am_seis, f]=show_amp(seis,dt);
[Am_r_inv, ~]=show_amp(r_inv,dt);
[Am_r_ref, ~]=show_amp(ref,dt);
%
figure
plot(Am_seis,'Color','k','linewidth',2.5);
hold on
plot(Am_r_inv,'Color','r','linewidth',2.5);
plot(Am_r_ref,'-b','linewidth',2.5);
xlim([0 150])
%% һά
dt = 0.002;
[Am_seis, f]=show_amp_one(seis(:,15),dt);
[Am_r_inv, ~]=show_amp_one(r_inv(:,15),dt);
[Am_r_ref, ~]=show_amp_one(ref(:,15),dt);
%
figure
plot(Am_seis,'Color','k','linewidth',2.5);
hold on
plot(Am_r_inv,'Color','r','linewidth',2.5);
plot(Am_r_ref,'Color','b',linewidth',2.5);
xlim([0 150])

