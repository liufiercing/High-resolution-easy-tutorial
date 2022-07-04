function [fdom,pha,maxamp]=SpectrumAnalysisFuncNonDisplay(data,dt,top,bottom,left,right,flag)
if dt>=0.5
    dt=dt/1000;
end
% load seis.mat;
% data=seis;
% dt=0.002;
if flag==0%单道
%top=1;bottom=175;
atrace=data(top:bottom);
wave=atrace;%seis(:,1);

fc=1/(2*dt);f=0:1:fc;df=2*fc/(1024*1024-1);
nn=round(f./df+1);
ft_wave=fft(wave,1024*1024);
ph_wave=angle(ft_wave);
ph_wave=ph_wave(nn)*180/pi;
smoothph=smooth(ph_wave,ceil(size(data,1)/4));
ft_wave=abs(ft_wave(nn));
end


if flag==1%多道
%多道
% top=1;bottom=175;
% left=50;right=80;
wave=data(top:bottom,left:right);

[M,N]=size(wave);

dt=0.002;fc=1/(2*dt);f=0:1:fc;df=2*fc/(1024*1024-1);
nn=round(f./df+1);
for i=1:N
    ft_wave1=fft(wave(:,i),1024*1024);
    ph_wave1=angle(ft_wave1)*180/pi;
    ft_wave(:,i)=abs(ft_wave1(nn));
    ph_wave(:,i)=(ph_wave1(nn));
end
ft_wave=(sum(ft_wave'))'/N;
ph_wave=(sum(ph_wave'))'/N;
smoothph=smooth(ph_wave,ceil(M/4));
spectrumcurve=ft_wave/max(ft_wave(:));
end
[maxamp,fdom]=max(spectrumcurve);
pha=smoothph(fdom);
fdom=fdom-1;



    

