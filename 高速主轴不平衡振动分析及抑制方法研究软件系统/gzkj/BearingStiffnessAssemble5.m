% function y=BearingStiffnessAssemble5(KBT,KBt,i)：5自由度轴承单元的刚度集总函数。
% 输入：KBT：系统的刚度矩阵；Kbt：轴承的刚度矩阵；i：轴承所在位置节点号。
% 输出：y：加入轴承刚度后的系统刚度矩阵。
function y=BearingStiffnessAssemble5(KBT,KBt,i)
    
KBT(5*i-4,5*i-4) = KBT(5*i-4,5*i-4) + KBt(1,1);  KBT(5*i-4,5*i-3) = KBT(5*i-4,5*i-3) + KBt(1,2);
KBT(5*i-4,5*i-2) = KBT(5*i-4,5*i-2) + KBt(1,3);  KBT(5*i-4,5*i-1) = KBT(5*i-4,5*i-1) + KBt(1,4);
KBT(5*i-4,5*i)   = KBT(5*i-4,5*i)   + KBt(1,5);  


KBT(5*i-3,5*i-4) = KBT(5*i-3,5*i-4) + KBt(2,1);  KBT(5*i-3,5*i-3) = KBT(5*i-3,5*i-3) + KBt(2,2);
KBT(5*i-3,5*i-2) = KBT(5*i-3,5*i-2) + KBt(2,3);  KBT(5*i-3,5*i-1) = KBT(5*i-3,5*i-1) + KBt(2,4);
KBT(5*i-3,5*i)   = KBT(5*i-3,5*i)   + KBt(2,5);  

KBT(5*i-2,5*i-4) = KBT(5*i-2,5*i-4) + KBt(3,1);  KBT(5*i-2,5*i-3) = KBT(5*i-2,5*i-3) + KBt(3,2);
KBT(5*i-2,5*i-2) = KBT(5*i-2,5*i-2) + KBt(3,3);  KBT(5*i-2,5*i-1) = KBT(5*i-2,5*i-1) + KBt(3,4);
KBT(5*i-2,5*i)   = KBT(5*i-2,5*i)   + KBt(3,5);  


KBT(5*i-1,5*i-4) = KBT(5*i-1,5*i-4) + KBt(4,1);  KBT(5*i-1,5*i-3) = KBT(5*i-1,5*i-3) + KBt(4,2);
KBT(5*i-1,5*i-2) = KBT(5*i-1,5*i-2) + KBt(4,3);  KBT(5*i-1,5*i-1) = KBT(5*i-1,5*i-1) + KBt(4,4);
KBT(5*i-1,5*i)   = KBT(5*i-1,5*i)   + KBt(4,5);  


KBT(5*i,5*i-4) = KBT(5*i,5*i-4) + KBt(5,1);  KBT(5*i,5*i-3) = KBT(5*i,5*i-3) + KBt(5,2);
KBT(5*i,5*i-2) = KBT(5*i,5*i-2) + KBt(5,3);  KBT(5*i,5*i-1) = KBT(5*i,5*i-1) + KBt(5,4);
KBT(5*i,5*i)   = KBT(5*i,5*i)   + KBt(5,5); 

y = KBT;
end
