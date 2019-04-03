function varargout = bphxysb(varargin)
% BPHXYSB MATLAB code for bphxysb.fig
%      BPHXYSB, by itself, creates a new BPHXYSB or raises the existing
%      singleton*.
%
%      H = BPHXYSB returns the handle to a new BPHXYSB or the handle to
%      the existing singleton*.
%
%      BPHXYSB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BPHXYSB.M with the given input arguments.
%
%      BPHXYSB('Property','Value',...) creates a new BPHXYSB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bphxysb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bphxysb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bphxysb

% Last Modified by GUIDE v2.5 10-May-2017 23:44:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bphxysb_OpeningFcn, ...
                   'gui_OutputFcn',  @bphxysb_OutputFcn, ...
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


% --- Executes just before bphxysb is made visible.
function bphxysb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no bph_output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bphxysb (see VARARGIN)

% Choose default command line bph_output for bphxysb
handles.bph_output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bphxysb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bphxysb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning bph_output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line bph_output from handles structure
varargout{1} = handles.bph_output;


% --- Executes on selection change in popupmenu1.


% --- Executes on selection change in peizhongpanfangan_popupmenu.
function peizhongpanfangan_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to peizhongpanfangan_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fangan=get(handles.peizhongpanfangan_popupmenu,'value');
switch fangan
    case 1
        set(handles.edit1,'string','1500');
        set(handles.edit2,'string','方案一：第1、4盘为钢，2、3盘为铝，不平衡量位于1、2、3、4盘 ');
        set(handles.edit3,'string','[60 490]');
        set(handles.edit4,'string','[150 230 320 400]');
        set(handles.edit5,'string','[120 430]');
        set(handles.edit6,'string','{LS SA SA LS};');
        set(handles.edit7,'string','[30 20 20 30]/1000');
        set(handles.edit8,'string','[30 60 115 255]*pi/180');
        set(handles.edit9,'string','[0.5 1.5 0.7 1.2]/1000');
    case 2
        set(handles.edit1,'string','2000');
        set(handles.edit2,'string','方案二：第1、3、4盘为铝，2盘为钢，不平衡量位于2、4盘 ');
        set(handles.edit3,'string','[60 420]');
        set(handles.edit4,'string','[130 240 350 490]');
        set(handles.edit5,'string','[150 330]');
        set(handles.edit6,'string','{LA LS SA LA};');
        set(handles.edit7,'string','[30 30 20 30]/1000');
        set(handles.edit8,'string','[0 60 0 180]*pi/180');
        set(handles.edit9,'string','[0 2 0 2]/1000');
    case 3
        set(handles.edit1,'string','3500');
        set(handles.edit2,'string','方案三：两轴承之间等间距放5个小铝盘，不平衡量位于1、2、3、4、5盘 ');
        set(handles.edit3,'string','[60 420]');
        set(handles.edit4,'string','[120 180 240 300 360]');
        set(handles.edit5,'string','[150 330]');
        set(handles.edit6,'string','{SA SA SA SA SA};');
        set(handles.edit7,'string','[20 20 20 20 20]/1000');
        set(handles.edit8,'string','[0 60 90 150 300]*pi/180');
        set(handles.edit9,'string','[2 2 2 2 2]/1000');
        
end


% Hints: contents = cellstr(get(hObject,'String')) returns peizhongpanfangan_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from peizhongpanfangan_popupmenu


% --- Executes during object creation, after setting all properties.
function peizhongpanfangan_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peizhongpanfangan_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function peizhongpancailiaojibupinghengweizhi_output_Callback(hObject, eventdata, handles)
% hObject    handle to peizhongpancailiaojibupinghengweizhi_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peizhongpancailiaojibupinghengweizhi_output as text
%        str2double(get(hObject,'String')) returns contents of peizhongpancailiaojibupinghengweizhi_output as a double


% --- Executes during object creation, after setting all properties.
function peizhongpancailiaojibupinghengweizhi_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peizhongpancailiaojibupinghengweizhi_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in beizhongpanxiangguancanshuxuanze_popupmenu.
function beizhongpanxiangguancanshuxuanze_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to beizhongpanxiangguancanshuxuanze_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
beizhongpanxiangguancanshuxuanze=get(handles.beizhongpanxiangguancanshuxuanze_popupmenu,'value');
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
switch beizhongpanxiangguancanshuxuanze
        case 1
            md = M_LS;
            Jp = Jp_LS;
            Jd = Jd_LS;
            ed = e_LS;
        case 2
            md = M_LA;
            Jp = Jp_LA;
            Jd = Jd_LA;
            ed = e_LA;
        case 3
            md = M_SA;
            Jp = Jp_SA;
            Jd = Jd_SA;
            ed = e_SA;
