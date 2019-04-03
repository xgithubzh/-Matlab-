function varargout = zhouchenggangduqiujie(varargin)
% ZHOUCHENGGANGDUQIUJIE MATLAB code for zhouchenggangduqiujie.fig
%      ZHOUCHENGGANGDUQIUJIE, by itself, creates a new ZHOUCHENGGANGDUQIUJIE or raises the existing
%      singleton*.
%
%      H = ZHOUCHENGGANGDUQIUJIE returns the handle to a new ZHOUCHENGGANGDUQIUJIE or the handle to
%      the existing singleton*.
%
%      ZHOUCHENGGANGDUQIUJIE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZHOUCHENGGANGDUQIUJIE.M with the given input arguments.
%
%      ZHOUCHENGGANGDUQIUJIE('Property','Value',...) creates a new ZHOUCHENGGANGDUQIUJIE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before zhouchenggangduqiujie_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to zhouchenggangduqiujie_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help zhouchenggangduqiujie

% Last Modified by GUIDE v2.5 03-May-2017 15:52:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @zhouchenggangduqiujie_OpeningFcn, ...
                   'gui_OutputFcn',  @zhouchenggangduqiujie_OutputFcn, ...
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


% --- Executes just before zhouchenggangduqiujie is made visible.
function zhouchenggangduqiujie_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to zhouchenggangduqiujie (see VARARGIN)
global Di1 Do1 D1 N1 theta1 weigth1 yangshi_neiwaiquan1 yangshi_gundongti1 bosongbi_neiwaiquan1 bosongbi_gundongti1  zhouchengxinghao1
Di1=str2double(get(handles.neiquanneijing_input,'string'));
Di=Di1;
Do1=str2double(get(handles.waiquanwaijing_input,'string'));
Do=Do1;
D1=str2double(get(handles.gundongtizhijing_input,'string'));
D=D1;
N1=str2double(get(handles.gundongtizongshu_input,'string'));
N=N1;
theta1=eval(get(handles.chushijiechujiao_input,'string'));
theta=theta1;
weigth1=str2double(get(handles.weigth_input,'string'));
yangshi_neiwaiquan1=str2double(get(handles.yangshi_neiwaiquan_input,'string'));
yangshi_gundongti1=str2double(get(handles.yangshi_gundongti_input,'string'));
bosongbi_neiwaiquan1=str2double(get(handles.bosongbi_neiwaiquan_input,'string'));
bosongbi_gundongti1=str2double(get(handles.bosongbi_gundongti_input,'string'));
yujinli_Fx1=str2double(get(handles.yujinli_Fx1_input,'string'));
yujinli_Fy1=eval(get(handles.yujinli_Fy1_input,'string'));
Speed1=str2double(get(handles.Speed1_input,'string'));
Speed=Speed1;
zhouchengxinghao1=str2double(get(handles.BF_input,'string'));
% save('E:\matlab GUI\gzkj\chuandishuju\chuandishuju.mat','Di1','Do1','D1','N1','theta1');
% [f,J,outpara] = Ball_balance(x0,delta,k,Di,Do,D,N,theta,Speed); 
% [Xval,Fval,Jval,iterations,flag] = Newton_Raphson_for_Multifunction(Fun,X0,spc,ftol,count,A,maxit,varargin); 
% [Fi,DFi,Fo,DFo,predisplacemt] = Stiffness_for_inner_ring(delta,preload,Speed,Di,Do,D,N,theta);
global  test iter 
format long
BF = zhouchengxinghao1;                             % 选择轴承
iter = zeros(1,6);
feps = 1e-6;maxit = 200;
b=-1;k = (1:N)';              % 常量
phi = (b*pi/N+2*pi*k/N);             % 第k个滚动体的位置角
phid = (b*pi/N+2*pi*k/N)*180/pi;     % 单位换算
i = 0;preload = zeros(5,1);
Prefy = yujinli_Fy1;                   % Y方向载荷大小  0 100 200 300
Prefx = yujinli_Fx1;                         % X方向载荷
Premz = -linspace(0,6,length(Prefy));
preload(1) = Prefx;
% Speedn = 0:5000:15000;
% Speedn = 10000;
% 
% for 
%     Speed = Speedn    
    i = i+1;j = 0;
    for Preload = Prefy
        j = j + 1;
        preload(2) = Preload;
        preload(5) = Premz(j);
        [predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF);        
        test1 = test{1};
        test2 = test1{2};
        for i = k;
%             Ko(i,j) = test2(i,1)*(1e-6)^1.5;  % 接触系数N/um^1.5
%             Ki(i,j) = test2(i,2)*(1e-6)^1.5;
            Ko(i,j) = test2(i,1);  % 接触系数N/um^1.5
            Ki(i,j) = test2(i,2);
            U = test2(i,3);
            V = test2(i,4);
            Ui = test2(i,5);
            Vi = test2(i,6);
