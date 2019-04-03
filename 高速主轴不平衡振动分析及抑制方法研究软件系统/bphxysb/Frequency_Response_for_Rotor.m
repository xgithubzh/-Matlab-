%% Response_for_Rotor
clear;clc;close all
%% all
ksi = 2E-4 ;    %   1E-4---6E-4结构阻尼比
% 配重
N_L = 16;   N_S = 10; m_bolt = [0.2,2.0];
%%
Case = 1;
switch Case
    case 1  % 方案1  第1、4为钢，2、3为铝，尺寸见图纸，不平衡量位于1、2、3、4盘
        % 实验测数据 n1 = 2580r/min 
        Speed = 2580 % 1阶临界 （实验）
        Speed = 0         
        Speed = 1000        
        Speed = 1500         
        stitle = '方案1，不平衡量位于1、2、 3、 4盘' 
        XB = [60 490];Xd = [150 230 320 400];XT = [120 430];Disk_Type = {'LS','SA','SA','LS'};
        % 不平衡分部1
        phid = [30 60 120 270]*pi/180;   % 不平衡相位 
        med =  [0.5 1.5 0.7 1.2]/1000;     % 不平衡质量g/1000
%         % 不平衡分部2
%         phid = [0 30 120 290]*pi/180;   % 不平衡相位 
%         med =  [0.6 1 1.4 2]/1000;     % 不平衡质量g/1000         case 2  % 方案2  第1、3为铝，第2为钢，第4为铝，尺寸见图纸，不平衡量位于2、4盘
    case 2  % 方案2  第1、3为铝，第2为钢，第4为铝，尺寸见图纸，不平衡量位于2、4盘 (2500---2600之间）
        Speed = 2600 % 1阶临界
        Speed = 0
        Speed = 1000
        Speed = 2000       
        stitle = '方案2，不平衡量位于2、4盘'
        XB = [60 420];Xd = [130 240 350 490];XT = [150 330];Disk_Type = {'LA','LS','SA','LA'};
        % 不平衡分布1
        phid = [0 60 0 180]*pi/180;   % 不平衡相位 
        med =  [0 2 0 2]/1000;     % 不平衡质量g/1000
        % 不平衡分布2
        phid = [0 0 0 180]*pi/180;   % 不平衡相位 
        med =  [0 2 0 2]/1000;     % 不平衡质量g/1000
    case 3  % 方案3 在第二个图纸中，两轴轴承之间等间距放5个小铝盘，不平衡量位于1、2、3、4、5盘,传感器测点位于1、2正中间，4、5正中间
        Speed = 4180  % 1阶临界
        Speed = 000
        Speed = 2000
        Speed = 4000
        Speed = 3500 

        stitle = '方案3，不平衡量位于1、2、3、4、5盘'   
        XB = [60 420];DD = (XB(2)-XB(1))/6;Xd = [XB(1)+ DD XB(1)+ 2*DD XB(1)+ 3*DD XB(1)+ 4*DD XB(1)+ 5*DD]; XT = [Xd(1)+Xd(2) Xd(4)+Xd(5)]/2;Disk_Type = {'SA','SA','SA','SA','SA'};
        % 不平衡分部1
        phid = [0 60 90 150 300]*pi/180;             % 不平衡相位   
        med  = [2 2 2 2 2]/1000;                     % 不平衡质量g/1000
        % 不平衡分部2
        phid = [10 40 90 150 320]*pi/180;             % 不平衡相位 
        med  = [2 1 1 0.4 1.2]/1000;               % 不平衡质量g/1000        
end
figure();  % 不平衡量分布图
polar(phid(1),2e-3);hold on;
for i = 1:length(phid) 
    if med(i)~=0
        polar(phid(i),med(i),'ro');text(1.25*med(i)*cos(phid(i)+0.1),1.25*med(i)*sin(phid(i)+0.1),{i;med(i)});hold on
    end
end
hold off;title(stitle);
%%
XKeyPoint = sort([0 XB Xd XT 550]);
XKd = (XKeyPoint(2:end)-XKeyPoint(1:end-1));
dxmin = min(XKd)/5;
Lbx = [];
for i = 1:length(XKeyPoint)-1
    Lbtemp = linspace(XKeyPoint(i),XKeyPoint(i+1),XKd(i)/dxmin);
    Lbtemp(1)=[];
    Lbx = [Lbx Lbtemp];
end
Lbx = [0 Lbx];
for i = 1:length(Xd)
    Disk_Point(i) = fix(find(Xd(i) == Lbx)) + 1;
end
for i = 1:length(XB)
    Bearing_Point(i) = fix(find(XB(i) == Lbx)) + 1;
end
for i = 1:length(XT)
    Test_Point(i) = fix(find(XT(i) == Lbx)) + 1;
end
Lb = (Lbx(2:end)-Lbx(1:end-1))/1000;
Dbo = 10*ones(size(Lb))/1000;
Dbi = 0*ones(size(Lb))/1000;
% 分布载荷
global qx qy qz my mz  
qx = 0; qy = 0;qz = 0; my = 0; mz = 0; 
Nb  = length(Lb);        % 梁单元数
Nof = 5*(Nb+1);
x0 = 0e-3*ones(Nof,1);  % 节点位移
P=0;                    % 轴向预载
[MB,MC,KB,KBP,GB,FB] = Finite_of_Beam2(Lb,Dbo,Dbi,P,x0);
global  iter 
iter = zeros(1,6);feps = 1e-7;maxit = 200; % N
preload = [200;0e2;0e2;0e2;0e2];
[predisplacement,Fiv1,KB1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,1);
S0 = 1e5; % 11
S1 = 1e0; % 22、33
S2 = 1e0; % 44、55
S3 = 1e0; % 25、52
S4 = 1e0; % 43、34
KB10 = KB1;
KB10(1)=KB1(1)*S0;
KB10(2,2) = S1 * KB1(2,2);KB10(3,3) = KB10(2,2);
KB10(4,4) = S2 * KB1(4,4); KB10(5,5) = KB10(4,4); 
KB10(2,5) = S3*KB1(2,5);KB10(2,5) = KB10(5,2);
KB10(3,4) = S4*KB1(3,4);KB10(4,3) = KB10(3,4);
KBT = zeros(Nof);
KBT = BearingStiffnessAssemble5(KBT,0.2*KB10,Bearing_Point(1));
KBT = BearingStiffnessAssemble5(KBT,0.2*KB10,Bearing_Point(2));

%% fw = Speed/60;
Omega = Speed*2*pi/60;
nt =300;
dt = 1/Speed*60/20;
time = (0:nt-1)'*dt;
[MD,GD,FD] = Disk_for_rotor(Disk_Point,Disk_Type,Nof,time,nt,Omega,med,phid);
K = KB + KBP + KBT - Omega^2 * MC; 
M = MB + MD;
G = GB + GD;
[Ph,V] = eig(K,M);
[V,ki] = sort(diag(V));
Ph = Ph(:,ki);
vpa(sqrt(V(1:40))/2/pi,6)
%
VV = diag(sqrt(V));
Mi = Ph.'*M*Ph;mi = diag(Mi);
CS = 2*ksi*VV*Mi ; %  系统结构阻尼矩阵
%% 求频响
C = CS - GB*Omega - GD*Omega;
switch Case 
    case 1
    f = 30:sqrt(3):600;
    Excited_Point = [Disk_Point 55];
    Weight = [1 1 1 1 0]';  % 权重 可调
    case 2
    f = 30:sqrt(3):650;
    Excited_Point = [Disk_Point 55];
    Weight = [1 1 1 1 0]';    
    case 3
    f = 50:sqrt(3):850;
    Excited_Point = Disk_Point;
    Weight = [1 1 1 1 1]';    
end
C = 0;
C = diag(diag(CS)) - GB*Omega - GD*Omega;
C =  - GB*Omega - GD*Omega;
w0 = 2*pi*f;
clear X_HY X_HZ      H11 H12  H13 H14 H15 H21 H22 H23 H24 H25 H31 H32 H33 H34 H35 H41 H42 H43 H44 H45 H51 H52 H53 H54 H55 

ij = 0;
for w = w0
    ij = ij + 1;
    
    C = 0;                      % 不考虑阻尼及回转效应
    H = inv(K+1i*w*C-M*w^2);
    X_HY(:,ij) = H(5*(Test_Point-1)+2,5*(Excited_Point-1)+2)*Weight;
    X_HZ(:,ij) = H(5*(Test_Point-1)+3,5*(Excited_Point-1)+3)*Weight;
    
    X_HYyz(:,ij) = H(5*(Test_Point-1)+2,[5*(Excited_Point-1)+2 5*(Excited_Point-1)+3])*[Weight;Weight];
    X_HZyz(:,ij) = H(5*(Test_Point-1)+3,[5*(Excited_Point-1)+2 5*(Excited_Point-1)+3])*[Weight;Weight];
    
    
    C = - GB*Omega - GD*Omega;  % 不考虑阻尼、考虑回转效应
    H = inv(K+1i*w*C-M*w^2);
    X_HY_G(:,ij) = H(5*(Test_Point-1)+2,5*(Excited_Point-1)+2)*Weight;
    X_HZ_G(:,ij) = H(5*(Test_Point-1)+3,5*(Excited_Point-1)+3)*Weight;
    
    C = diag(diag(CS))*2.5e-3 - GB*Omega - GD*Omega; % 考虑阻尼及回转效应
    H = inv(K+1i*w*C-M*w^2);
    X_HY_CsG(:,ij) = H(5*(Test_Point-1)+2,5*(Excited_Point-1)+2)*Weight;
    X_HZ_CsG(:,ij) = H(5*(Test_Point-1)+3,5*(Excited_Point-1)+3)*Weight;    
end
% X_HR = (X_HY.^2 + X_HZ.^2).^2
figure()                      % 不考虑阻尼及回转效应
subplot(2,1,1) ;  
plot(f,X_HY(1,:),'b-',f,X_HY(2,:),'r--');xlabel('频率 / Hz');ylabel('Y向响应/m'),h = legend('测点1','测点2',1);set(h,'box','off');
title('不考虑阻尼及回转效应');
subplot(2,1,2)
plot(f,X_HZ(1,:),'b-',f,X_HZ(2,:),'r--');xlabel('频率 / Hz');ylabel('Z向响应/m)');h = legend('测点1','测点2',1);set(h,'box','off');

figure()                    % 不考虑阻尼、考虑回转效应
subplot(2,1,1);  
plot(f,X_HY_G(1,:),'b-',f,X_HY_G(2,:),'r--');xlabel('频率 / Hz');ylabel('Y向实频响应/m'),h = legend('测点1','测点2',1);set(h,'box','off');
title('不考虑阻尼，考虑回转效应');
subplot(2,1,2)
plot(f,X_HZ_G(1,:),'b-',f,X_HZ_G(2,:),'r--');xlabel('频率 / Hz');ylabel('Z向实频响应/m');h = legend('测点1','测点2',1);set(h,'box','off');

figure()                    % 考虑阻尼及回转效应
subplot(2,1,1);  
plot(f,X_HY_CsG(1,:),'b-',f,X_HY_CsG(2,:),'r--');xlabel('频率 / Hz');ylabel('Y向实频响应/m'),h = legend('测点1','测点2',1);set(h,'box','off');
title('考虑阻尼及回转效应');
subplot(2,1,2)
plot(f,X_HZ_CsG(1,:),'b-',f,X_HZ_CsG(2,:),'r--');xlabel('频率 / Hz');ylabel('Z向实频响应/m');h = legend('测点1','测点2',1);set(h,'box','off');

% figure()                      % 不考虑阻尼及回转效应考虑YZ耦合
% subplot(2,1,1) ;  
% plot(f,X_HYyz(1,:),'b-',f,X_HYyz(2,:),'r--');xlabel('频率 / Hz');ylabel('Y向响应/m'),h = legend('测点1','测点2',1);set(h,'box','off');
% title('不考虑阻尼及回转效应考虑YZ耦合');
% subplot(2,1,2)
% plot(f,X_HZyz(1,:),'b-',f,X_HZyz(2,:),'r--');xlabel('频率 / Hz');ylabel('Z向响应/m)');h = legend('测点1','测点2',1);set(h,'box','off');

% figure()                    % 考虑阻尼及回转效应的虚频
% subplot(2,1,1);  
% plot(f,imag(X_HY_CsG(1,:)),'b-',f,imag(X_HY_CsG(2,:)),'r--');xlabel('频率 / Hz');ylabel('Y向响应'),h = legend('测点1','测点2',1);set(h,'box','off');
% title('考虑阻尼及回转效应');
% subplot(2,1,2)
% plot(f,angle(X_HZ_CsG(1,:)),'b-',f,angle(X_HZ_CsG(2,:)),'r--');xlabel('频率 / Hz');ylabel('Z向响应');h = legend('测点1','测点2',1);set(h,'box','off');

