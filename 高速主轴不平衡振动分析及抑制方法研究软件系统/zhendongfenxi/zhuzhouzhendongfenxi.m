function varargout = zhuzhouzhendongfenxi(varargin)
% ZHUZHOUZHENDONGFENXI MATLAB code for zhuzhouzhendongfenxi.fig
%      ZHUZHOUZHENDONGFENXI, by itself, creates a new ZHUZHOUZHENDONGFENXI or raises the existing
%      singleton*.
%
%      H = ZHUZHOUZHENDONGFENXI returns the handle to a new ZHUZHOUZHENDONGFENXI or the handle to
%      the existing singleton*.
%
%      ZHUZHOUZHENDONGFENXI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZHUZHOUZHENDONGFENXI.M with the given input arguments.
%
%      ZHUZHOUZHENDONGFENXI('Property','Value',...) creates a new ZHUZHOUZHENDONGFENXI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before zhuzhouzhendongfenxi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to zhuzhouzhendongfenxi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help zhuzhouzhendongfenxi

% Last Modified by GUIDE v2.5 05-May-2017 17:43:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @zhuzhouzhendongfenxi_OpeningFcn, ...
                   'gui_OutputFcn',  @zhuzhouzhendongfenxi_OutputFcn, ...
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


% --- Executes just before zhuzhouzhendongfenxi is made visible.
function zhuzhouzhendongfenxi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to zhuzhouzhendongfenxi (see VARARGIN)
pho=str2double(get(handles.zhuanzizhouchengdensity_input,'string'));
E=str2double(get(handles.Yangshimoliang_input,'string'));
mju=str2double(get(handles.bosongbi_input,'string'));
ks=str2double(get(handles.Ks_input,'string'));
Disk_Node_Number=eval(get(handles.yuanpanjiedianshu_input,'string'));
Ld=eval(get(handles.yuanpanhoudu_input,'string'));
Ddo=eval(get(handles.yuanpanwaijing_input,'string'));
Ddi=eval(get(handles.yuanpanneijing_input,'string'));
ed=eval(get(handles.yuanpanpianxinliang_input,'string'));
phid=eval(get(handles.chushipianxinjiaodu_input,'string'));
rhod=str2double(get(handles.butongyuanpanmidu_input,'string'));
m=str2double(get(handles.Y_bupinghengzhiliang_input,'string'));
e=str2double(get(handles.Y_pianxinliang_input,'string'));
phi0=str2num(get(handles.Y_pianxinjiaodu_input,'string'));
Speed=str2double(get(handles.Speed_input,'string'));
preload=eval(get(handles.yujinli_input,'string'));
Bearing_number=eval(get(handles.zhouchengjiedianbianhao_input,'string'));

handles.pho=pho;
handles.E=E;
handles.mju=mju;
handles.ks=ks;
handles.Disk_Node_Number=Disk_Node_Number;
handles.Ld=Ld;
handles.Ddo=Ddo;
handles.Ddi=Ddi;
handles.ed=ed;
handles.phid=phid;
handles.rhod=rhod;
handles.m=m;
handles.e=e;
handles.phi0=phi0;
handles.Speed=Speed;
handles.preload=preload;
handles.Bearing_number=Bearing_number;


% Choose default command line output for zhuzhouzhendongfenxi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes zhuzhouzhendongfenxi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = zhuzhouzhendongfenxi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in liangchangzairu_pushbutton.
function liangchangzairu_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to liangchangzairu_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Lb=[8 8 8 7 10.9515 10.9515 13.5485 13.5485 7.5 7 7 7 7 7 8 8 6.5236 1.4764 7.5 7.5 13.5 12.501 5 5 5 14.65 14.65 14.65 14.65 14.65 14.65 14.65 14.65 14.65 ...
  14.65 8 9.9 9.9 9.9 9.9 9.9 7.5 7.5 1.4764 6.5236 8 11.6 11.6 11.6 7.5 13.5485 13.5485 10.9515 10.9515 7 8 8 8]*1e-3;
