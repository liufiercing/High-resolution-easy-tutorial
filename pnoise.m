function datans=pnoise(data,nsr,seed)
%�˺������ڶ�ԭʼ���ݼ����������
%����----data��ԭʼ���ݡ�nsr�����űȡ�seed����������������ӡ�
%���----datans������������������

if nargin==2
    seed=10;
end

if nargin==1
    nsr=0;
    seed=10;
end

randn('state',seed);
s_ener= norm(data(:))^2;%���źŵ�����
zao=randn(size(data)); %rand(size(d))*2-1;
zao_ener=norm(zao(:))^2;
factor=sqrt((s_ener/zao_ener)*nsr);
noise=factor*zao;
datans=data+noise;%�����������CDP��ķ���ϵ��