%             deltao(i,j) = test2(i,7)*1e6;    % 接触变形/um
%             deltai(i,j) = test2(i,8)*1e6;
            deltao(i,j) = test2(i,7);    % 接触变形/um
            deltai(i,j) = test2(i,8);
            lamdao(i,j) = test2(i,9);
            lamdai(i,j) = test2(i,10);
            % 角度/度
            thetao(i,j) = test2(i,11)*180/pi;
            thetai(i,j) = test2(i,12)*180/pi;
            alpha(i,j) = test2(i,13)*180/pi;
            Mg(i,j) = test2(i,14);         % N.mm
            Fc(i,j) = test2(i,15);
            sxi(i,j) = predisplacement(1)*1e6; % /um
            syi(i,j) = predisplacement(2)*1e6;
            Qi(i,j) = Ki(i,j).*deltai(i,j).^1.5;
            Qo(i,j) = Ko(i,j).*deltao(i,j).^1.5;
            % 刚度 / N/um
        end
    end
    handles.phid=phid;
    handles.Mg=Mg;
    handles.Fc=Fc;
    handles.Qi=Qi;
    handles.Qo=Qo;
    handles.thetai=thetai;
    handles.theatao=thetao;
    handles.DFiv1=DFiv1;
   guidata(hObject,handles)

% Choose default command line output for zhouchenggangduqiujie
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes zhouchenggangduqiujie wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = zhouchenggangduqiujie_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function neiquanneijing_input_Callback(hObject, eventdata, handles)
% hObject    handle to neiquanneijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of neiquanneijing_input as text
%        str2double(get(hObject,'String')) returns contents of neiquanneijing_input as a double


% --- Executes during object creation, after setting all properties.
function neiquanneijing_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to neiquanneijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','70e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function waiquanwaijing_input_Callback(hObject, eventdata, handles)
% hObject    handle to waiquanwaijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of waiquanwaijing_input as text
%        str2double(get(hObject,'String')) returns contents of waiquanwaijing_input as a double


% --- Executes during object creation, after setting all properties.
function waiquanwaijing_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waiquanwaijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','100e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gundongtizhijing_input_Callback(hObject, eventdata, handles)
% hObject    handle to gundongtizhijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gundongtizhijing_input as text
%        str2double(get(hObject,'String')) returns contents of gundongtizhijing_input as a double


% --- Executes during object creation, after setting all properties.
function gundongtizhijing_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gundongtizhijing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','6.35e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gundongtizongshu_input_Callback(hObject, eventdata, handles)
% hObject    handle to gundongtizongshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gundongtizongshu_input as text
%        str2double(get(hObject,'String')) returns contents of gundongtizongshu_input as a double


% --- Executes during object creation, after setting all properties.
function gundongtizongshu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gundongtizongshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','32');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function chushijiechujiao_input_Callback(hObject, eventdata, handles)
% hObject    handle to chushijiechujiao_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chushijiechujiao_input as text
%        str2double(get(hObject,'String')) returns contents of chushijiechujiao_input as a double


% --- Executes during object creation, after setting all properties.
function chushijiechujiao_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chushijiechujiao_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','25*pi/180');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function weigth_input_Callback(hObject, eventdata, handles)
% hObject    handle to weigth_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of weigth_input as text
%        str2double(get(hObject,'String')) returns contents of weigth_input as a double


% --- Executes during object creation, after setting all properties.
function weigth_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to weigth_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','16e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bosongbi_neiwaiquan_input_Callback(hObject, eventdata, handles)
% hObject    handle to bosongbi_neiwaiquan_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bosongbi_neiwaiquan_input as text
%        str2double(get(hObject,'String')) returns contents of bosongbi_neiwaiquan_input as a double


% --- Executes during object creation, after setting all properties.
function bosongbi_neiwaiquan_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bosongbi_neiwaiquan_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','0.3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bosongbi_gundongti_input_Callback(hObject, eventdata, handles)
% hObject    handle to bosongbi_gundongti_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bosongbi_gundongti_input as text
%        str2double(get(hObject,'String')) returns contents of bosongbi_gundongti_input as a double


% --- Executes during object creation, after setting all properties.
function bosongbi_gundongti_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bosongbi_gundongti_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','0.26');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yangshi_neiwaiquan_input_Callback(hObject, eventdata, handles)
% hObject    handle to yangshi_neiwaiquan_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yangshi_neiwaiquan_input as text
%        str2double(get(hObject,'String')) returns contents of yangshi_neiwaiquan_input as a double