handles.Lb=Lb;

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in waijingzairu_pushbutton.
function waijingzairu_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to waijingzairu_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dbo=[37 37 32 32 20 20 20 20 32 23 23 23 23 23 38 38 31.5 31.5 25 25 31.5 35 36 36 36 30 30 30 30 30 30 30 30 30 30 37 31.5 31.5 31.5 31.5 31.5 25 25 38 38 ...
    38 23 23 23 32 20 20 20 20 32 32 37 37]*1e-3;
handles.Dbo=Dbo;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in neijingzairu_pushbutton.
function neijingzairu_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to neijingzairu_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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



function yuanpanjiedianshu_input_Callback(hObject, eventdata, handles)
% hObject    handle to yuanpanjiedianshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yuanpanjiedianshu_input as text
%        str2double(get(hObject,'String')) returns contents of yuanpanjiedianshu_input as a double


% --- Executes during object creation, after setting all properties.
function yuanpanjiedianshu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yuanpanjiedianshu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[6 8 24 52 54]');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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
set(gcbo,'string','[21.903 27.097 10 27.097 21.903]*1e-3');
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
set(gcbo,'string','[90 90 65 90 90]*1e-3');
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
set(gcbo,'string','[20 20 36 20 20]*1e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yuanpanpianxinliang_input_Callback(hObject, eventdata, handles)
% hObject    handle to yuanpanpianxinliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yuanpanpianxinliang_input as text
%        str2double(get(hObject,'String')) returns contents of yuanpanpianxinliang_input as a double


% --- Executes during object creation, after setting all properties.
function yuanpanpianxinliang_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yuanpanpianxinliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[0 0 0 0 0]*1e-3');
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
set(gcbo,'string','[0 0 0 0 0]*1e-3');
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



function Y_bupinghengzhiliang_input_Callback(hObject, eventdata, handles)
% hObject    handle to Y_bupinghengzhiliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_bupinghengzhiliang_input as text
%        str2double(get(hObject,'String')) returns contents of Y_bupinghengzhiliang_input as a double


% --- Executes during object creation, after setting all properties.
function Y_bupinghengzhiliang_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_bupinghengzhiliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','1e-2');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_pianxinliang_input_Callback(hObject, eventdata, handles)
% hObject    handle to Y_pianxinliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_pianxinliang_input as text
%        str2double(get(hObject,'String')) returns contents of Y_pianxinliang_input as a double


% --- Executes during object creation, after setting all properties.
function Y_pianxinliang_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_pianxinliang_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','1e-3');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Speed_input_Callback(hObject, eventdata, handles)
% hObject    handle to Speed_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Speed_input as text
%        str2double(get(hObject,'String')) returns contents of Speed_input as a double


% --- Executes during object creation, after setting all properties.
function Speed_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Speed_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','8000');
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



function zhouchengjiedianbianhao_input_Callback(hObject, eventdata, handles)
% hObject    handle to zhouchengjiedianbianhao_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zhouchengjiedianbianhao_input as text
%        str2double(get(hObject,'String')) returns contents of zhouchengjiedianbianhao_input as a double


% --- Executes during object creation, after setting all properties.
function zhouchengjiedianbianhao_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhouchengjiedianbianhao_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','[18 45]');
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_pianxinjiaodu_input_Callback(hObject, eventdata, handles)
% hObject    handle to Y_pianxinjiaodu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_pianxinjiaodu_input as text
%        str2double(get(hObject,'String')) returns contents of Y_pianxinjiaodu_input as a double


% --- Executes during object creation, after setting all properties.
function Y_pianxinjiaodu_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_pianxinjiaodu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'string','0');
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
global qx qy qz my mz n Nof Omega t 
% Lb=[8 8 8 7 10.9515 10.9515 13.5485 13.5485 7.5 7 7 7 7 7 8 8 6.5236 1.4764 7.5 7.5 13.5 12.501 5 5 5 14.65 14.65 14.65 14.65 14.65 14.65 14.65 14.65 14.65 ...
%   14.65 8 9.9 9.9 9.9 9.9 9.9 7.5 7.5 1.4764 6.5236 8 11.6 11.6 11.6 7.5 13.5485 13.5485 10.9515 10.9515 7 8 8 8]*1e-3;
Lb=handles.Lb;
% Dbo=[37 37 32 32 20 20 20 20 32 23 23 23 23 23 38 38 31.5 31.5 25 25 31.5 35 36 36 36 30 30 30 30 30 30 30 30 30 30 37 31.5 31.5 31.5 31.5 31.5 25 25 38 38 ...
%     38 23 23 23 32 20 20 20 20 32 32 37 37]*1e-3;

