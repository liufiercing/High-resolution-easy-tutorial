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
dt=0.001;
fm=30;   trun_time=0.04;  t=-trun_time:dt:trun_time;
w=(1-2*(pi*fm*t).^2).*exp(-(pi*fm*t).^2);
nWaveSampPoint=length(w);
W_temp=convmtx(w',length(ref(:,1)));
WW=W_temp(((nWaveSampPoint-1)/2)+1:end-((nWaveSampPoint-1)/2),:);     % full_freq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 褶积
seis=WW*ref;
seis=pnoise(seis,0.1);   %%加噪
%% WW*r=seis  ,r  不适定问题  |a-b| + mu|a|
% I = eye(100)
% r = pinv(WW'*WW + I)*WW'*seis;
% r = pinv(WW'*WW)*WW'*seis;
%% SolverFunc
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


%%