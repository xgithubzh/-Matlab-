% 被调用子函数：
% [Xval,Fval,Jval,iterations,flag] = Newton_Raphson_for_Multifunction(Fun,X0,xtol,spc,ftol,count,A,maxit,varargin)：多元函数改进的Newton-Raphson迭代算法；       
% [f,J,outpara] = Ball_balance(x0,delta,k,N,Speed)：滚动体几何关系和力平衡关系函数。
% 主函数：内圈（外圈）力平衡函数
% [Fi,DFi,Fo,DFo,predisplacemt] =% Stiffness_for_inner_ring(delta,preload,Speed,BF) 
% 输入参数：delta：内外圈相对位移；preload：预紧力向量； 
% 输出参数：Fi、DFi：内圈力平衡函数值和雅克比矩阵；Fo、DFo：外圈函数值和雅克比矩阵；predisplacemt：输出的内外圈相对位移
function [Fi,DFi,Fo,DFo,predisplacemt] = Stiffness_for_inner_ring(delta,preload,Speed,BF)
% load('E:\matlab GUI\gzkj\chuandishuju\chuandishuju.mat');
global Di1 Do1 D1 N1 theta1 
N=N1;
Di=Di1;
Do=Do1;
D=D1;
theta=theta1;
% if BF == 1;
%     N = 32;
%     Di=70e-3;                                           % inner d
%     Do=100e-3;                                          % outer d
%     D=6.35e-3;                                          % diameter of the bearing ball
%     theta=25*pi/180;                                    % the initial contact angle of the bearing 914 
% %       N =  14;
% %       Di = 25e-3;
% %       Do = 52e-3;
% %       D = 7e-3;
% %       theta = 25*pi/180;
% else
%     N = 30;
%     Di=55e-3;                                           % inner d
%     Do=80e-3;                                           % outer d
%     D =5.56e-3;                                         % diameter of the bearing ball
%     theta=-25*pi/180;                                   % the initial contact angle of the bearing 914 
% %       N =  14;
% %       Di = 25e-3;
% %       Do = 52e-3;
% %       D = 7e-3;
% %       theta = -25*pi/180;
% 
% end

% 
ri=3.524e-3;                                        % the radii of the inner ring groove
ro=3.588e-3;                                        % the radii of the outer ring groove  
Dm=1/2*(Di+Do);                                     % pitch diameter = inner diameter +  diameter :  
% fi = 0.515; fo = 0.514;
% ri = fi*D;  ro = fo*D;
fi = ri/D;fo = ro/D;
preload(1) = BF*preload(1);
%fo=ro/D;
ftol = [1e-20;1e-6];spc = [0 0 1 1];count =2;A = 0.5;maxit = [];
in = 10;jn = 10;kn = 1:N;
global iter test test2 % 全局变量iter记录次数，test、test1：

% iter = zeros(1,6);
for j =1:jn               % 二重线性搜索（for j for i）结合Newton_Raphson迭代
    for i =1:in
        k1 = zeros(1,N);
        d = [0.5*i 0.5*j];
        x0 = [(fo-0.5)*D*sin(theta)+0e6;(fo-0.5)*D*cos(theta)+0e-6;d(1)*1e-6;d(2)*1e-6];
        for k = 1:N
            [Xval,Fval,Jval,iterations,flag] =  Newton_Raphson_for_Multifunction(@Ball_balance,x0,spc,ftol,count,A,maxit,delta,k,BF,Speed);
            if iter(1) <= iterations,iter(1)= iterations;end
            X{k} = Xval;
            if Xval(4)<0 | Xval(3)<0 
                 k1(k) = k;                 
            else
                [f,J,outpara] = Ball_balance(X{k},delta,k,BF,Speed);  F{k} = f;                     
                 Ko(k) = outpara(1);Ki(k) = outpara(2); U(k) = outpara(3);V(k) = outpara(4);Ui(k) = outpara(5);Vi(k) = outpara(6);deltao(k) = outpara(7);
                 deltai(k) = outpara(8);lamdao(k) = outpara(9);lamdai(k) = outpara(10); thetao(k) = outpara(11);thetai(k) = outpara(12);alpha(k) = outpara(13);
                 Mg(k) = outpara(14);Fc(k) = outpara(15);a3j{k} = outpara(16:19);a4j{k} = outpara(20:23);
                 X{k}(1) = U(k);X{k}(2) = V(k);X{k}(3) = deltai(k);X{k}(4) = deltao(k); 
            end
        end
        for k = kn 
            x0 = X{k};
             if sum(k1)>0
                for k = k1(k1>0)
                    [Xval,Fval,Jval,iterations,flag] =  Newton_Raphson_for_Multifunction(@Ball_balance,x0,spc,ftol,count,A,maxit,delta,k,N,Speed);
                   if iter(2) <= iterations,iter(2) = iterations;end
                    X{k} = Xval;k1(k) = 0;
                    if Xval(4)<0 |Xval(3)<0 
                        k1(k) = k;
                    else
                        [f,J,outpara] = Ball_balance(X{k},delta,k,BF,Speed);  F{k} = f;                     
                         Ko(k) = outpara(1);Ki(k) = outpara(2); U(k) = outpara(3);V(k) = outpara(4);Ui(k) = outpara(5);Vi(k) = outpara(6);deltao(k) = outpara(7);
                         deltai(k) = outpara(8);lamdao(k) = outpara(9);lamdai(k) = outpara(10); thetao(k) = outpara(11);thetai(k) = outpara(12);alpha(k) = outpara(13);
                         Mg(k) = outpara(14);Fc(k) = outpara(15);a3j{k} = outpara(16:19);a4j{k} = outpara(20:23);
                         X{k}(1) = U(k);X{k}(2) = V(k);X{k}(3) = deltai(k);X{k}(4) = deltao(k); 
                    end
                end
             end
        end
        if sum(k1)==0
            break
        end
    end
    if sum(k1)==0
        break
    end
