function varargout = youxianyuanjianmo(varargin)
% YOUXIANYUANJIANMO MATLAB code for youxianyuanjianmo.fig
%      YOUXIANYUANJIANMO, by itself, creates a new YOUXIANYUANJIANMO or raises the existing
%      singleton*.
%
%      H = YOUXIANYUANJIANMO returns the handle to a new YOUXIANYUANJIANMO or the handle to
%      the existing singleton*.
%
%      YOUXIANYUANJIANMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in YOUXIANYUANJIANMO.M with the given input arguments.
%
%      YOUXIANYUANJIANMO('Property','Value',...) creates a new YOUXIANYUANJIANMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before youxianyuanjianmo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to youxianyuanjianmo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help youxianyuanjianmo

% Last Modified by GUIDE v2.5 05-May-2017 16:49:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @youxianyuanjianmo_OpeningFcn, ...
                   'gui_OutputFcn',  @youxianyuanjianmo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before youxianyuanjianmo is made visible.
function youxianyuanjianmo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to youxianyuanjianmo (see VARARGIN)
global pho E mju ks rhod
Nb=str2double(get(handles.liangdanyuan_num_inpute,'string'));
pho=str2double(get(handles.zhuanzizhouchengdensity_input,'string'));
E=str2double(get(handles.Yangshimoliang_input,'string'));
mju=str2double(get(handles.bosongbi_input,'string'));
ks=str2double(get(handles.Ks_input,'string'));
Ld=eval(get(handles.yuanpanhoudu_input,'string'));
Ddo=eval(get(handles.yuanpanwaijing_input,'string'));
Ddi=eval(get(handles.yuanpanneijing_input,'string'));
ed=eval(get(handles.yuanpanpianxingliang_input,'string'));
phid=eval(get(handles.chushipianxinjiaodu_input,'string'));
rhod=str2double(get(handles.butongyuanpanmidu_input,'string'));
% Nb = 40;                                           % 40个梁单元
Lb = 400/Nb*1e-3*ones(1,Nb);                       % 轴长
Do = 20e-3*ones(1,Nb);
Di = zeros(1,length(Do));
P = 0000;                                          % 预紧力
% Parameters for Disk  

global Md Gd

%% Disk参数
Disk_Node_Number=[100/400*Nb+0 300/400*Nb+1];      % 圆盘节点数
% Ld =[20 20]*1e-3;                                  % ？？？？？厚度
% Ddo=[60 60]*1e-3;                                  % 圆盘外径
% Ddi=[20 20]*1e-3;                                  % 圆盘内径
a = Ddi/2;
b = Ddo/2;
% ed =[0 0]*1e-3;                                    % 圆盘偏心量
% phid = [0 0]*1e-3;                                 % 偏心角度
Nelement_of_Disk = Disk_Node_Number;
%% 各自建模
global qx qy qz my mz n Nof Omega  t
Speed = 000;
Omega = Speed*2*pi/60;                           % 主轴转动角速度
qx = 0;                                          % X方向分布载荷力
qy = 0;                                          % Y
qz = 0;                                          % Z 
my = 0;                                          % Y向分布载荷力矩 
mz = 0;                                          % Z

n  = length(Lb);                                 % 梁单元数
Nof = 5*(n+1);                                   % 自由度
sn = 0e-3*ones(Nof,1);                           % 节点位移
CS = zeros(Nof);                                 % 结构阻尼

t = 0;                                           % 时间
x0 = zeros(Nof,1);
[MD,GD,FD] = Finite_of_Disk(a,b,Ld,ed,phid,Nelement_of_Disk,Nof); % 圆盘有限元建模，得到质量矩阵 反对称矩阵 不平衡离心力矩阵

[MB,MC,KB,KBP,GB,FB] = Finite_of_Beam2(Lb,Do,Di,P,sn); % P 为常数  % 梁建模，得到质量 离心引起的质量 刚度 陀螺 节点力矩阵
KB1 = [1e15,zeros(1,4);
       0,3.503E+7,-8.756E+6,0,0;
       0,-8.756E+6,3.503E+7,0,0;
       zeros(3,5)];