% --- Executes during object creation, after setting all properties.
function yangshi_neiwaiquan_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yangshi_neiwaiquan_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','2.08e11');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yangshi_gundongti_input_Callback(hObject, eventdata, handles)
% hObject    handle to yangshi_gundongti_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yangshi_gundongti_input as text
%        str2double(get(hObject,'String')) returns contents of yangshi_gundongti_input as a double


% --- Executes during object creation, after setting all properties.
function yangshi_gundongti_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yangshi_gundongti_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','3.15e11');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Speed1_input_Callback(hObject, eventdata, handles)
% hObject    handle to Speed1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Speed1_input as text
%        str2double(get(hObject,'String')) returns contents of Speed1_input as a double


% --- Executes during object creation, after setting all properties.
function Speed1_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Speed1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','10000');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gangducaculate_pushbutton.
function gangducaculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to gangducaculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global Di1 Do1 D1 N1 theta1 
% Di1=str2double(get(handles.neiquanneijing_input,'string'));
% Di=Di1;
% Do1=str2double(get(handles.waiquanwaijing_input,'string'));
% Do=Do1;
% D1=str2double(get(handles.gundongtizhijing_input,'string'));
% D=D1;
% N1=str2double(get(handles.gundongtizongshu_input,'string'));
% N=N1;
% theta1=eval(get(handles.chushijiechujiao_input,'string'));
% theta=theta1;
% weigth=str2double(get(handles.weigth_input,'string'));
% yangshi_neiwaiquan=str2double(get(handles.yangshi_neiwaiquan_input,'string'));
% yangshi_gundongti=str2double(get(handles.yangshi_gundongti_input,'string'));
% bosongbi_neiwaiquan=str2double(get(handles.bosongbi_neiwaiquan_input,'string'));
% bosongbi_gundongti=str2double(get(handles.bosongbi_gundongti_input,'string'));
% yujinli_x=str2double(get(handles.yujinli_Fx1_input,'string'));
% yujinli_y=eval(get(handles.yujinli_Fy1_input,'string'));
% Speed1=str2double(get(handles.Speed1_input,'string'));
% Speed=Speed1;
% zhouchengxinghao=str2double(get(handles.BF_input,'string'));
% % save('E:\matlab GUI\gzkj\chuandishuju\chuandishuju.mat','Di1','Do1','D1','N1','theta1');
% % [f,J,outpara] = Ball_balance(x0,delta,k,Di,Do,D,N,theta,Speed); 
% % [Xval,Fval,Jval,iterations,flag] = Newton_Raphson_for_Multifunction(Fun,X0,spc,ftol,count,A,maxit,varargin); 
% % [Fi,DFi,Fo,DFo,predisplacemt] = Stiffness_for_inner_ring(delta,preload,Speed,Di,Do,D,N,theta);
% global  test iter 
% format long
% BF = zhouchengxinghao;                             % 选择轴承
% iter = zeros(1,6);
% feps = 1e-6;maxit = 200;
% b=-1;k = (1:N)';              % 常量
% phi = (b*pi/N+2*pi*k/N);             % 第k个滚动体的位置角
% phid = (b*pi/N+2*pi*k/N)*180/pi;     % 单位换算
% i = 0;preload = zeros(5,1);
% Prefy = yujinli_y;                   % Y方向载荷大小  0 100 200 300
% Prefx = yujinli_x;                         % X方向载荷
% Premz = -linspace(0,6,length(Prefy));
% preload(1) = Prefx;
% % Speedn = 0:5000:15000;
% % Speedn = 10000;
% % 
% % for 
% %     Speed = Speedn    
%     i = i+1;j = 0;
%     for Preload = Prefy
%         j = j + 1;
%         preload(2) = Preload;
%         preload(5) = Premz(j);
%         [predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF);        
%         test1 = test{1};
%         test2 = test1{2};
%         for i = k;
% %             Ko(i,j) = test2(i,1)*(1e-6)^1.5;  % 接触系数N/um^1.5
% %             Ki(i,j) = test2(i,2)*(1e-6)^1.5;
%             Ko(i,j) = test2(i,1);  % 接触系数N/um^1.5
%             Ki(i,j) = test2(i,2);
%             U = test2(i,3);
%             V = test2(i,4);
%             Ui = test2(i,5);
%             Vi = test2(i,6);
% %             deltao(i,j) = test2(i,7)*1e6;    % 接触变形/um
% %             deltai(i,j) = test2(i,8)*1e6;
%             deltao(i,j) = test2(i,7);    % 接触变形/um
%             deltai(i,j) = test2(i,8);
%             lamdao(i,j) = test2(i,9);
%             lamdai(i,j) = test2(i,10);
%             % 角度/度
%             thetao(i,j) = test2(i,11)*180/pi;
%             thetai(i,j) = test2(i,12)*180/pi;
%             alpha(i,j) = test2(i,13)*180/pi;
%             Mg(i,j) = test2(i,14);         % N.mm
%             Fc(i,j) = test2(i,15);
%             sxi(i,j) = predisplacement(1)*1e6; % /um
%             syi(i,j) = predisplacement(2)*1e6;
%             Qi(i,j) = Ki(i,j).*deltai(i,j).^1.5;
%             Qo(i,j) = Ko(i,j).*deltao(i,j).^1.5;
%             % 刚度 / N/um
%         end
%     end
   DFiv1=handles.DFiv1;
   set(handles.zhouchenggangdu_output,'Data',DFiv1);