end
k1;
k2 = zeros(1,N);
for k = 1:N
    [Xval,Fval,Jval,iterations,flag] =  Newton_Raphson_for_Multifunction(@Ball_balance,real(X{k}),spc,ftol,count,A,maxit,delta,k,BF,Speed);
    if iter(3) <= iterations,iter(3) = iterations;end
    [Xval,Fval,Jval,iterations,flag] =  Newton_Raphson_for_Multifunction(@Ball_balance,real(Xval),spc,ftol,count,A,maxit,delta,k,BF,Speed);
    if iter(4) <= iterations,iter(4) = iterations;end
    X{k} = Xval;
    if imag(Xval)~=0
        k2(k) = k;
    else
        [f,J,outpara] = Ball_balance(X{k},delta,k,BF,Speed);
        F{k} = f;
        Ko(k) = outpara(1);Ki(k) = outpara(2); U(k) = outpara(3);V(k) = outpara(4);Ui(k) = outpara(5);Vi(k) = outpara(6);deltao(k) = outpara(7);
        deltai(k) = outpara(8);lamdao(k) = outpara(9);lamdai(k) = outpara(10); thetao(k) = outpara(11);thetai(k) = outpara(12);alpha(k) = outpara(13);
        Mg(k) = outpara(14);Fc(k) = outpara(15);a3j{k} = outpara(16:19);a4j{k} = outpara(20:23);
        X{k}(1) = U(k);X{k}(2) = V(k);X{k}(3) = deltai(k);X{k}(4) = deltao(k); 
    end
% outpara  = [Kok Kik Uk Vk Uik Vik deltaok deltaik lamdaok lamdaik thetaok thetaik alphak  Mgk Fc aijk];
end
for j =1:jn
    for i =1:in
        k1 = zeros(1,N);
        d = [0.5*i 0.5*j];
        x0 = [(fo-0.5)*D*sin(theta)+0e6;(fo-0.5)*D*cos(theta)+0e-6;d(1)*1e-6;d(2)*1e-6];
        if sum(k2)>0
            for k = k2(k2>0)
                [Xval,Fval,Jval,iterations,flag] =  Newton_Raphson_for_Multifunction(@Ball_balance,x0,spc,ftol,count,A,maxit,delta,k,BF,Speed);
                if iter(5) <= iterations,iter(5) = iterations;end
                [Xval,Fval,Jval,iterations,flag] =  Newton_Raphson_for_Multifunction(@Ball_balance,real(Xval),spc,ftol,count,A,maxit,delta,k,BF,Speed); 
                if iter(6) <= iterations,iter(6) = iterations;end
                X{k} = Xval;
                if imag(Xval) == 0
                     k2(k) = 0;                       
                     [f,J,outpara] = Ball_balance(X{k},delta,k,BF,Speed);  F{k} = f;                     
                     Ko(k) = outpara(1);Ki(k) = outpara(2); U(k) = outpara(3);V(k) = outpara(4);Ui(k) = outpara(5);Vi(k) = outpara(6);deltao(k) = outpara(7);
                     deltai(k) = outpara(8);lamdao(k) = outpara(9);lamdai(k) = outpara(10); thetao(k) = outpara(11);thetai(k) = outpara(12);alpha(k) = outpara(13);
                     Mg(k) = outpara(14);Fc(k) = outpara(15);a3j{k} = outpara(16:19);a4j{k} = outpara(20:23);
                     X{k}(1) = U(k);X{k}(2) = V(k);X{k}(3) = deltai(k);X{k}(4) = deltao(k); 
                 end
            end
        else            
            break;
        end

    end
    if sum(k2)==0
            break
    end
