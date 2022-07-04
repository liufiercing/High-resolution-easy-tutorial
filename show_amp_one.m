function [ft_wave]=show_amp_one(wave)
% [ft_wave]=show_amp_one(wave)
    dt=0.001;fc=1/(2*dt);f=0:1:fc;df=2*fc/(1024*1024-1);
    nn=round(f./df+1);
    ft_wave=fft(wave,1024*1024);
    ft_wave=abs(ft_wave(nn)/max(ft_wave(nn)));
    %ft_wave=abs(ft_wave(nn));
%% wave 1*N
% 
% N = length(wave);
% Y = fft(wave,N);  % computes the (fast) discrete fourier transform
% PSD = Y.*conj(Y)/N;  % Power spectrum (how much power in each freq)
% freq = 1/(dt*N)*(0:N);  %create the x-axis of frequencies in Hz
% L = 1:floor(N/2);  % only plot the first half of freqs
end