%     handles.phid=phid;
%     handles.Mg=Mg;
%     handles.Qi=Qi;
%     handles.Qo=Qo;
%     handles.thetai=thetai;
%     handles.theatao=thetao;
%    guidata(hObject,handles)

function yujinli_Fx1_input_Callback(hObject, eventdata, handles)
% hObject    handle to yujinli_Fx1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yujinli_Fx1_input as text
%        str2double(get(hObject,'String')) returns contents of yujinli_Fx1_input as a double


% --- Executes during object creation, after setting all properties.
function yujinli_Fx1_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yujinli_Fx1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','300');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yujinli_Fy1_input_Callback(hObject, eventdata, handles)
% hObject    handle to yujinli_Fy1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yujinli_Fy1_input as text
%        str2double(get(hObject,'String')) returns contents of yujinli_Fy1_input as a double


% --- Executes during object creation, after setting all properties.
function yujinli_Fy1_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yujinli_Fy1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','0:100:300');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zhouchengmidu_input_Callback(hObject, eventdata, handles)
% hObject    handle to zhouchengmidu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zhouchengmidu_input as text
%        str2double(get(hObject,'String')) returns contents of zhouchengmidu_input as a double


% --- Executes during object creation, after setting all properties.
function zhouchengmidu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhouchengmidu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','7800');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zhouchenggangdu_output_Callback(hObject, eventdata, handles)
% hObject    handle to zhouchenggangdu_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zhouchenggangdu_output as text
%        str2double(get(hObject,'String')) returns contents of zhouchenggangdu_output as a double