end

if sum(k2)>0 % 
     for k = k2(k2>0)
         x0 = [(fo-0.5)*D*sin(theta)+0e6;(fo-0.5)*D*cos(theta)+0e-6;0*1e-6;0*1e-6];
         [f,J,outpara] = Ball_balance(x0,delta,k,BF,Speed);  F{k} = f;                     
         Ko(k) = outpara(1);Ki(k) = outpara(2); U(k) = outpara(3);V(k) = outpara(4);Ui(k) = outpara(5);Vi(k) = outpara(6);deltao(k) = outpara(7);
         deltai(k) = outpara(8);lamdao(k) = outpara(9);lamdai(k) = outpara(10); thetao(k) = outpara(11);thetai(k) = outpara(12);alpha(k) = outpara(13);
         Mg(k) = outpara(14);Fc(k) = outpara(15);a3j{k} = outpara(16:19);a4j{k} = outpara(20:23);
         X{k}(1) = U(k);X{k}(2) = V(k);X{k}(3) = deltai(k);X{k}(4) = deltao(k); 
     end
end
b = -1;fo=ro/D; fi=ri/D; ric=Dm/2+(fi-0.5)*D*cos(theta); roc=Dm/2-(fo-0.5)*D*cos(theta);
for k = 1:N
        DUik = [1 0 0 ric*sin(b*pi/N+2*pi*k/N) -ric*cos(b*pi/N+2*pi*k/N)];
        DVik=[0 cos(b*pi/N+2*pi*k/N) sin(b*pi/N+2*pi*k/N) 0 0];
        b11=Ui(k)-U(k);b12=Vi(k)-V(k);b13=0;b14=(fi-0.5)*D+deltai(k);
        b21=U(k);b22=V(k);b23=-((fo-0.5)*D+deltao(k));b24=0;
        bij=[b11,b12,b13,b14;b21,b22,b23,b24;a3j{k};a4j{k}];   % a31,a32,a33,a34;a41,a42,a43,a44];
        cij=[(Ui(k)-U(k))*DUik+(Vi(k)-V(k))*DVik;zeros(1,5);(Ki(k)*deltai(k)^1.5*DVik-lamdai(k)*Mg(k)/D*DUik)/((fi-0.5)*D+deltai(k));(Ki(k)*deltai(k)^1.5*DUik+lamdai(k)*Mg(k)/D*DVik)/((fi-0.5)*D+deltai(k))];
        DD=bij\cij;   DUk=DD(1,:);DVk=DD(2,:);Ddeltaik=DD(4,:);% Ddeltaok=DD(3,:);
        % 不考虑Mgk对相对位移变量的偏导

        dFxi(k,:)=(3/2*Ki(k)*deltai(k)^0.5*Ddeltaik*(Ui(k)-U(k))*((fi-0.5)*D+deltai(k))+Ki(k)*deltai(k)^1.5*((DUik-DUk)*((fi-0.5)*D+deltai(k))-(Ui(k)-U(k))*Ddeltaik)+lamdai(k)*Mg(k)/D*((DVik-DVk)*((fi-0.5)*D+deltai(k))-(Vi(k)-V(k))*Ddeltaik))/((fi-0.5)*D+deltai(k))^2;
        dFyi(k,:)=(3/2*Ki(k)*deltai(k)^0.5*Ddeltaik*(Vi(k)-V(k))*((fi-0.5)*D+deltai(k))+Ki(k)*deltai(k)^1.5*((DVik-DVk)*((fi-0.5)*D+deltai(k))-(Vi(k)-V(k))*Ddeltaik)-lamdai(k)*Mg(k)/D*((DUik-DUk)*((fi-0.5)*D+deltai(k))-(Ui(k)-U(k))*Ddeltaik))/((fi-0.5)*D+deltai(k))^2*cos(b*pi/N+2*pi*k/N);
        dFzi(k,:)=(3/2*Ki(k)*deltai(k)^0.5*Ddeltaik*(Vi(k)-V(k))*((fi-0.5)*D+deltai(k))+Ki(k)*deltai(k)^1.5*((DVik-DVk)*((fi-0.5)*D+deltai(k))-(Vi(k)-V(k))*Ddeltaik)-lamdai(k)*Mg(k)/D*((DUik-DUk)*((fi-0.5)*D+deltai(k))-(Ui(k)-U(k))*Ddeltaik))/((fi-0.5)*D+deltai(k))^2*sin(b*pi/N+2*pi*k/N);
        dMyi(k,:)=ric*(3/2*Ki(k)*deltai(k)^0.5*Ddeltaik*(Ui(k)-U(k))*((fi-0.5)*D+deltai(k))+Ki(k)*deltai(k)^1.5*((DUik-DUk)*((fi-0.5)*D+deltai(k))-(Ui(k)-U(k))*Ddeltaik)+lamdai(k)*Mg(k)/D*((DVik-DVk)*((fi-0.5)*D+deltai(k))-(Vi(k)-V(k))*Ddeltaik))/((fi-0.5)*D+deltai(k))^2*sin(b*pi/N+2*pi*k/N);
        dMzi(k,:)=-ric*(3/2*Ki(k)*deltai(k)^0.5*Ddeltaik*(Ui(k)-U(k))*((fi-0.5)*D+deltai(k))+Ki(k)*deltai(k)^1.5*((DUik-DUk)*((fi-0.5)*D+deltai(k))-(Ui(k)-U(k))*Ddeltaik)+lamdai(k)*Mg(k)/D*((DVik-DVk)*((fi-0.5)*D+deltai(k))-(Vi(k)-V(k))*Ddeltaik))/((fi-0.5)*D+deltai(k))^2*cos(b*pi/N+2*pi*k/N);
       %% 外圈
        DUik=-[1 0 0 ric*sin(b*pi/N+2*pi*k/N) -ric*cos(b*pi/N+2*pi*k/N)];
        DVik=-[0 cos(b*pi/N+2*pi*k/N) sin(b*pi/N+2*pi*k/N) 0 0];

        b11=Ui(k)-U(k);b12=Vi(k)-V(k);b13=0;b14=(fi-0.5)*D+deltai(k);
        b21=U(k);b22=V(k);b23=-((fo-0.5)*D+deltao(k));b24=0;
        bij=[b11,b12,b13,b14;b21,b22,b23,b24;a3j{k};a4j{k}];
        cij=[(Ui(k)-U(k))*DUik+(Vi(k)-V(k))*DVik;zeros(1,5);(Ki(k)*deltai(k)^1.5*DVik-lamdai(k)*Mg(k)/D*DUik)/((fi-0.5)*D+deltai(k));(Ki(k)*deltai(k)^1.5*DUik+lamdai(k)*Mg(k)/D*DVik)/((fi-0.5)*D+deltai(k))];
        DD=bij\cij;  DUk=DD(1,:);DVk=DD(2,:);Ddeltaok=DD(3,:);% Ddeltaik=DD(4,:);

        dFxo(k,:)=-(3/2*Ko(k)*deltao(k)^0.5*Ddeltaok*U(k)*((fo-0.5)*D+deltao(k))+Ko(k)*deltao(k)^1.5*(DUk*((fo-0.5)*D+deltao(k))-U(k)*Ddeltaok)+lamdao(k)*Mg(k)/D*(DVk*((fo-0.5)*D+deltao(k))-V(k)*Ddeltaok))/((fo-0.5)*D+deltao(k))^2;
        dFyo(k,:)=-(3/2*Ko(k)*deltao(k)^0.5*Ddeltaok*V(k)*((fo-0.5)*D+deltao(k))+Ko(k)*deltao(k)^1.5*(DVk*((fo-0.5)*D+deltao(k))-V(k)*Ddeltaok)-lamdao(k)*Mg(k)/D*(DUk*((fo-0.5)*D+deltao(k))-U(k)*Ddeltaok))/((fo-0.5)*D+deltao(k))^2*cos(b*pi/N+2*pi*k/N);
        dFzo(k,:)=-(3/2*Ko(k)*deltao(k)^0.5*Ddeltaok*V(k)*((fo-0.5)*D+deltao(k))+Ko(k)*deltao(k)^1.5*(DVk*((fo-0.5)*D+deltao(k))-V(k)*Ddeltaok)-lamdao(k)*Mg(k)/D*(DUk*((fo-0.5)*D+deltao(k))-U(k)*Ddeltaok))/((fo-0.5)*D+deltao(k))^2*sin(b*pi/N+2*pi*k/N);
        dMyo(k,:)=-roc*(3/2*Ko(k)*deltao(k)^0.5*Ddeltaok*U(k)*((fo-0.5)*D+deltao(k))+Ko(k)*deltao(k)^1.5*(DUk*((fo-0.5)*D+deltao(k))-U(k)*Ddeltaok)+lamdao(k)*Mg(k)/D*(DVk*((fo-0.5)*D+deltao(k))-V(k)*Ddeltaok))/((fo-0.5)*D+deltao(k))^2*sin(b*pi/N+2*pi*k/N);
        dMzo(k,:)= roc*(3/2*Ko(k)*deltao(k)^0.5*Ddeltaok*U(k)*((fo-0.5)*D+deltao(k))+Ko(k)*deltao(k)^1.5*(DUk*((fo-0.5)*D+deltao(k))-U(k)*Ddeltaok)+lamdao(k)*Mg(k)/D*(DVk*((fo-0.5)*D+deltao(k))-V(k)*Ddeltaok))/((fo-0.5)*D+deltao(k))^2*cos(b*pi/N+2*pi*k/N);
