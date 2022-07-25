function [Am0, f]=show_amp(wave,dt)
[M,N]=size(wave);
fc=1/(2*dt);f=0:1:fc;df=2*fc/(1024*1024-1);
nn=round(f./df+1);
for i=1:N
ft_wave1=fft(wave(:,i),1024*1024);
ft_wave(:,i)=abs(ft_wave1(nn));
end
Am0 =(sum(ft_wave'))'/N;
Am0=Am0/max(Am0); % 对振幅进行归一化
end