% --- Executes during object creation, after setting all properties.
function zhouchenggangdu_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhouchenggangdu_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function gangducaculate_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gangducaculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when entered data in editable cell(s) in zhouchenggangdu_output.
function zhouchenggangdu_output_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to zhouchenggangdu_output (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function BF_input_Callback(hObject, eventdata, handles)
% hObject    handle to BF_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of BF_input as text
%        str2double(get(hObject,'String')) returns contents of BF_input as a double


% --- Executes during object creation, after setting all properties.
function BF_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BF_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','1')
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in draw1_pushbutton.
function draw1_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to draw1_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    xlim = 500;
    phid=handles.phid;
    Mg=handles.Mg;
    Fc=handles.Fc;
    Qi=handles.Qi;
    Qo=handles.Qo;
    thetai=handles.thetai;
    thetao=handles.theatao;
     hmb1=msgbox('正在计算并绘图请耐心等待...','消息提示框');
%   hx = 0.35;hy = 0.35;xh = 0.1;yh = xh;
%   figure('units','normalized','position',[xh,yh,hx,hy]) 

    figure('NumberTitle','off','Name','各参数随位置角的变化曲线图');
    subplot(3,2,1)
    plot(phid,Mg(:,1),'-',phid,Mg(:,2),'*-',phid,Mg(:,3),'--',phid,Mg(:,4),'o-')
    h=legend('Fy=0','Fy=100N','Fy=200N','Fy=300N',1);
    set(h,'box','off');
    xlabel('\phi / \circ');
    ylabel('M_g / N.m');   
    title('陀螺力矩随位置角的变化');
    set(gca,'Xlim',[0 xlim])

    subplot(3,2,2)
    plot(phid,Fc(:,1),'-',phid,Fc(:,2),'*-',phid,Fc(:,3),'--',phid,Fc(:,4),'o-')
    h=legend('Fy=0','Fy=100N','Fy=200N','Fy=300N',1);
    set(h,'box','off');
    xlabel('\phi / \circ');
    ylabel('F_c / N')    
    title('离心力矩随位置角的变化');
    set(gca,'Xlim',[0 xlim])    
    %    
%     figure('units','normalized','position',[xh,yh,hx,hy])      
    subplot(3,2,3);  
    plot(phid,Qi(:,1),'-',phid,Qi(:,2),'*-',phid,Qi(:,3),'--',phid,Qi(:,4),'o-')
    h=legend('Fy=0','Fy=100N','Fy=200N','Fy=300N',1);
    set(h,'box','off');
    xlabel('\phi / \circ');
    ylabel('Q_i / N')  
    title('滚动体与内圈接触力随位置角的变化')
    set(gca,'Xlim',[0 xlim])
    subplot(3,2,4);
    plot(phid,Qo(:,1),'-',phid,Qo(:,2),'*-',phid,Qo(:,3),'--',phid,Qo(:,4),'o-')
    legend('Fy=0','Fy=100N','Fy=200N','Fy=300N')
    h=legend('Fy=0','Fy=100N','Fy=200N','Fy=300N',1);
    set(h,'box','off');
    xlabel('\phi / \circ');
    ylabel('Q_o / N') 
    title('滚动体与外圈接触力随位置角的变化')
    set(gca,'Xlim',[0 xlim])
             
%     figure('units','normalized','position',[xh,yh,hx,hy])     
    subplot(3,2,5)
    plot(phid,thetai(:,1),'-',phid,thetai(:,2),'*-',phid,thetai(:,3),'--',phid,thetai(:,4),'o-')
    h=legend('Fy=0','Fy=100N','Fy=200N','Fy=300N',1);
    set(h,'box','off');
    xlabel('\phi / \circ');
    ylabel('\alpha_i / \circ')
     title('滚动体与内圈接触角随位置角的变化')
    set(gca,'Xlim',[0 xlim])
    subplot(3,2,6)
    plot(phid,thetao(:,1),'-',phid,thetao(:,2),'*-',phid,thetao(:,3),'--',phid,thetao(:,4),'o-')
    h=legend('Fy=0','Fy=100N','Fy=200N','Fy=300N',1);
    set(h,'box','off');
    xlabel('\phi / \circ');
    ylabel('\alpha_o / \circ')
    title('滚动体与外圈接触角随位置角的变化')
    set(gca,'Xlim',[0 xlim])
    
    close(hmb1)
%    
%     figure()  % 
%     plot(phid,alpha(:,1),'-.',phid,alpha(:,2),'.-',phid,alpha(:,3),'--',phid,alpha(:,4),'*-')
%     legend('Fy=0','Fy=100N','Fy=200N','Fy=300N')
%     xlabel('\phi / \circ');
%     ylabel('\alpha / \circ')
%     set(gca,'Xlim',[0 550])
    


% --- Executes on button press in draw2_pushbutton.
function draw2_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to draw2_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 yujinli_Fx2=eval(get(handles.yujinli_Fx2_input,'string'));
 Speed2=str2double(get(handles.Speed2_input,'string'));
 hmb2=msgbox('正在计算并绘图请耐心等待...','消息提示框');
global N1  zhouchengxinghao1
N=N1;
global  test iter
format long
BF =zhouchengxinghao1;iter = zeros(1,6);
feps = 1e-6;maxit = 200;
b=-1;k = (1:N)';
phi = (b*pi/N+2*pi*k/N);
phid = (b*pi/N+2*pi*k/N)*180/pi;
%% Stiffness_for_Preload in the direction of X-axis,under Speed = 0、5000、10000、15000 r/min 
i = 0;preload = zeros(5,1);
Speedn = Speed2;%  0:5000:15000; 
Preloadf =yujinli_Fx2;
yujinli_Fx2_max=max(yujinli_Fx2);
for Speed = Speedn
    i = i+1;j = 0;
    for Preload = Preloadf
        j = j + 1;
        preload(1) = Preload;
        [predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF);        
        test1 = test{1};
        test2 = test1{2};
        Ko(i,j) = test2(1,1)*(1e-6)^1.5;  % 接触系数N/um^1.5
        Ki(i,j) = test2(1,2)*(1e-6)^1.5;
        U = test2(1,3);
        V = test2(1,4);
        Ui = test2(1,5);
        Vi = test2(1,6);
        deltao(i,j) = test2(1,7)*1e6;    % 接触变形/um
        deltai(i,j) = test2(1,8)*1e6;
        lamdao(i,j) = test2(1,9);
        lamdai(i,j) = test2(1,10);
        % 角度/度
        thetao(i,j) = test2(1,11)*180/pi;
        thetai(i,j) = test2(1,12)*180/pi;
        alpha(i,j) = test2(1,13)*180/pi;
        Mg(i,j) = test2(1,14);         % N.mm
        Fc(i,j) = test2(1,15);
        sxi(i,j) = predisplacement(1)*1e6; % /um
        Qi(i,j) = Ki(i,j).*deltai(i,j).^1.5;
        Qo(i,j) = Ko(i,j).*deltao(i,j).^1.5;
        % 刚度 / N/um
        K11(i,j) = DFiv1(1,1);  % Kx_x
        K22(i,j) = DFiv1(2,2);  % Ky_y
        K34(i,j) = DFiv1(3,4);  % Kz_ay
        K44(i,j) = DFiv1(4,4);  % Kay_ay
        K52(i,j) = DFiv1(5,2);  % Kaz_y 
    end
end   
% Stiffness_for_Preload in the direction of X-axis,under Speed = 0、5000、10000 r/min
Preload = Preloadf;
%% 
Para = {Mg,Fc,Qi,Qo,thetai,thetao,K11,K22,K34,K44,K52,alpha};
Ylab = {'M_g / N.m','F_c / N','Q_i / N','Q_o /N','\alpha_i / \circ','\alpha_o / \circ','K_{xx} / N/m',...
        'K_{yy} / N/m','K_{z\theta_y} / N/rad','K_{\theta_y\theta_y} / N.m/rad','K_{\theta_zy} / N.m/m','\beta / \circ',};  
    title_all={'陀螺力矩随轴向预紧力变化','离心力随轴向预紧力变化','内圈接触力随轴向预紧力变化','外圈接触力随轴向预紧力变化','内圈接触角随轴向预紧力变化',...
               '外圈接触角随轴向预紧力变化','轴向刚度随轴向预紧力变化','径向刚度随轴向预紧力变化','由Y向位移引起的Z向刚度随轴向预紧力的变化',...
               'Y向角刚度随轴向预紧力的变化','Y向刚度引起的Z向角位移随轴向预紧力的变化','接触角随轴向预紧力变化',};
xlim = 500;hx = 0.38; hy = 0.45;xh = 0.1;yh = xh;
figure('units','normalized','position',[xh,yh,hx,hy],'NumberTitle','off','Name','不同参数随轴向预紧力（Fx）的变化');
row = 6;clumn = 2; 

for kk = 1
      for i = 1:row
        for j = 1:clumn
            k = (i-1)*clumn+j;
            subplot(row,clumn,k);
            plot(Preload,Para{(kk-1)*row*clumn+k}(1,:),'.-')%,Speed,Mg(2,:),'x-',Speed,Mg(3,:),'.-');
            ylabel(Ylab{(kk-1)*row*clumn+k});
            title(title_all{(kk-1)*row*clumn+k});
            set(gca,'Xlim',[400 yujinli_Fx2_max]);
