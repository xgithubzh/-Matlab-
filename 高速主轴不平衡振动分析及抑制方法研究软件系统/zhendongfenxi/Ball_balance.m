% 主函数：[f,J,outpara] = Ball_balance(x0,delta,k,BF,Speed) ：钢球几何关系及力平衡关系函数；
% 输入： x0 = {Uk Vk deltaok deltaik}：待求解变量；delta ：内外圈的相对位移向量；k：第k个滚动体；
%          BF = 1：选择前轴承HYHK61914；Speed：转速（r/min）；
% 输出：f ：4X1函数值； J：4X4雅克比矩阵；outpara：输出参数。
function [f,J,outpara] = Ball_balance(x0,delta,k,BF,Speed) 
if BF == 1
    Di=70e-3;                                           % inner d
    Do=100e-3;                                          % outer d
    D=6.35e-3;                                          % diameter of the bearing ball
    N = 32;
    theta=25*pi/180;                                    % the initial contact angle of the bearing 914 
%       N =  14;
%       Di = 25e-3;
%       Do = 52e-3;
%       D = 7e-3;
%       theta = 25*pi/180;
 else
    Di=55e-3;                                           % inner d
    Do=80e-3;                                           % outer d
    D=5.56e-3;                                          % diameter of the bearing ball
    N = 30;
    theta=-25*pi/180;                                    % the initial contact angle of the bearing 911 
%       N =  14;
%       Di = 25e-3;
%       Do = 52e-3;
%       D = 7e-3;
%       theta = -25*pi/180;
end

% fi = 0.515; 
% fo = 0.514;
% ri = fi*D;
% ro = fo*D;
ri=3.524e-3;                                        % the radii of the inner ring groove
ro=3.588e-3;                                        % the radii of the outer ring groove
Dm=1/2*(Di+Do);                                     % pitch diameter = inner diameter +  diameter :
Ea=3.15e11;                                         % Young's modulus of the bearing ball 
ua=0.26;                                            % poission ratio of the bearing ball
Eb=2.08e11;                                         % Young's modulus of inner ring or outer ring 
ub=0.30;                                            % poission ratio of inner ring or outer ring
p0=7800;                                            % density of the ball                                                                                  

b = -1;
deltax = delta(1);deltay = delta(2);deltaz = delta(3);gamay = delta(4);gamaz = delta(5);
lamda=D/Dm;  fo=ro/D; fi=ri/D;  BD=(fo+fi-1)*D;  
ric=Dm/2+(fi-0.5)*D*cos(theta); 
Ep=2/((1-ua^2)/Ea+(1-ub^2)/Eb); 
Uik=BD*sin(theta)+deltax-gamaz*ric*cos(b*pi/N+2*pi*k/N)+gamay*ric*sin(b*pi/N+2*pi*k/N);
Vik=BD*cos(theta)+deltay*cos(b*pi/N+2*pi*k/N)+deltaz*sin(b*pi/N+2*pi*k/N);
x = x0; Uk=x(1);Vk=x(2);deltaok=x(3);deltaik=x(4);
% 中间（辅助）变量,常量 
thetaik = asin((Uik-Uk)/((fi-0.5)*D+deltaik));
thetaok = asin(Uk/((fo-0.5)*D+deltaok));
gamai=D*cos(thetaik)/Dm; gamao=D*cos(thetaok)/Dm;
% 求 Kik 和 Qik
Rx=D/2*(1-gamai);Ry=D*fi/(2*fi-1);Rxy=Rx*Ry/(Rx+Ry);
Eik=1.0003+0.5968*(Rx/Ry);FF=1.5277+0.6023*log(Ry/Rx);kapa=1.0339*(Ry/Rx)^0.6360;
Kik=pi*kapa*Ep/(3*FF)*sqrt(2*Eik*Rxy/FF);  Qik=Kik*deltaik^1.5;aik = (6*kapa^2*Eik*Rxy*Qik)^(1/3);
% 求 Kok 和 Qok
Rx=D*fo/(2*fo-1);Ry=D/2*(1+gamao);Rxy=Rx*Ry/(Rx+Ry);
Eok=1.0003+0.5968*(Rx/Ry);FF=1.5277+0.6023*log(Ry/Rx);kapa=1.0339*(Ry/Rx)^0.6360;
Kok=pi*kapa*Ep/(3*FF)*sqrt(2*Eok*Rxy/FF);  Qok=Kok*deltaok^1.5;aok = (6*kapa^2*Eok*Rxy*Qok)^(1/3);

% Ocontrl = Qok*aok*Eok*cos(thetaik-thetaok)> Qik*aik*Eik;
Icontrl = Qik*aik*Eik*cos(thetaik-thetaok)>Qok*aok*Eok;
%% 求 Fck 和 Mgk   ------ 基于外圈控制求解
% if Ocontrl
%     OmegaE_Omegak = (1-lamda*cos(thetaik))/(1+cos(thetaik-thetaok));
%     alphak = atan(sin(thetaok)/(cos(thetaok)+lamda)); 
%     lamdaok = 2;lamdaik = 0;
% else
%     OmegaE_Omegak = (cos(thetaik - thetaok) - lamda * cos(thetaok))/(1 + cos(thetaik - thetaok));
%     alphak = atan(sin(thetaik)/(cos(thetaik) - lamda));
%     lamdaok = 1;lamdaik = 1;
% end

