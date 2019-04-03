function [MD,GD,FD] = Disk_for_rotor(Disk_Number,Disk_Type,Nof,time,nt,Omega,med,phid)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%% 质量盘单元参数
time =time';
% 配重
N_L = 16; 
N_S = 10;
m_bolt = [0.2,2.0];
% Large Steel     大钢质量盘相关参数 配重孔半径30mm
M_LS=0.8;                  
R_LS=37.5/1000;
r_LS=5/1000;
Jp_LS=M_LS*(R_LS^2+r_LS^2)/2;
Jd_LS=Jp_LS/2;
e_LS = 30/1000; 
% Small Aluminium 小铝质量盘相关参数 配重孔半径20mm    
M_SA=0.08;                 
R_SA=25/1000;
r_SA=5/1000;
Jp_SA=M_SA*(R_SA^2+r_SA^2)/2;
Jd_SA=Jp_SA/2;
e_SA = 20/1000; 
% Laege Aluminium 大铝质量盘相关参数 配重孔半径30mm
M_LA=0.274;                
R_LA=37.5/1000;
r_LA=5/1000;
Jp_LA=M_LA*(R_LA^2+r_LA^2)/2;
Jd_LA=Jp_LA/2;
e_LA = 30/1000;
%%
MD=zeros(Nof);
GD=zeros(Nof);
FD=zeros(Nof,nt);
nd = length(Disk_Number);
for i=1:nd 
    switch Disk_Type{i}
        case 'LS'
            md = M_LS;
            Jp = Jp_LS;
            Jd = Jd_LS;
            ed = e_LS;
        case 'LA'
            md = M_LA;
            Jp = Jp_LA;
            Jd = Jd_LA;
            ed = e_LA;
        case 'SA'
            md = M_SA;
            Jp = Jp_SA;
            Jd = Jd_SA;
            ed = e_SA;
    end    
    Md = [md 0 0 0 0;0 md 0 0 0;0 0 md 0 0;0 0 0 Jd 0;0 0 0 0 Jd];
    Gd = [zeros(3,5);0 0 0 0 -Jp;0 0 0 Jp 0];
    MD = DiskAssemble(MD,Md,Disk_Number(i));
    GD = DiskAssemble(GD,Gd,Disk_Number(i));
    Fd(1:5,:) = [zeros(size(time));med(i)*ed*Omega^2*cos(Omega*time + phid(i));med(i)*ed*Omega^2*sin(Omega*time + phid(i));zeros(size(time));zeros(size(time))];     % force vector of disk
    FD = DiskForceAssemble(FD,Fd,Disk_Number(i));
end
%%
function y = DiskForceAssemble(FD,Fd,i)
FD(5*i-4,:) = FD(5*i-4,:) + Fd(1,:);
FD(5*i-3,:) = FD(5*i-3,:) + Fd(2,:);
FD(5*i-2,:) = FD(5*i-2,:) + Fd(3,:);
FD(5*i-1,:) = FD(5*i-1,:) + Fd(4,:);
FD(5*i,:)   = FD(5*i,:)   + Fd(5,:);
y=FD;
%%
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