end
      
k = 1:N;
Fi = [sum(Ki.*deltai.^1.5.*(Ui-U)./((fi-0.5)*D+deltai)+ lamdai.*Mg/D.*(Vi-V)./((fi-0.5)*D+deltai))
      sum((Ki.*deltai.^1.5.*(Vi-V)./((fi-0.5)*D+deltai)-lamdai.*Mg/D.*(Ui-U)./((fi-0.5)*D+deltai)).*cos(b*pi/N+2*pi*k/N))
      sum((Ki.*deltai.^1.5.*(Vi-V)./((fi-0.5)*D+deltai)-lamdai.*Mg/D.*(Ui-U)./((fi-0.5)*D+deltai)).*sin(b*pi/N+2*pi*k/N))
      sum((ric*(Ki.*deltai.^1.5.*(Ui-U)./((fi-0.5)*D+deltai)+lamdai.*Mg/D.*(Vi-V)./((fi-0.5)*D+deltai))-fi*Mg).*sin(b*pi/N+2*pi*k/N))
      -sum((ric*(Ki.*deltai.^1.5.*(Ui-U)./((fi-0.5)*D+deltai)+lamdai.*Mg/D.*(Vi-V)./((fi-0.5)*D+deltai))-fi*Mg).*cos(b*pi/N+2*pi*k/N))
      ] - preload;    
