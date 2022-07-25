clc;clear;close all;
%% 预设参数
set(0,'defaultfigurecolor','w');FONTSIZE=18;   FONTNAME='Times New Roman'; LINEWIDTH=2;

N=60;       %% 反射系数采样点
trace =30;    %%模型道数
%% 设计反射系数模型
% reflectivity
modle_name = '1wedge1';
% 
[ref]= reflectivity_modling(N, modle_name, trace);
%% wavelet
dt=0.001; % 1ms
fm=30;   trun_time=0.04;  t=-trun_time:dt:trun_time;
w=(1-2*(pi*fm*t).^2).*exp(-(pi*fm*t).^2);
nWaveSampPoint=length(w);
W_temp=convmtx(w',length(ref(:,1)));  %% 时移
WW=W_temp(((nWaveSampPoint-1)/2)+1:end-((nWaveSampPoint-1)/2),:);     % full_freq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 褶积  反转 时移 相乘相加
seis=WW*ref;
%%
%seis=pnoise(seis,0.1);   %%加噪
% r = pinv(WW'*WW )*WW'*seis; % 不合定性
% r = pinv(WW'*WW + I)*WW'*seis;  % 不合定性 G
%% WW*r=seis  ,r  不适定问题  |a-b| + mu|a|
% seis -> ref
% Ax = b A 矩形 100000*56  56*1118888
% A'Ax = A'b
% x =  (A'A)^{-1}A'b
% I = eye(100)
%% SolverFunc  ADMM
% 参数设计
mu2 = 0;
mu1 = 0.05;
maxiter = 150;
p = 1;
tol = 10e-20;
D = 0;
%% 求解WW*r=seis 
r_inv = zeros(size(ref));
for i = 1 : size(seis,2)
    [r_inv(:,i)] = SolverFunc(seis(:,i),WW,mu1,mu2,D,maxiter,p,tol);
end
%%
figure 
subplot(1,3,1)
title('原始模型')
wigb(ref)

subplot(1,3,2)
title('合成资料')
wigb(seis)

subplot(1,3,3)
title('反演结果')
wigb(ref)

%% 二维
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
%% 一维
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

