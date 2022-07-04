function datans=pnoise(data,nsr,seed)
%此函数用于对原始数据加入随机噪声
%输入----data：原始数据。nsr：噪信比。seed：生成随机数的种子。
%输出----datans：加入了噪声的数据

if nargin==2
    seed=10;
end

if nargin==1
    nsr=0;
    seed=10;
end

randn('state',seed);
s_ener= norm(data(:))^2;%求信号的能量
zao=randn(size(data)); %rand(size(d))*2-1;
zao_ener=norm(zao(:))^2;
factor=sqrt((s_ener/zao_ener)*nsr);
noise=factor*zao;
datans=data+noise;%加入噪声后该CDP点的反射系数