% [BearingPredisplacement,Fi,DFi,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF,control);
% [Fi,DFi,Fo,DFo] = Stiffness_for_inner_ring(xi,preload,Speed,BF);
clear;close all;clc
global  test iter
% test  =  {1   2   3  4  5   6    7       8       9       10      11      12      13     14   15  16  17  18  19}
% test  = {[Ko' Ki' U' V' Ui' Vi' deltao' deltai' lamdao' lamdai' thetao' thetai' alpha'  Mg']  k1  k2  X  iter  F};  
iter = zeros(1,6);
Speed =0015000;BF = 1;
preload = [724 00 000 0 000]';feps = 1e-7;maxit = 200;
[predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF)
BF = -1;preload = [724 00 000 0 000]'
[predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF)
test1 = test;
X1  = test1{end-1};
[Fiv,DFiv,Fov,DFov,predisplacement] = Stiffness_for_inner_ring(predisplacement,preload,Speed,BF);
test2 = test;
X2  = test2{end-1};
displacement = [1e-6;0e-6;0e-6;0.0*pi/180;0.0*pi/180];
[KBT,Fi,DFi,Fo,DFo] = Stiffness_for_displacement_input(displacement,predisplacement,Speed,BF);
test3 = test;
X3  = test3{end-1};

KBTi = DFi;