%             if i == row&&j==clumn-1
                xlabel('Fx / N');
%             end

           

        end
    end
end
close(hmb2)



function Speed2_input_Callback(hObject, eventdata, handles)
% hObject    handle to Speed2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Speed2_input as text
%        str2double(get(hObject,'String')) returns contents of Speed2_input as a double


% --- Executes during object creation, after setting all properties.
function Speed2_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Speed2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yujinli_Fx2_input_Callback(hObject, eventdata, handles)
% hObject    handle to yujinli_Fx2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yujinli_Fx2_input as text
%        str2double(get(hObject,'String')) returns contents of yujinli_Fx2_input as a double


% --- Executes during object creation, after setting all properties.
function yujinli_Fx2_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yujinli_Fx2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','400:200:2000');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in draw3_pushbutton.
function draw3_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to draw3_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 yujinli_Fx3=str2double(get(handles.yujinli_Fx3_input,'string'));
 Speed3=eval(get(handles.Speed3_input,'string'));
 Speed3_max=max(Speed3);
  hmb3=msgbox('正在计算并绘图请耐心等待...','消息提示框');
 global N1  zhouchengxinghao1
global  test iter
format long
BF =zhouchengxinghao1;iter = zeros(1,6);
feps = 1e-6;maxit = 200;
b=-1;N = N1;k = (1:N)';
phi = (b*pi/N+2*pi*k/N);
phid = (b*pi/N+2*pi*k/N)*180/pi;
i = 0;preload = zeros(5,1);
Preloadf = yujinli_Fx3;%:500:1500;
Speedn =Speed3;
for Preload = Preloadf    
    i = i+1;j = 0;
    for Speed = Speedn
        j = j + 1;
        preload(1) = Preload;
        [predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF);        
        test1 = test{1};
        test2 = test1{2};
        Ko(i,j) = test2(1,1)*(1e-6)^1.5;  % 接触系数N/um^1.5
        Ki(i,j) = test2(1,2)*(1e-6)^1.5;
        U = test2(1,3);
        V = test2(1,4);
        Ui = test2(1,5);
        Vi = test2(1,6);
        deltao(i,j) = test2(1,7)*1e6;    % 接触变形/um
        deltai(i,j) = test2(1,8)*1e6;
        lamdao(i,j) = test2(1,9);
        lamdai(i,j) = test2(1,10);
        % 角度/度
        thetao(i,j) = test2(1,11)*180/pi;
        thetai(i,j) = test2(1,12)*180/pi;
        alpha(i,j) = test2(1,13)*180/pi;
        Mg(i,j) = test2(1,14);         % N.mm
        Fc(i,j) = test2(1,15);
        sxi(i,j) = predisplacement(1)*1e6; % /um
        Qi(i,j) = Ki(i,j).*deltai(i,j).^1.5;
        Qo(i,j) = Ko(i,j).*deltao(i,j).^1.5;
        % 刚度 / N/um
        K11(i,j) = DFiv1(1,1);  % Kx_x
        K22(i,j) = DFiv1(2,2);  % Ky_y
        K34(i,j) = DFiv1(3,4);  % Kz_ay
        K44(i,j) = DFiv1(4,4);  % Kay_ay
        K52(i,j) = DFiv1(5,2);  % Kaz_y 
    end
