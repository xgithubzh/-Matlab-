%% 绘制振型和频响函数
clear;clc;close all
%% Beam Data of Finite element
global qx qy qz my mz n Nof Omega t 
Lb=[8 8 8 7 10.9515 10.9515 13.5485 13.5485 7.5 7 7 7 7 7 8 8 6.5236 1.4764 7.5 7.5 13.5 12.501 5 5 5 14.65 14.65 14.65 14.65 14.65 14.65 14.65 14.65 14.65 ...
  14.65 8 9.9 9.9 9.9 9.9 9.9 7.5 7.5 1.4764 6.5236 8 11.6 11.6 11.6 7.5 13.5485 13.5485 10.9515 10.9515 7 8 8 8]*1e-3;
Dbo=[37 37 32 32 20 20 20 20 32 23 23 23 23 23 38 38 31.5 31.5 25 25 31.5 35 36 36 36 30 30 30 30 30 30 30 30 30 30 37 31.5 31.5 31.5 31.5 31.5 25 25 38 38 ...
    38 23 23 23 32 20 20 20 20 32 32 37 37]*1e-3;
Dbi = zeros(1,length(Lb));
%% Disk Data of Finite element
Disk_Node_Number=[6 8 24 52 54];
Ld =[21.903 27.097 10 27.097 21.903]*1e-3;
Ddo=[90 90 65 90 90]*1e-3;
Ddi=[20 20 36 20 20]*1e-3;

Speed = 0000;
Omega = Speed*2*pi/60;
qx = 0;           %%-------------------------------- 
qy = 0;           %%-------------------------------- 
qz = 0;           %%-------------------------------- 
my = 0;           %%-------------------------------- 
mz = 0;           %%-------------------------------- 

L  = Lb; 
Do = Dbo;
Di = Dbi;
n  = length(L);         % 梁单元数
Nof = 5*(n+1);
CS = zeros(Nof);        % 假设结构阻尼为零
% Parameters for Disk 
a = Ddi/2;
b = Ddo/2;
ed =[0 0 0 0 0]*1e-3;  % 偏心
phid = [0 0 0 0 0]*1e-3;
Nelement_of_Disk = Disk_Node_Number;

%% Bearing node number
% Bearing_Node_Number = [4 5 6 7 17 18 19 20 21 22];
global Bearing_Node_Number  iter
global  KBt KBTi
Bearing_number = [18 45];
Bearing_number = [20 43];
Bearing_Node_Number = Bearing_number;
BF = 1;%按前轴承计算
iter = zeros(1,6);
feps = 1e-7;maxit = 200;
% 前轴承125N；后轴承260N；
preload = [200;0e2;0e2;0e2;0e2];[predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF);KB1 = DFiv1; 
%% 
t = 0;
x0 = zeros(Nof,1);
[MD,GD,FD] = Finite_of_Disk(a,b,Ld,ed,phid,Nelement_of_Disk,Nof);
P=0;
[MB,MC,KB,KBP,GB,FB] = Finite_of_Beam2(L,Do,Di,P,x0);
KBT = zeros(Nof);
KB10 = zeros(5);
S0 = 1;
S1 = 1;
S2 = 1;
KB10 = KB1;KB10(1)=KB1(1)*S0*1e3;
KB10(2,5)=KB1(2,5)*S1*1e0;KB10(5,2)=KB10(2,5); KB10(3,4)=KB1(3,4)*S1*1e0;KB10(4,3)=KB10(3,4);
KB10(4:5,4:5)=KB1(4:5,4:5)*S2*1e0;
KB10(4:5,:)=0;KB10(:,4:5)=0;  %% 与ANSYS保持一致性 ，若不保迟则注释掉
KBT = BearingStiffnessAssemble5(KBT,KB10,Bearing_Node_Number(1));
KBT = BearingStiffnessAssemble5(KBT,KB10,Bearing_Node_Number(2));

K = KB + KBP + KBT - Omega^2 * MC;
M = MB + MD; 
%% 求振型
[Ph,V] = eig(K,M);
[V,ki] = sort(diag(V));
V = sqrt(V);
Ph = Ph(:,ki);
VV = diag(sqrt(V));
Mi = Ph.'*M*Ph;
ksi = 1.5E-4 ;     % 1E-4---6E-4结构阻尼
CS = 2*ksi*VV*Mi ; %  系统结构阻尼矩阵
C = CS - GB*Omega - GD*Omega;
freq=V/2/pi;
vpa(freq(1:30),5)      % 输出前30阶固有频率