%% 不平衡识别及抑制
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
        SpeRe = 2580 ;% 1阶临界 （实验）
        SpeRe = 0     ;    
        SpeRe = 1000  ;     
        SpeRe = 2000  ;     
        SpeRe = 1500  ;
        stitle = '方案1，不平衡量位于1、2、 3、 4盘' 
        XB = [60 490];Xd = [150 230 320 400];XT = [120 430];Disk_Type = {'LS','SA','SA','LS'};
        Re = [30 20 20 30]/1000;       % 配重盘半径  
        % 不平衡分部1
        phid = [30 60 115 255]*pi/180;   % 不平衡相位 
        mRe =  [0.5 1.5 0.7 1.2]/1000;     % 不平衡质量g/1000        
%         phid = [0 60 0 150]*pi/180;   % 不平衡相位 
%         mRe =  [10 10 10 10]/1000;     % 不平衡质量g/1000
%         % 不平衡分部2
%         phid = [0 30 120 290]*pi/180;   % 不平衡相位 
%         mRe =  [0.6 1 1.4 2]/1000;     % 不平衡质量g/1000         case 2  % 方案2  第1、3为铝，第2为钢，第4为铝，尺寸见图纸，不平衡量位于2、4盘
    case 2  % 方案2  第1、3为铝，第2为钢，第4为铝，尺寸见图纸，不平衡量位于2、4盘 (2500---2600之间）
        SpeRe = 2600; % 1阶临界
        SpeRe = 0;
        SpeRe = 1000;
        SpeRe = 2000;      
        stitle = '方案2，不平衡量位于2、4盘'
        XB = [60 420];Xd = [130 240 350 490];XT = [150 330];Disk_Type = {'LA','LS','SA','LA'};
        Re = [30 30 20 30]/1000;         
        % 不平衡分布1
        phid = [0 60 0 180]*pi/180;   % 不平衡相位 
        mRe =  [0 2 0 2]/1000;     % 不平衡质量g/1000
        % 不平衡分布2
%         phid = [0 0 0 180]*pi/180;   % 不平衡相位 
%         mRe =  [0 2 0 2]/1000;     % 不平衡质量g/1000
    case 3  % 方案3 在第二个图纸中，两轴轴承之间等间距放5个小铝盘，不平衡量位于1、2、3、4、5盘,传感器测点位于1、2正中间，4、5正中间
        SpeRe = 4180;  % 1阶临界
        SpeRe = 000;
        SpeRe = 2000;
        SpeRe = 4000;
        SpeRe = 3500; 
        stitle = '方案3，不平衡量位于1、2、3、4、5盘'   
        XB = [60 420];DD = (XB(2)-XB(1))/6;Xd = [XB(1)+ DD XB(1)+ 2*DD XB(1)+ 3*DD XB(1)+ 4*DD XB(1)+ 5*DD]; XT = [Xd(1)+Xd(2) Xd(4)+Xd(5)]/2;Disk_Type = {'SA','SA','SA','SA','SA'};
        Re = [20 20 20 20 20]/1000;         
        % 不平衡分部1
        phid = [0 60 90 150 300]*pi/180;             % 不平衡相位   
        mRe  = [2 2 2 2 2]/1000;                     % 不平衡质量g/1000
        % 不平衡分部2
%         phid = [10 40 90 150 320]*pi/180;             % 不平衡相位 
%         mRe  = [2 1 1 0.4 1.2]/1000;               % 不平衡质量g/1000        
end
% figure();  % 不平衡量分布图  Re一定，表示位置与质量关系
% polar(phid(1),2e-3);hold on;
% for i = 1:length(phid) 
%     if mRe(i)~=0
%         polar(phid(i),mRe(i),'-mo','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',12);
%         text(1.25*mRe(i)*cos(phid(i)+0.1),1.25*mRe(i)*sin(phid(i)+0.1),{i;mRe(i)});hold on
%     end
% end
% hold off;title(stitle);
% plot(t,sin(2*t),'-mo','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',12)
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
[prReisplacement,Fiv1,KB1,iteri,flagi] = Bearing_of_Stiffness(preload,SpeRe,feps,maxit,1);
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
KBT = BearingStiffnessAssemble5(KBT,0.04*KB10,Bearing_Point(1));
KBT = BearingStiffnessAssemble5(KBT,0.04*KB10,Bearing_Point(2));

%% fw = SpeRe/60;
Omega = SpeRe*2*pi/60;
nt =300;
dt = 1/SpeRe*60/20;
time = (0:nt-1)'*dt;
[MD,GD,~] = Disk_for_rotor(Disk_Point,Disk_Type,Nof,time,nt,Omega,mRe,phid);
K = KB + KBP + KBT - Omega^2 * MC; 
M = MB + MD;
G = GB + GD;
[Ph,V] = eig(K,M);
[V,ki] = sort(diag(V));
Ph = Ph(:,ki);

VV = diag(sqrt(V));
Mi = Ph.'*M*Ph;mi = diag(Mi);
CS = 2*ksi*VV*Mi ; %  系统结构阻尼矩阵
C = CS - GB*Omega - GD*Omega;
freq=sqrt(V)/2/pi;
Freq30 = vpa(freq(1:30),4)  % 输出前30阶固有频率

%% 施加不平衡量
imbalance = Disk_Point;  % 只考虑圆盘位置的不平衡量 
phi = phid;
m = mRe;
r = Re;
% 人为施加不平衡，用来比较  U为全局不平衡向量
U_S = zeros(Nof,1) ;
U_S(5*(imbalance-1)+2)=m.*r.*cos(phi);      
U_S(5*(imbalance-1)+3)=m.*r.*sin(phi);  

%% 测点A、B,不同转速，提取B矩阵
Atest = Test_Point(1); Btest = Test_Point(2);
N_tPoint = length(Test_Point);  
N_imPoint = length(imbalance); % N_imbalance 个不平衡位置

N_U = N_imPoint;               % N_U个不平衡量
N_Omega = N_U/N_tPoint;        % 需要N_Omega个转速
iOmega = linspace(1/5*freq(1),3/5*freq(1),N_Omega)*60;  
U_YZ(1:2:2*N_imPoint-1) =  m.*r.*cos(phi);   %  % 分解到Y、Z向  即*2   U_YZ为局部不平衡量向量，存放提取后的不平衡量, 局部U_YZ 
U_YZ(2:2:2*N_imPoint) =  m.*r.*sin(phi);

i = 0;
for Omega = iOmega
    i = i+1;
    C = CS - GB*Omega - GD*Omega;
    C = - GB*Omega - GD*Omega;   % 忽略阻尼 
% C =0;   % 忽略 陀螺效应 
    HOmega = Omega^2*inv(-M*Omega^2+1i*C*Omega+K);  
    AAYOmega(4*(i-1)+1:4*(i-1)+2,:) = HOmega([5*(Atest-1)+2,5*(Btest-1)+2],5*(imbalance-1)+2);     % 提取Y向传递函数 AAYOmega
    AAY(4*(i-1)+1:4*(i-1)+2,1) =  AAYOmega(4*(i-1)+1:4*(i-1)+2,:)*U_S(5*(imbalance-1)+2);   %在忽略阻尼的情况下效果很好  AAY为Y向振幅
    AAZOmega(4*(i-1)+1:4*(i-1)+2,:) = HOmega([5*(Atest-1)+3,5*(Btest-1)+3],5*(imbalance-1)+3);     % 提取Z向传递函数 AAZOmega
    AAZ(4*(i-1)+1:4*(i-1)+2,1) =  AAZOmega(4*(i-1)+1:4*(i-1)+2,:)*U_S(5*(imbalance-1)+3);    %在忽略阻尼的情况下效果很好  AAZ为Z向振幅
end    
%     [UU,SS,VV] = svd(HOmega,0);  % 奇异值分解
%     Ra=rank(HOmega);    %  秩          %  截断参数k取HHH的秩
%     for j=1:Ra
%         A_s(:,j) = UU(:,j)'*U_S/SS(j,j)*VV(:,j); % 截断奇异值分解法
%         A_i(:,j) = UU(:,j)'*U_I/SS(j,j)*VV(:,j); % 截断奇异值分解法
%     end
U_YI = AAYOmega\AAY   % 反求Y向不平衡量 在忽略阻尼的情况下效果很好
U_ZI = AAZOmega\AAZ   % 反求Z向不平衡量 在忽略阻尼的情况下效果很好

U_Y = U_YZ(1:2:end)' % 原始不平衡Y向
U_Z = U_YZ(2:2:end)' % 原始不平衡Z向

U_RI = (U_YI) + 1i*(U_ZI)  % 识别不平衡量的复数形式
U_R  = (U_Y) + 1i*(U_Z)    % 原始不平衡量的复数矢量形式

U_I = zeros(Nof,1);   % 放入总的识别的不平衡量U_I中
U_I(5*(imbalance-1)+2) = U_YI;
U_I(5*(imbalance-1)+3) = U_ZI;
%% 绘图
figure();% 识别不平衡量与原始不平衡量的比较
subplot(2,1,1) % 幅值 

plot(imbalance,abs(U_R)*1e6,'bs',imbalance,abs(U_RI)*1e6,'ro');
xlabel('节点号');ylabel('幅值 / g.mm'); title('识别不平衡量与原始不平衡量的比较')
h = legend('原始不平衡量','识别不平衡量',1);% set(h,'box','off');
subplot(2,1,2) % 相位
degR = angle(U_R)*180/pi;degR(degR<0)=degR(degR<0)+360;degI = angle(U_RI)*180/pi;degI(degI<0)=degI(degI<0)+360;
plot(imbalance,degR,'bs',imbalance,degI,'ro');xlabel('节点号');ylabel('相位 / \circ')
h = legend('原始不平衡量','识别不平衡量',1);% set(h,'box','off');