global pho E mju ks rhod 
Dbo=handles.Dbo;
Dbi = zeros(1,length(Lb));
pho=handles.pho;
E=handles.E;
mju=handles.mju;
ks=handles.ks;
Disk_Node_Number=handles.Disk_Node_Number;
Ld=handles.Ld;
Ddo=handles.Ddo;
Ddi=handles.Ddi;
ed=handles.ed;
phid=handles.phid;
rhod=handles.rhod;
m=handles.m;
e=handles.e;
phi0=handles.phi0;
Speed=handles.Speed;
preload=handles.preload;
Bearing_number=handles.Bearing_number;

%% Disk Data of Finite element
% Disk_Node_Number=[6 8 24 52 54];
% Ld =[21.903 27.097 10 27.097 21.903]*1e-3;
% Ddo=[90 90 65 90 90]*1e-3;
% Ddi=[20 20 36 20 20]*1e-3;
%%
% Speed = 8000;
Omega = Speed*2*pi/60;
qx = 0;           %%-------------------------------- 
qy = 0;           %%-------------------------------- 
qz = 0;           %%-------------------------------- 
my = 0;           %%-------------------------------- 
mz = 0;           %%-------------------------------- 

L  = Lb; 
Do = Dbo;
Di = Dbi;
n  = length(L);         % 梁单元数
Nof = 5*(n+1);
sn = 1e-3*ones(Nof,1);  % 节点位移
CS = zeros(Nof);        % 结构阻尼
% Parameters for Disk 
a = Ddi/2;
b = Ddo/2;
% ed =[0 0 0 0 0]*1e-3;
% phid = [0 0 0 0 0]*1e-3;
Nelement_of_Disk = Disk_Node_Number;

%% Bearing node number
% Bearing_Node_Number = [4 5 6 7 17 18 19 20 21 22];
global Bearing_Node_Number  iter
% Bearing_number = [18 45];
% Bearing_number = [20 43];
Bearing_Node_Number = Bearing_number;
 % 定压预紧
% prep = [0 0 1 1 1];
prep = [1 0];
% 定位预紧
% pred = [0 0 0 0 0];
pred = [0 0];
BF = 1;iter = zeros(1,6);
feps = 1e-7;maxit = 200;
%%
% preload = [200;0e2;0e2;0e2;0e2];
[predisplacement,Fiv1,DFiv1,iteri,flagi] = Bearing_of_Stiffness(preload,Speed,feps,maxit,BF);KB1 = DFiv1; 
t = 0;
x0 = zeros(Nof,1);
[MD,GD,FD] = Finite_of_Disk(a,b,Ld,ed,phid,Nelement_of_Disk,Nof);
P=0;
[MB,MC,KB,KBP,GB,FB] = Finite_of_Beam2(L,Do,Di,P,x0);
KBT = zeros(Nof);
KB10 = zeros(5);
S0 = 1;
S1 = 1;
S2 = 1;
KB10 = KB1;KB10(1)=KB1(1)*S0*1e3;
KB10(2,5)=KB1(2,5)*S1*1e0;KB10(5,2)=KB10(2,5); KB10(3,4)=KB1(3,4)*S1*1e0;KB10(4,3)=KB10(3,4);
KB10(4:5,4:5)=KB1(4:5,4:5)*S2*1e0;
KB10(4:5,:)=0;KB10(:,4:5)=0;  %% 与ANSYS保持一致性 ，若不保迟则注释掉
KBT = BearingStiffnessAssemble5(KBT,KB10,Bearing_Node_Number(1));
KBT = BearingStiffnessAssemble5(KBT,KB10,Bearing_Node_Number(2));
%%
K = KB + KBP + KBT - Omega^2 * MC; 
M = MB + MD;    
%% 求振型
[Ph,V] = eig(K,M);
[V,ki] = sort(diag(V));
Ph = Ph(:,ki);
VV = diag(sqrt(V));
Mi = Ph.'*M*Ph;mi = diag(Mi);
ksi = 1.5E-4 ;%   1E-4---6E-4结构阻尼
CS = 2*ksi*VV*Mi ; %  系统结构阻尼矩阵