KB2 = KB1;
KBTi = zeros(Nof);                                          
KBTi = BearingStiffnessAssemble5(KBTi,KB1,50/400*Nb+1);      % 加入轴承后的系统刚度     
KBTi = BearingStiffnessAssemble5(KBTi,KB2,350/400*Nb+1);
%% 转子-轴承—圆盘系统
M = MB + MD;                              % 系统质量矩阵   
K = KB + KBP + KBTi - Omega^2 * MC;       % 系统刚度矩阵
C = CS - GB*Omega - GD*Omega;             % 系统阻尼矩阵
[Ph,V] = eig(K,M);                        % 求特征值与特征向量；Ph为特征向量矩阵（N*N阶），V为对角线元素为特征值的对角阵
[V,ki] = sort(diag(V));                   % 将特征值（固有频率的平方）升序排列
Ph = Ph(:,ki);
VV = diag(sqrt(V));                       % 固有频率
Mi = Ph.'*M*Ph;mi = diag(Mi);
ksi = 1.5E-4 ;                            % 1E-4---6E-4结构阻尼
CS = 2*ksi*VV*Mi ;                        % 系统结构阻尼矩阵
VV = sqrt(V)/2/pi;   % 将固有频率的单位转化为赫兹（Hz）
gypl_jieshu=str2num(get(handles.gypl_jieshu_input,'string'));
fre=vpa(VV(1:gypl_jieshu),5); % 频率精度控制在5位

NLb = length(Lb);
xd(1) = 0;
for i = 1:n
    xd(i+1) = xd(i) + Lb(i);
end
xd = xd*1e3;
for step =1:20
    for i = 1:NLb+1    
        maxPh = max([Ph(:,step);-Ph(:,step)]);
        maxPhx = max(abs(Ph(1:5:end,step)));
        maxPhy = max(abs(Ph(2:5:end,step)));
        maxPhz = max(abs(Ph(3:5:end,step)));
        maxPhxyz = max([maxPhx maxPhy maxPhz]);
        maxPhay = max(abs(Ph(4:5:end,step)));
        maxPhaz = max(abs(Ph(5:5:end,step)));
        maxPhayz = max([maxPhay maxPhaz]);
        Px(i,step) = Ph(5*i-4,step)/maxPhxyz;
        Py(i,step) = Ph(5*i-3,step)/maxPhxyz;
        Pz(i,step) = Ph(5*i-2,step)/maxPhxyz;
        Pay(i,step) = Ph(5*i-1,step)/maxPhayz;
        Paz(i,step) = Ph(5*i,step)/maxPhayz;
    end
    Rp(:,step) = (Py(:,step).^2 + Pz(:,step).^2).^0.5;
end

bendmode = 1:20;   %bendmode([17,18])=[];

handles.K=K;
handles.M=M;
handles.C=C;
handles.NLb=NLb;
handles.xd=xd;
handles.Py=Py;
handles.Pz=Pz;
handles.Rp=Rp;
handles.Px=Px;
handles.fre=fre;
handles.VV=VV;
% fre=fre(1:gypl_jieshu);
set(handles.guyoufrequence_output,'Data',eval(fre));
% Choose default command line output for youxianyuanjianmo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes youxianyuanjianmo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = youxianyuanjianmo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function yuanpanhoudu_input_Callback(hObject, eventdata, handles)
% hObject    handle to yuanpanhoudu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yuanpanhoudu_input as text
%        str2double(get(hObject,'String')) returns contents of yuanpanhoudu_input as a double


% --- Executes during object creation, after setting all properties.
function yuanpanhoudu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yuanpanhoudu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[20 20]*1e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yuanpanwaijing_input_Callback(hObject, eventdata, handles)
% hObject    handle to yuanpanwaijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yuanpanwaijing_input as text
%        str2double(get(hObject,'String')) returns contents of yuanpanwaijing_input as a double


% --- Executes during object creation, after setting all properties.
function yuanpanwaijing_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yuanpanwaijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[60 60]*1e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yuanpanneijing_input_Callback(hObject, eventdata, handles)
% hObject    handle to yuanpanneijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yuanpanneijing_input as text
%        str2double(get(hObject,'String')) returns contents of yuanpanneijing_input as a double