end
Speed = Speedn;
Para = {Mg,Fc,Qi,Qo,thetai,thetao,K11,K22,K34,K44,K52,alpha};
Ylab = {'M_g / N.m','F_c / N','Q_i / N','Q_o /N','\alpha_i / \circ','\alpha_o / \circ','K_{xx} / N/m',...
        'K_{yy} / N/m','K_{z\theta_y} / N/rad','K_{\theta_y\theta_y} / N.m/rad','K_{\theta_zy} / N.m/m','\beta / \circ',};
title_all={'陀螺力矩随主轴转速的变化','离心力随主轴转速的变化','内圈接触力随主轴转速的变化','外圈接触力随主轴转速的变化','内圈接触角随主轴转速的变化',...
               '外圈接触角随主轴转速的变化','轴向刚度随主轴转速的变化','径向刚度随主轴转速的变化','由Y向位移引起的Z向刚度随主轴转速的变化',...
               'Y向角刚度随主轴转速的变化','Y向刚度引起的Z向角位移随主轴转速的变化','接触角随主轴转速的变化',};
row = 6;clumn = 2; 
xlim = 500;hx = 0.38; hy = 0.45;xh = 0.1;yh = xh;
figure('units','normalized','position',[xh,yh,hx,hy],'NumberTitle','off','Name','不同参数随主轴转速(Speed)的变化');
for kk = 1
    for i = 1:row
        for j = 1:clumn
            k = (i-1)*clumn+j;
            subplot(row,clumn,k);
            plot(Speed,Para{(kk-1)*row*clumn+k}(1,:),'.-')%,Speed,Mg(2,:),'x-',Speed,Mg(3,:),'.-');
            ylabel(Ylab{(kk-1)*row*clumn+k});
            set(gca,'Xlim',[0  Speed3_max+1000]);%set(gca,'Ylim',1.05*[0 max(Para{(kk-1)*row*clumn+k}(1,:))]);
%             if i == row&&j==clumn-1
           title(title_all{(kk-1)*row*clumn+k});
                xlabel('Speed /（r/min）');
%             end
        end
    end
end
close(hmb3)


function Speed3_input_Callback(hObject, eventdata, handles)
% hObject    handle to Speed3_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Speed3_input as text
%        str2double(get(hObject,'String')) returns contents of Speed3_input as a double


% --- Executes during object creation, after setting all properties.
function Speed3_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Speed3_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','0:1000:10000');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yujinli_Fx3_input_Callback(hObject, eventdata, handles)
% hObject    handle to yujinli_Fx3_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yujinli_Fx3_input as text
%        str2double(get(hObject,'String')) returns contents of yujinli_Fx3_input as a double


% --- Executes during object creation, after setting all properties.
function yujinli_Fx3_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yujinli_Fx3_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','500');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function draw3_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to draw3_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in draw4_pushbutton.
function draw4_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to draw4_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 yujinli_Fx4=str2double(get(handles.yujinli_Fx4_input,'string'));
 yujinli_Fy4=eval(get(handles.yujinli_Fy4_input,'string'));
 Speed4=eval(get(handles.Speed4_input,'string'));
  hmb4=msgbox('正在计算并绘图请耐心等待...','消息提示框');
 global N1  zhouchengxinghao1