freq=sqrt(V)/2/pi;
vpa(freq(1:30),5) % 输出前30阶固有频率

%%
% f1 = 178Hz;f2 = 204Hz;
% m = 1e-2;e= 1e-3;
node = 1;
% Speed = 8000;
Omega = Speed*2*pi/60;
w = Omega
fw = Speed/60;
phi = 0;phi =45*pi/180;
C = CS - GB*Omega - GD*Omega;
% C=0;
nt =100;
dt = 2*pi/w/10;
dt = 1/Speed*60/20;
f0 = m*e*w^2;
time = (0:nt-1)'*dt;
[nm,~] = size(M);

global f;
% phi0 = 0;
f = zeros(nm,nt);
f(5*node-3,:)=f0*cos(w*time+phi0);  % 节点node上施加正弦激励
f(5*node-2,:)=f0*sin(w*time+phi0); 
h = dt;
% 原始不平衡激励力Fe等效为Fy1和Fz1
Fe = (f(5*node-3,:).^2 + f(5*node-3,:).^2).^0.5; % 原始不平衡激励力 Fe
Fe = f0*exp(1i*(w*time+phi0));
Fy1 = f(5*node-3,:);  % 等效激励力Fy1
Fz1 = f(5*node-2,:);  % Fz1 
xlim = 500;hx = 0.45; hy = 0.4;xh = 0.1;yh = xh;
figure('units','normalized','position',[xh,yh,hx,hy])   
plot(time,Fy1,'r-',time,Fz1,'bx-');xlabel('t/ s');ylabel('等效不平衡激励力 / N ');set(gca,'Xlim',[0 0.045]);
set(gca,'Ylim',1.05*[min(Fy1) max(Fy1)]);
hh=legend('F_{eY}','F_{eZ}',1);set(hh,'box','off');

%% 主轴不同位置响应
% Node number + X direction 表示 Node的X向自由度位移、速度、加速度响应 
[d,v,a] = ResponseNewmark(M,K,C,nt,dt);
LT = {'bs-','gp-','b-.','k.--','r+-','c:','m-','b.-'};
legd = {{'X_1','X_7','X_{18}','X_{24}','X_{33}','X_{45}','X_{53}','X_{59}'};
       {'Y_1','Y_7','Y_{18}','Y_{24}','Y_{33}','Y_{45}','Y_{53}','Y_{59}'};
       {'Z_1','Z_7','Z_{18}','Z_{24}','Z_{33}','Z_{45}','Z_{53}','Z_{59}'};
       {'\theta_{y1}','\theta_{y7}','\theta_{y18}','\theta_{y24}','\theta_{y33}','\theta_{y45}','\theta_{y53}','\theta_{y59}'};
       {'\theta_{z1}','\theta_{z7}','\theta_{z18}','\theta_{z24}','\theta_{z33}','\theta_{z45}','\theta_{z53}','\theta_{z59}'};
       };
legv = {{'v_{x1}','v_{x7}','v_{x18}','v_{x24}','v_{x33}','v_{x45}','v_{x53}','v_{x59}'};
        {'v_{y1}','v_{y7}','v_{y18}','v_{y24}','v_{y33}','v_{y45}','v_{y53}','v_{y59}'};
        {'v_{z1}','v_{z7}','v_{z18}','v_{z24}','v_{z33}','v_{z45}','v_{z53}','v_{z59}'};
        {'\omega_{y1}','\omega_{y7}','\omega_{y18}','\omega_{y24}','\omega_{y33}','\omega_{y45}','\omega_{y53}','\omega_{y59}'};
        {'\omega_{z1}','\omega_{z7}','\omega_{z18}','\omega_{z24}','\omega_{z33}','\omega_{z45}','\omega_{z53}','\omega_{z59}'};
       };