% --- Executes during object creation, after setting all properties.
function yuanpanneijing_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yuanpanneijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[20 20]*1e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yuanpanpianxingliang_input_Callback(hObject, eventdata, handles)
% hObject    handle to yuanpanpianxingliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yuanpanpianxingliang_input as text
%        str2double(get(hObject,'String')) returns contents of yuanpanpianxingliang_input as a double


% --- Executes during object creation, after setting all properties.
function yuanpanpianxingliang_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yuanpanpianxingliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[0 0]*1e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function chushipianxinjiaodu_input_Callback(hObject, eventdata, handles)
% hObject    handle to chushipianxinjiaodu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chushipianxinjiaodu_input as text
%        str2double(get(hObject,'String')) returns contents of chushipianxinjiaodu_input as a double


% --- Executes during object creation, after setting all properties.
function chushipianxinjiaodu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chushipianxinjiaodu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[0 0]*1e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function butongyuanpanmidu_input_Callback(hObject, eventdata, handles)
% hObject    handle to butongyuanpanmidu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of butongyuanpanmidu_input as text
%        str2double(get(hObject,'String')) returns contents of butongyuanpanmidu_input as a double


% --- Executes during object creation, after setting all properties.
function butongyuanpanmidu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to butongyuanpanmidu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','7806');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function liangdanyuan_num_inpute_Callback(hObject, eventdata, handles)
% hObject    handle to liangdanyuan_num_inpute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of liangdanyuan_num_inpute as text
%        str2double(get(hObject,'String')) returns contents of liangdanyuan_num_inpute as a double


% --- Executes during object creation, after setting all properties.
function liangdanyuan_num_inpute_CreateFcn(hObject, eventdata, handles)
% hObject    handle to liangdanyuan_num_inpute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','40');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zhuanzizhouchengdensity_input_Callback(hObject, eventdata, handles)
% hObject    handle to zhuanzizhouchengdensity_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zhuanzizhouchengdensity_input as text
%        str2double(get(hObject,'String')) returns contents of zhuanzizhouchengdensity_input as a double


% --- Executes during object creation, after setting all properties.
function zhuanzizhouchengdensity_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhuanzizhouchengdensity_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','7806');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yangshimoliang_input_Callback(hObject, eventdata, handles)
% hObject    handle to Yangshimoliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yangshimoliang_input as text
%        str2double(get(hObject,'String')) returns contents of Yangshimoliang_input as a double


% --- Executes during object creation, after setting all properties.
function Yangshimoliang_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yangshimoliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','2.08e11');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bosongbi_input_Callback(hObject, eventdata, handles)
% hObject    handle to bosongbi_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bosongbi_input as text
%        str2double(get(hObject,'String')) returns contents of bosongbi_input as a double


% --- Executes during object creation, after setting all properties.
function bosongbi_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bosongbi_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','0.3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ks_input_Callback(hObject, eventdata, handles)
% hObject    handle to Ks_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ks_input as text
%        str2double(get(hObject,'String')) returns contents of Ks_input as a double


% --- Executes during object creation, after setting all properties.
function Ks_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ks_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','0.9');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function guyoufrequence_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to guyoufrequence_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in plot1_pushbutton.
function plot1_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plot1_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
K=handles.K;
M=handles.M;
C=handles.C;
clear H11 H12  H13 H14 H15 H21 H22 H23 H24 H25 H31 H32 H33 H34 H35 H41 H42 H43 H44 H45 H51 H52 H53 H54 H55 
ij = 0;
f = 300:7:1000;
w0 = 2*pi*f;
for w = w0
    ij = ij + 1;
    H = inv(K+1i*w*C-M*w^2);
    H11(ij) = H(1,1);H12(ij) = H(1,2);H13(ij) = H(1,3);H14(ij) = H(1,4);H15(ij) = H(1,5);
    H21(ij) = H(2,1);H22(ij) = H(2,2);H23(ij) = H(2,3);H24(ij) = H(2,4);H25(ij) = H(2,5);
    H31(ij) = H(3,1);H32(ij) = H(3,2);H33(ij) = H(3,3);H34(ij) = H(3,4);H35(ij) = H(3,5);
    H41(ij) = H(4,1);H42(ij) = H(4,2);H43(ij) = H(4,3);H44(ij) = H(4,4);H45(ij) = H(4,5);
    H51(ij) = H(5,1);H52(ij) = H(5,2);H53(ij) = H(5,3);H54(ij) = H(5,4);H55(ij) = H(5,5);
