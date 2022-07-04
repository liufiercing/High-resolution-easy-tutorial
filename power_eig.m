function mu = power_eig(start,Hop,PARAM)
% power_eig: estimates largest eigenvalue for an operator using the power
% method
%
% INPUT
%       start : starting model (typically a matrix of ones)
%       Hop   : operator whose largest eigen value is sought
%       PARAM : Parameters for operator Hop
%
% OUTPUT
%       mu    : estimate of largest eigen value
%

x=start;
it=10;      % Number of iterations

for k=1:it;
    y=Hop(Hop(x,PARAM,-1),PARAM,1);
    n=sum(conj(y(:)).*y(:));
    n=sqrt(n);
    x=y/n;
    aux=Hop(Hop(x,PARAM,-1),PARAM,1);
    mu = sum(conj(x(:)).*aux(:));
end

return;