global  test iter
format long
BF = zhouchengxinghao1;iter = zeros(1,6);
feps = 1e-6;maxit = 200;
b=-1;N = N1;k = (1:N)';
phi = (b*pi/N+2*pi*k/N);
phid = (b*pi/N+2*pi*k/N)*180/pi;
i = 0;preload = zeros(5,1);
Prefy =  yujinli_Fy4;
Prefx = yujinli_Fx4;
Premz = -linspace(0,6,length(Prefy));
preload(1) = Prefx;
Speedn = Speed4;%0:5000:15000;
for Speed = Speedn    
    i = i+1;j = 0;
    for Preload = Prefy
        j = j + 1;
        preload(2) = Preload;
        preload(5) = Premz(j);
        [predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF);   
        test1 = test{1};
        test2 = test1{2};
        Ko(i,j) = test2(1,1)*(1e-6)^1.5;  % 接触系数N/um^1.5
        Ki(i,j) = test2(1,2)*(1e-6)^1.5;
        U = test2(1,3);
        V = test2(1,4);
        Ui = test2(1,5);
        Vi = test2(1,6);
        deltao(i,j) = test2(1,7)*1e6;    % 接触变形/um
        deltai(i,j) = test2(1,8)*1e6;
        lamdao(i,j) = test2(1,9);
        lamdai(i,j) = test2(1,10);
        % 角度/度
        thetao(i,j) = test2(1,11)*180/pi;
        thetai(i,j) = test2(1,12)*180/pi;
        alpha(i,j) = test2(1,13)*180/pi;
        Mg(i,j) = test2(1,14);         % N.mm
        Fc(i,j) = test2(1,15);
        sxi(i,j) = predisplacement(1)*1e6; % /um
        Qi(i,j) = Ki(i,j).*deltai(i,j).^1.5;
        Qo(i,j) = Ko(i,j).*deltao(i,j).^1.5;
        % 刚度 / N/um
        K11(i,j) = DFiv1(1,1);  % Kx_x
        K22(i,j) = DFiv1(2,2);  % Ky_y
        K34(i,j) = DFiv1(3,4);  % Kz_ay
        K44(i,j) = DFiv1(4,4);  % Kay_ay
        K52(i,j) = DFiv1(5,2);  % Kaz_y 
    end
end

LT = {'b+-','ro-','k^-'};
Para = {Mg,Fc,Qi,Qo,thetai,thetao,K11,K22,K34,K44,K52,alpha};
Ylab = {'M_g / N.m','F_c / N','Q_i / N','Q_o /N','\alpha_i / \circ','\alpha_o / \circ','K_{xx} / N/m',...
        'K_{yy} / N/m','K_{z\theta_y} / N/rad','K_{\theta_y\theta_y} / N.m/rad','K_{\theta_zy} / N.m/m','\beta / \circ',};
title_all={'陀螺力矩随径向力Fy的变化','离心力随径向力Fy的变化','内圈接触力随径向力Fy的变化','外圈接触力随径向力Fy的变化','内圈接触角随径向力Fy的变化',...
               '外圈接触角随径向力Fy的变化','轴向刚度随径向力Fy的变化','径向刚度随径向力Fy的变化','由Y向位移引起的Z向刚度随径向力Fy的变化',...
               'Y向角刚度随径向力Fy的变化','Y向刚度引起的Z向角位移随径向力Fy的变化','接触角随径向力Fy的变化',};
 xlim = 500;hx = 0.45; hy = 0.38;xh = 0.1;yh = xh;
figure('units','normalized','position',[xh,yh,hx,hy],'NumberTitle','off','Name','不同参数随径向力Fy的变化');
row = 6;clumn = 2; 
for kk =1   
    for i = 1:row
        for j = 1:clumn
            k = (i-1)*clumn+j;
            subplot(row,clumn,k);
            plot(Prefy,Para{(kk-1)*row*clumn+k}(1,:),LT{1},Prefy,Para{(kk-1)*row*clumn+k}(2,:),LT{2},Prefy,Para{(kk-1)*row*clumn+k}(3,:),LT{3})%,Speed,Mg(2,:),'x-',Speed,Mg(3,:),'.-');
            ylabel(Ylab{(kk-1)*row*clumn+k});
            title(title_all{(kk-1)*row*clumn+k});
            set(gca,'Xlim',[00 900]);
            h = legend('n=0','n=4000r/min','n=8000r/min',1);
            set(h,'box','off');3
            xlabel('Fy / N');
        end
    end
end
close(hmb4)



function Speed4_input_Callback(hObject, eventdata, handles)
% hObject    handle to Speed4_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Speed4_input as text
%        str2double(get(hObject,'String')) returns contents of Speed4_input as a double


% --- Executes during object creation, after setting all properties.
function Speed4_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Speed4_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','0:4000:8000');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yujinli_Fy4_input_Callback(hObject, eventdata, handles)
% hObject    handle to yujinli_Fy4_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yujinli_Fy4_input as text
%        str2double(get(hObject,'String')) returns contents of yujinli_Fy4_input as a double


% --- Executes during object creation, after setting all properties.
function yujinli_Fy4_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yujinli_Fy4_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','0:50:300');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yujinli_Fx4_input_Callback(hObject, eventdata, handles)
% hObject    handle to yujinli_Fx4_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yujinli_Fx4_input as text
%        str2double(get(hObject,'String')) returns contents of yujinli_Fx4_input as a double


% --- Executes during object creation, after setting all properties.
function yujinli_Fx4_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yujinli_Fx4_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'String','300');
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
close(gcf)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcbo,'value',0,'Min',1,'Max',12);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