end
figure();
plot(f,abs(H22),'r-');title('幅值');xlabel('频率/Hz');ylabel('幅值/m');
set(gca,'Ylim',[0 5e-5]);

% --- Executes on button press in plot2_pushbutton.
function plot2_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plot2_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NLb=handles.NLb;
xd=handles.xd;
Rp=handles.Rp;
Py=handles.Py;
Pz=handles.Pz;
phis = linspace(0,2*pi,36)';
sph = size(phis);
bendmode =eval(get(handles.kjzxhuitujieshu_input,'string'));
bendmode_max=length(bendmode);
bendmode_max_h=ceil(bendmode_max/4);  %向上取整
figure('NumberTitle','off','Name','空间振型曲线');
for stepcu = bendmode    
    xs =[];ys = [];zs = []; 
    for i = 1:NLb+1
        xs = [xs;xd(i)*ones(sph)];
        ys = [ys;Rp(i,stepcu)*cos(phis)];
        zs = [zs;Rp(i,stepcu)*sin(phis)];
    end
    xss(:,stepcu)=xs;yss(:,stepcu)=ys;zss(:,stepcu)=zs;   
    if (rem(stepcu-1,9)==0)
        figure();
    end
    subplot(3,3,rem(stepcu-1,9)+1);
    plot3(xd,Py(:,stepcu),Pz(:,stepcu),'b.-','LineWidth',2);hold on ;
    plot3(xss(:,stepcu),yss(:,stepcu),zss(:,stepcu),'g','LineWidth',0.1);
    xlabel('轴段位置x /mm');ylabel('Y');zlabel('Z');
end

% --- Executes on button press in plot3_pushbutton.
function plot3_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plot3_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bendmode =eval(get(handles.kjzxhuitujieshu_input,'string'));  %bendmode([17,18])=[];
Py=handles.Py;
Px=handles.Px;
xd=handles.xd;
for i = bendmode  
    if (rem(i-1,9)==0)
        figure('NumberTitle','off','Name','轴向振型曲线');
    end  
subplot(3,3,rem(i-1,9)+1);
plot(xd,Px(:,i)); xlabel('轴段位置/mm');ylabel('Px') % 轴向
end


for i = bendmode  
    if (rem(i-1,9)==0)
        figure('NumberTitle','off','Name','Y向振型曲线');
    end  
subplot(3,3,rem(i-1,9)+1);
plot(xd,Py(:,i)); xlabel('轴段位置/mm');ylabel('Py') % y向
end

for i = bendmode  
    if (rem(i-1,9)==0)
      figure('NumberTitle','off','Name','Z向振型曲线');
    end  
subplot(3,3,rem(i-1,9)+1);
plot(xd,Py(:,i)); xlabel('轴段位置/mm');ylabel('Pz') % z向
end

% --- Executes when entered data in editable cell(s) in guyoufrequence_output.
function guyoufrequence_output_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to guyoufrequence_output (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function kjzxhuitujieshu_input_Callback(hObject, eventdata, handles)
% hObject    handle to kjzxhuitujieshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kjzxhuitujieshu_input as text
%        str2double(get(hObject,'String')) returns contents of kjzxhuitujieshu_input as a double


% --- Executes during object creation, after setting all properties.
function kjzxhuitujieshu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kjzxhuitujieshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[1 2 3 ]');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --------------------------------------------------------------------
function close_menu_Callback(hObject, eventdata, handles)
% hObject    handle to close_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(f);



function gypl_jieshu_input_Callback(hObject, eventdata, handles)
% hObject    handle to gypl_jieshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gypl_jieshu_input as text
%        str2double(get(hObject,'String')) returns contents of gypl_jieshu_input as a double


% --- Executes during object creation, after setting all properties.
function gypl_jieshu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gypl_jieshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','20');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in caculater_pushbutton.
function caculater_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to caculater_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gypl_jieshu=str2num(get(handles.gypl_jieshu_input,'string'));
VV=handles.VV;
% fre=handles.fre;
fre=vpa(VV(1:gypl_jieshu),5);
% fre=fre(1:gypl_jieshu);
set(handles.guyoufrequence_output,'Data',eval(fre));