lega = {{'a_{x1}','a_{x7}','a_{x18}','a_{x24}','a_{x33}','a_{x45}','a_{x53}','a_{x59}'};
       {'a_{y1}','a_{y7}','a_{y18}','a_{y24}','a_{y33}','a_{y45}','a_{y53}','a_{y59}'};
       {'a_{z1}','a_{z7}','a_{z18}','a_{z24}','a_{z33}','a_{z45}','a_{z53}','a_{z59}'};
       {'\alpha_{y1}','\alpha_{y7}','\alpha_{y18}','\alpha_{y24}','\alpha_{y33}','\alpha_{y45}','\alpha_{y53}','\alpha_{y59}'};
       {'\alpha_{z1}','\alpha_{z7}','\alpha_{z18}','\alpha_{z24}','\alpha_{z33}','\alpha_{z45}','\alpha_{z53}','\alpha_{z59}'};
       }; 
leg = {legd;legv;lega};
Ylab = {{'位移X / \mum','位移Y / \mum','位移Z / \mum','位移\theta_y / \circ','位移\theta_z / \circ'};
        {'速度v_x / \mum/s','速度v_y / \mum/s','速度v_z / \mum/s','角速度\omega_y / \circ/s','角速度\omega_z / \circ/s'}
        {'加速度a_x / \mum/s^2','加速度a_y / \mum/s^2','加速度a_z / \mum/s^2','角加速度\alpha_y / \circ/s^2','角加速度\alpha_z / \circ/s^2'}
        }; 
dva = {d,v,a};
node = [1 7 18 24 33 45 53 59];
% Speed = 8000;m = 1e-2kg,e = 1e-3mm ,nt = 500;
% Disk_Node_Number=[6 8 24 52 54]; Bearing_number = [18 45]; N = n +1 = 59
% 测点位置: 轴承位置18、45，编码器位置24 ,配重盘位置7，53，前端1，后端59，中间位置33
LT = {'b-','k--','b-','r.-','r.-','b-','k--','b-'};
% LT = {'k-','k--','k-','k.-','k.-','k-','k--','k-'};
LW = [2 2 1 1 1 1 2 2];
LT = {'b-','k--','b-','r-.','r-.','b-','k--','b-'};
LW = [2 2 1 0.5 0.5 1 2 2];
Unit = [1e6 1e6 1e6 180/pi 180/pi];
% Node = [1 7 18];
Node =node;
xlim = 500;hx = 0.45; hy = 0.4;xh = 0.1;yh = xh;
close all
for i= 1:5   
    figure('units','normalized','position',[xh,yh,hx,hy]) 
    q=1;
    for k = 1:3
        
        for jj = 1:length(Node)
            j = find(Node(jj)==node);
            if j==1
                min1 = 0;max1 = 0;
                subplot(6,1,q);
            end
            if j==5
                subplot(6,1,q+1);
                min1 = 0;max1 = 0;
            end
            dvap = real(dva{k}(5*(node(j)-1)+i,:))*Unit(i);
            plot(time,dvap,LT{j},'LineWidth',LW(j));
            min1 = min([dvap,min1]);max1 = max([dvap,max1]) ;
            hold on;
            if j==4|j==8
                h = legend(leg{k}{i}(j-3:j),0);
                set(h,'box','off');
                xlabel('t / s');ylabel(Ylab{k}(i));set(gca,'Xlim',[0 0.045]);set(gca,'Ylim',1.02*[min1 max1]);
                hold off;
            end
        end
        q=q+2;
    end
end


% --- Executes during object creation, after setting all properties.
function liangchangzairu_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to liangchangzairu_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function waijingzairu_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waijingzairu_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