%% -------- 基于内圈控制求解
if Icontrl
    OmegaE_Omegak = (cos(thetaik - thetaok) - lamda * cos(thetaok))/(1 + cos(thetaik - thetaok));
    alphak = atan(sin(thetaik)/(cos(thetaik) - lamda));
    lamdaok = 1;lamdaik = 1;
else
    OmegaE_Omegak = (1-lamda*cos(thetaik))/(1+cos(thetaik-thetaok));
    alphak = atan(sin(thetaok)/(cos(thetaok)+lamda)); 
    lamdaok = 2;lamdaik = 0;
end

OmegaB_Omegak = -1/(lamda*cos(alphak)*((cos(thetaok)+tan(alphak)*sin(thetaok))/(1+lamda*cos(thetaok))+(cos(thetaik)+tan(alphak)*sin(thetaik))/(1-lamda*cos(thetaik))));
Omega = 2*pi* Speed/60;  
Fck = 1/12*pi*p0*D^3*Dm*Omega^2*OmegaE_Omegak^2;   Mgk = 1/60*pi*p0*D^5*Omega^2*OmegaB_Omegak*OmegaE_Omegak*sin(alphak); 
lcondk = Uik^2+(Vik-(fo-0.5)*D-Kok^(-2/3)*Fck^(2/3))^2<=((fi-0.5)*D)^2;
% 几何方程 
eq1 = (Uik-Uk)^2+(Vik-Vk)^2-((fi-0.5)*D+deltaik)^2;
eq2 = Uk^2+Vk^2-((fo-0.5)*D+deltaok)^2;
% 滚动体平衡方程
eq3 = Kok*deltaok^1.5*Vk/((fo-0.5)*D+deltaok)-lamdaok*Mgk/D*Uk/((fo-0.5)*D+deltaok)-Kik*deltaik^1.5*(Vik-Vk)/((fi-0.5)*D+deltaik)+lamdaik*Mgk/D*(Uik-Uk)/((fi-0.5)*D+deltaik)-Fck;
eq4 = Kok*deltaok^1.5*Uk/((fo-0.5)*D+deltaok)+lamdaok*Mgk/D*Vk/((fo-0.5)*D+deltaok)-Kik*deltaik^1.5*(Uik-Uk)/((fi-0.5)*D+deltaik)-lamdaik*Mgk/D*(Vik-Vk)/((fi-0.5)*D+deltaik);
if lcondk   % 滚动体脱离内圈
    Mgk = 0;deltaok = (Fck/Kok)^(2/3); 
    Uk = 0; Vk = (fo-0.5)*D+deltaok;  deltaik = 0; 
    eq1=0;  eq2=0;eq3 = 0;eq4 = 0;
end
% 雅克比矩阵J
a11=-2*(Uik-Uk);a12=-2*(Vik-Vk);a13=0;a14=-2*((fi-0.5)*D+deltaik);
a21=2*Uk;a22=2*Vk;a23=-2*((fo-0.5)*D+deltaok);a24=0;
a31=-Mgk/D*(lamdaok/((fo-0.5)*D+deltaok)+lamdaik/((fi-0.5)*D+deltaik));a32=Kok*deltaok^1.5/((fo-0.5)*D+deltaok)+Kik*deltaik^1.5/((fi-0.5)*D+deltaik);
a33=3/2*Kok*deltaok^0.5*Vk/((fo-0.5)*D+deltaok)-Kok*deltaok^1.5*Vk/((fo-0.5)*D+deltaok)^2+lamdaok*Mgk/D*Uk/((fo-0.5)*D+deltaok)^2;
a34=-(3/2*Kik*deltaik^0.5*(Vik-Vk)/((fi-0.5)*D+deltaik)-Kik*deltaik^1.5*(Vik-Vk)/((fi-0.5)*D+deltaik)^2+lamdaik*Mgk/D*(Uik-Uk)/((fi-0.5)*D+deltaik)^2);
a41=Kok*deltaok^1.5/((fo-0.5)*D+deltaok)+Kik*deltaik^1.5/((fi-0.5)*D+deltaik);a42=Mgk/D*(lamdaok/((fo-0.5)*D+deltaok)+lamdaik/((fi-0.5)*D+deltaik));
a43=3/2*Kok*deltaok^0.5*Uk/((fo-0.5)*D+deltaok)-Kok*deltaok^1.5*Uk/((fo-0.5)*D+deltaok)^2-lamdaok*Mgk/D*Vk/((fo-0.5)*D+deltaok)^2;
a44=-(3/2*Kik*deltaik^0.5*(Uik-Uk)/((fi-0.5)*D+deltaik)-Kik*deltaik^1.5*(Uik-Uk)/((fi-0.5)*D+deltaik)^2-lamdaik*Mgk/D*(Vik-Vk)/((fi-0.5)*D+deltaik)^2);
% 输出 J 和 f
% format long
J=[a11,a12,a13,a14;a21,a22,a23,a24;a31,a32,a33,a34;a41,a42,a43,a44];f=[eq1;eq2;eq3;eq4];
aijk = [a31,a32,a33,a34,a41,a42,a43,a44];
% outparasym = '14 + 8 parasyms -----  [Kok Kik Uk Vk Uik Vik deltaok deltaik lamdaoik lamdaik thetaok thetaik alphak phik aijk] -------';
outpara  = [Kok Kik Uk Vk Uik Vik deltaok deltaik lamdaok lamdaik thetaok thetaik alphak  Mgk Fck aijk]; 


