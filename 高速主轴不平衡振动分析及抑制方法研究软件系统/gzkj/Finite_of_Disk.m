function [MD,GD,FD] = Finite_of_Disk(a,b,Ld,ed,phid,Nelement_of_Disk,Nof)
%% Finite elment model of distributed disks
% Time£º2014/09/02 21:13
%% 
global Omega t rhod;     % rotation of the spindle and time 
global Md Gd
% rhod=[7806 7800 7800 7800 2700 2700 2700 2700 2700 7800 7800 7800];        % density of the different disk 
nd=length(a);
MD=zeros(Nof);
GD=zeros(Nof);
FD=zeros(Nof,1);
for i=1:nd 
    Ad = pi*(b(i)^2-a(i)^2);
    mD = rhod(1)*Ad*Ld(i);
    ID = 1/4*mD*(b(i)^2-a(i)^2);
    JD = 1/2*mD*(b(i)^2-a(i)^2);
    Md = [mD 0 0 0 0;0 mD 0 0 0;0 0 mD 0 0;0 0 0 ID 0;0 0 0 0 ID];
    Gd = [zeros(3,5);0 0 0 0 -JD;0 0 0 JD 0];
    Fd = [0;mD*ed(i)*Omega^2*cos(Omega*t + phid(i));mD*ed(i)*Omega^2*sin(Omega*t + phid(i));0;0];     % force vector of disk
    MD = DiskAssemble(MD,Md,Nelement_of_Disk(i));
    GD = DiskAssemble(GD,Gd,Nelement_of_Disk(i));
    FD = DiskForceAssemble(FD,Fd,Nelement_of_Disk(i));
end 

function y = DiskForceAssemble(FD,Fd,i)

FD(5*i-4,1) = FD(5*i-4,1) + Fd(1,1);
FD(5*i-3,1) = FD(5*i-3,1) + Fd(2,1);
FD(5*i-2,1) = FD(5*i-2,1) + Fd(3,1);
FD(5*i-1,1) = FD(5*i-1,1) + Fd(4,1);
FD(5*i,1)   = FD(5*i,1)   + Fd(5,1);

y=FD;

function y = DiskAssemble(K,k,i)

K(5*i-4,5*i-4) = K(5*i-4,5*i-4) + k(1,1);  K(5*i-4,5*i-3) = K(5*i-4,5*i-3) + k(1,2);
K(5*i-4,5*i-2) = K(5*i-4,5*i-2) + k(1,3);  K(5*i-4,5*i-1) = K(5*i-4,5*i-1) + k(1,4);
K(5*i-4,5*i)   = K(5*i-4,5*i)   + k(1,5);

K(5*i-3,5*i-4) = K(5*i-3,5*i-4) + k(2,1);  K(5*i-3,5*i-3) = K(5*i-3,5*i-3) + k(2,2);
K(5*i-3,5*i-2) = K(5*i-3,5*i-2) + k(2,3);  K(5*i-3,5*i-1) = K(5*i-3,5*i-1) + k(2,4);
K(5*i-3,5*i)   = K(5*i-3,5*i)   + k(2,5);

K(5*i-2,5*i-4) = K(5*i-2,5*i-4) + k(3,1);  K(5*i-2,5*i-3) = K(5*i-2,5*i-3) + k(3,2);
K(5*i-2,5*i-2) = K(5*i-2,5*i-2) + k(3,3);  K(5*i-2,5*i-1) = K(5*i-2,5*i-1) + k(3,4);
K(5*i-2,5*i)   = K(5*i-2,5*i)   + k(3,5);

K(5*i-1,5*i-4) = K(5*i-1,5*i-4) + k(4,1);  K(5*i-1,5*i-3) = K(5*i-1,5*i-3) + k(4,2);
K(5*i-1,5*i-2) = K(5*i-1,5*i-2) + k(4,3);  K(5*i-1,5*i-1) = K(5*i-1,5*i-1) + k(4,4);
K(5*i-1,5*i)   = K(5*i-1,5*i)   + k(4,5);

K(5*i,5*i-4) = K(5*i,5*i-4) + k(5,1);  K(5*i,5*i-3) = K(5*i,5*i-3) + k(5,2);
K(5*i,5*i-2) = K(5*i,5*i-2) + k(5,3);  K(5*i,5*i-1) = K(5*i,5*i-1) + k(5,4);
K(5*i,5*i)   = K(5*i,5*i)   + k(5,5);

y=K;