end 
h=[md'; Jp' ;Jd' ;ed'];
set(handles.peizhongpanxiangguancanshu_output,'string',h);
%     handles.md=md;
%     handles.Jp=Jp;
%     handles.Jd=Jd;
%     handles.ed=ed;
%     handles.bph_output = hObject;
%     guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns beizhongpanxiangguancanshuxuanze_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from beizhongpanxiangguancanshuxuanze_popupmenu


% --- Executes during object creation, after setting all properties.
function beizhongpanxiangguancanshuxuanze_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beizhongpanxiangguancanshuxuanze_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function peizhongpanxiangguancanshu_output_Callback(hObject, eventdata, handles)
% hObject    handle to peizhongpanxiangguancanshu_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peizhongpanxiangguancanshu_output as text
%        str2double(get(hObject,'String')) returns contents of peizhongpanxiangguancanshu_output as a double


% --- Executes during object creation, after setting all properties.
function peizhongpanxiangguancanshu_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peizhongpanxiangguancanshu_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yujinli_input_Callback(hObject, eventdata, handles)
% hObject    handle to yujinli_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yujinli_input as text
%        str2double(get(hObject,'String')) returns contents of yujinli_input as a double


% --- Executes during object creation, after setting all properties.
function yujinli_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yujinli_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[200;0e2;0e2;0e2;0e2]');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pho_input_Callback(hObject, eventdata, handles)
% hObject    handle to pho_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pho_input as text
%        str2double(get(hObject,'String')) returns contents of pho_input as a double


% --- Executes during object creation, after setting all properties.
function pho_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pho_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','7.806e3')
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dapankongshu_input_Callback(hObject, eventdata, handles)
% hObject    handle to dapankongshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dapankongshu_input as text
%        str2double(get(hObject,'String')) returns contents of dapankongshu_input as a double


% --- Executes during object creation, after setting all properties.
function dapankongshu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dapankongshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','16');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E_input_Callback(hObject, eventdata, handles)
% hObject    handle to E_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E_input as text
%        str2double(get(hObject,'String')) returns contents of E_input as a double


% --- Executes during object creation, after setting all properties.
function E_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','2.08e11')
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xiaopankongshu_input_Callback(hObject, eventdata, handles)
% hObject    handle to xiaopankongshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xiaopankongshu_input as text
%        str2double(get(hObject,'String')) returns contents of xiaopankongshu_input as a double


% --- Executes during object creation, after setting all properties.
function xiaopankongshu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xiaopankongshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','10');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function luodingzhiliang_input_Callback(hObject, eventdata, handles)
% hObject    handle to luodingzhiliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of luodingzhiliang_input as text
%        str2double(get(hObject,'String')) returns contents of luodingzhiliang_input as a double


% --- Executes during object creation, after setting all properties.
function luodingzhiliang_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to luodingzhiliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[0.2,2.0]');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mju_input_Callback(hObject, eventdata, handles)
% hObject    handle to mju_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mju_input as text
%        str2double(get(hObject,'String')) returns contents of mju_input as a double


% --- Executes during object creation, after setting all properties.
function mju_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mju_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','0.3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in draw_pushbutton.
function draw_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to draw_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pho E mju
ksi = 2E-4 ;    %   1E-4---6E-4结构阻尼比
% 配重
N_L = 16;   N_S = 10; m_bolt = [0.2,2.0];
preload=eval(get(handles.yujinli_input,'string'));
pho=str2double(get(handles.pho_input,'string'));
E=str2double(get(handles.E_input,'string'));
mju=str2double(get(handles.mju_input,'string'));
%%
Case = get(handles.peizhongpanfangan_popupmenu,'value');
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
% preload = [200;0e2;0e2;0e2;0e2];
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

set(handles.yuanshibupinghengliang_output,'Data',U_R);
set(handles.shibiebupinghengliang_output,'Data',U_RI);





% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over beizhongpanxiangguancanshuxuanze_popupmenu.
function beizhongpanxiangguancanshuxuanze_popupmenu_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to beizhongpanxiangguancanshuxuanze_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function bph_output_Callback(hObject, eventdata, handles)
% hObject    handle to bph_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bph_output as text
%        str2double(get(hObject,'String')) returns contents of bph_output as a double


% --- Executes during object creation, after setting all properties.
function bph_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bph_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