DFi = [sum(dFxi);sum(dFyi);sum(dFzi);sum(dMyi);sum(dMzi)];

DFo = [sum(dFxo);sum(dFyo);sum(dFzo);sum(dMyo);sum(dMzo)];

Fo =  -[sum(Ko.*deltao.^1.5.*U./((fo-0.5)*D+deltao)+ lamdao.*Mg/D.*V./((fo-0.5)*D+deltao))
      sum((Ko.*deltao.^1.5.*V./((fo-0.5)*D+deltao)-lamdao.*Mg/D.*U./((fo-0.5)*D+deltao)).*cos(b*pi/N+2*pi*k/N))
      sum((Ko.*deltao.^1.5.*V./((fo-0.5)*D+deltao)-lamdao.*Mg/D.*U./((fo-0.5)*D+deltao)).*sin(b*pi/N+2*pi*k/N))
      sum((roc*(Ko.*deltao.^1.5.*U./((fo-0.5)*D+deltao)+lamdao.*Mg/D.*V./((fo-0.5)*D+deltao))+fo*Mg).*sin(b*pi/N+2*pi*k/N))
      -sum((roc*(Ko.*deltao.^1.5.*U./((fo-0.5)*D+deltao)+lamdao.*Mg/D.*V./((fo-0.5)*D+deltao))+fo*Mg).*cos(b*pi/N+2*pi*k/N))
      ]; 
predisplacemt = delta;
 % test  = {1   2   3  4  5   6    7       8       9       10      11      12      13     14   15  16  17  18  19}
 test1  = {'Ko' 'Ki' 'U' 'V' 'Ui' 'Vi' 'deltao' 'deltai' 'lamdao' 'lamdai' 'thetao' 'thetai' 'alpha'  'Mg'  'Fck'};
 test2  = [Ko' Ki' U' V' Ui' Vi' deltao' deltai' lamdao' lamdai' thetao' thetai' alpha'  Mg' Fc'];  
 test  = { {test1 test2}  k1  k2  X  iter  F};  


    