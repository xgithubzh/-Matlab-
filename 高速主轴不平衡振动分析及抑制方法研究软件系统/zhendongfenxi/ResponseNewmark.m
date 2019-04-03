%% ¼òÐ³¼¤Àø 
function [d,v,a] = ResponseNewmark(M,K,C,nt,dt)
% n - node
global f;
alfa=0.25; beta=0.5; 
a0=1/alfa/dt/dt; a1=beta/alfa/dt; a2=1/alfa/dt;a3=1/2/alfa-1; a4=beta/alfa-1; a5=dt/2*(beta/alfa-2); a6=dt*(1-beta); a7=dt*beta; 
Ke=K+a0*M+a1*C;
[m,~] = size(M);
d=zeros(m,nt); v=zeros(m,nt); a=zeros(m,nt); 
for i=2:nt 
    fe=f(:,i)+M*(a0*d(:,i-1)+a2*v(:,i-1)+a3*a(:,i-1))+C*(a1*d(:,i-1)+a4*v(:,i-1)+a5*a(:,i-1));
    d(:,i)=Ke\fe;
    a(:,i)=a0*(d(:,i)-d(:,i-1))-a2*v(:,i-1)-a3*a(:,i-1);
    v(:,i)=v(:,i-1)+a6*a(:,i-1)+a7*a(:,i);
end
%% 
% % function [d,v,a] = Wilsontheta(M,C,K,Ft,q0,dq0)  
% % function [d,v,a] = centuredivision(M,C,K,Ft,q0,dq0)
% % function d = Response_complex(M,K,C,F,w,dt,nt,n) %¸´Ä£Ì¬µþ¼Ó·¨
% n = length(M);
% A = [C M;M zeros(n)];B = [K zeros(n);zeros(n) -M];
% % (s*A + B)*Phi = 0
% [Phi,s1] = eig(-inv(A)*B);
% [s1,k1] = sort(diag(s1));         Phi = Phi(:,k1);
% s1 = s1([2:2:2*n,1:2:2*n-1]);  Phi = Phi(:,[2:2:2*n,1:2:2*n-1]);
% % (A'*s+B')*Psi = 0
% [Psi,s2] = eig(-inv(A.')*B.');        [s2,k2] = sort(diag(s2));         Psi = Psi(:,k2);
% s2 = s2([2:2:2*n,1:2:2*n-1]);          Psi = Psi(:,[2:2:2*n,1:2:2*n-1]);
% %% A¡¢B ²»¶Ô³Æ
% a = Psi.'*A*Phi ;b = Psi.'*B*Phi;m = Psi(1:n,:).'*M*Phi(1:n,:);c = Psi(1:n,:).'*C*Phi(1:n,:);k = Psi(1:n,:).'*K*Phi(1:n,:);
% s = diag(s2);
% 
% % Ps2 = A*Phi*s+ B*Phi
% % Psi.'*Ps2;
% % 
% % a*s + b
% % 
% % Ps1 = s.'*Psi.'*A + Psi.'*B
% % Ps1.'*Phi
% % 
% % s.'*a + b
% phi1 = Phi(1:n,1:n);phi2 = Phi(1:n,n+1:2*n);
% psi1 = Psi(1:n,1:n);psi2 = Psi(1:n,n+1:2*n);
% a1 = a(1:n,1:n);   a2 = a(n+1:2*n,n+1:2*n);
% s1 = s(1:n,1:n);   s2 = s(n+1:2*n,n+1:2*n);
% for r =1:n
%     Hiw{r} = phi1(:,r)*(1i*w - s1(r,r))^(-1)*a1(r,r)^(-1)*psi1(:,r).' +  phi2(:,r)*(1i*w - s2(r,r))^(-1)*a2(r,r)^(-1)*psi2(:,r).'; 
% end
% Hw = 0;
% for r = 1:n
%     Hw = Hw + Hiw{r};
% end



