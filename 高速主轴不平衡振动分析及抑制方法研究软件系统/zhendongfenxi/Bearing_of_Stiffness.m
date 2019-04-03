% 被调用子函数：[Fi,DFi,Fo,DFo] =% Stiffness_for_inner_ring(xi,preload,Speed,BF)：轴承刚度求解
% 内循环（滚动体几何关系和力平衡关系方程）采用改进的Newton-Raphson迭代算法，外循环（内外圈力平衡）采用一般的Newton—Raphson迭代算法。
% 主函数：[BearingPredisplacement,Fi,DFi,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF)
% 输入：preload：预紧力；feps：力平衡控制精度；maxit：最大迭代次数。
% 输出：BearingPredisplacement：轴承刚度对应的轴承位移；iteri、flagi求解刚度迭代次数和求解标志。
function [BearingPredisplacement,Fi,DFi,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF)
% % 输入轴承几何参数
global test2 test3   % 全局变量 
%  test2  = [Ko' Ki' U' V' Ui' Vi' deltao' deltai' lamdao' lamdai' thetao' thetai' alpha'  Mg'];  
% 采用boolean 运算势必预紧力对应的位移是否存在。
ux = BF*boolean(preload(1));uy = boolean(preload(2));uz = boolean(preload(3));ay = boolean(preload(4));az = boolean(preload(5));
xi = [(ux+ay-0.5*az)*1e-6;(uy+0.5*az)*1e-6;(uz+0.5*ay)*1e-6;(ay+0.5*uz)*pi/180/10;(az+0.5*uy)*pi/180/10];
% 外部及函数输入
flagi = 1;    iteri = 0;   
while(flagi)
    iteri = iteri + 1;
    [Fi,DFi] = Stiffness_for_inner_ring(xi,preload,Speed,BF);    
    % for 内圈
        dxi = DFi\Fi;
        xi = xi - dxi; 
    if norm(Fi)<=feps 
       % fprintf('2...Solution has been found !');
        break;
    end
    if iteri == maxit && norm(Fi)>feps
        fprintf('2...Solution not found within maxit iter！')
        flagi = 0;
    end
end
test3 = test2(1,:);
BearingPredisplacement = xi;
%%
