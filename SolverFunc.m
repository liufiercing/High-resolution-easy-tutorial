%function [r] = L2_Lpsolver(seis,W,mu1,mu2,D,maxiter,p,tol)
function [r] = SolverFunc(seis,W,mu1,mu2,D,maxiter,p,tol)
% p = 2
% tol = 10e-10
 A=W'*W+mu2*(D'*D);
 inib=W'*seis;
 r=inib;
  for k=1:maxiter 
    r1=r;
    Q = mu1*diag(1./((abs(r)).^(2-p)+eps)); % p
    Matrix = A + Q;
    G = Matrix\W';
    r = Matrix\inib;
    r2=r;
    if sum(abs(r2-r1))/sum(abs(r1)+abs(r2))<0.5*tol
        break;
    end   
  end
end