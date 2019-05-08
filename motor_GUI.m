function varargout = motor_GUI(varargin)
% MOTOR_GUI MATLAB code for motor_GUI.fig
%      MOTOR_GUI, by itself, creates a new MOTOR_GUI or raises the existing
%      singleton*.
%
%      H = MOTOR_GUI returns the handle to a new MOTOR_GUI or the handle to
%      the existing singleton*.
%
%      MOTOR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOTOR_GUI.M with the given input arguments.
%
%      MOTOR_GUI('Property','Value',...) creates a new MOTOR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before motor_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to motor_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help motor_GUI

% Last Modified by GUIDE v2.5 07-May-2019 09:32:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @motor_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @motor_GUI_OutputFcn, ...
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


% --- Executes just before motor_GUI is made visible.
function motor_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to motor_GUI (see VARARGIN)

% Choose default command line output for motor_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes motor_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%establish connection with the arduino board
global a;
a=arduino('com3','uno');
global step_size;
step_size=1.8;
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D2',0);
writeDigitalPin(a,'D9',1);

%display live video captured by the camera
%axes(handles.axes1);
%axes(handles.axes2);
global cam;
delete(cam);
cam=webcam('Webcam C170');

hImage=image(zeros(1024/2,768,3),'Parent',handles.axes1);
preview(cam,hImage);

global angle;
angle=0;
compass(handles.axes2,cos(pi/180*angle),sin(pi/180*angle));

%%displaying external images in this GUI
myImage = imread('clock_wise.png');
set(handles.axes3,'Units','pixels');
resizePos = get(handles.axes3,'Position');
myImage= imresize(myImage, [resizePos(3) resizePos(3)]);
axes(handles.axes3);
imshow(myImage);
set(handles.axes3,'Units','normalized');

myImage = imread('counter_clock_wise.png');
set(handles.axes4,'Units','pixels');
resizePos = get(handles.axes4,'Position');
myImage= imresize(myImage, [resizePos(3) resizePos(3)]);
axes(handles.axes4);
imshow(myImage);
set(handles.axes4,'Units','normalized');




% --- Outputs from this function are returned to the command line.
function varargout = motor_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in CW_oneStep.
function CW_oneStep_Callback(hObject, eventdata, handles)
% hObject    handle to CW_oneStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a,
global step_size;
writeDigitalPin(a,'D2',1),
writeDigitalPin(a,'D3',1),
pause(0.001),
writeDigitalPin(a,'D3',0),
global angle;
angle=angle-step_size;
compass(handles.axes2,cos(pi/180*angle),sin(pi/180*angle));

% --- Executes on button press in ACW_one_step.
function ACW_one_step_Callback(hObject, eventdata, handles)
% hObject    handle to ACW_one_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a,
writeDigitalPin(a,'D2',0),
writeDigitalPin(a,'D3',1),
pause(0.001),
writeDigitalPin(a,'D3',0),
global angle;
angle=angle+step_size;
compass(handles.axes2,cos(pi/180*angle),sin(pi/180*angle));



function Angle_ACW_Callback(hObject, eventdata, handles)
% hObject    handle to Angle_ACW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Angle_ACW as text
%        str2double(get(hObject,'String')) returns contents of Angle_ACW as a double


% --- Executes during object creation, after setting all properties.
function Angle_ACW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Angle_ACW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Turn_Customised_Angle_ACW.
function Turn_Customised_Angle_ACW_Callback(hObject, eventdata, handles)
% hObject    handle to Turn_Customised_Angle_ACW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Extracted_Angle_ACW=get(handles.Angle_ACW,'string');
Angle_ACW_in_double=str2double(Extracted_Angle_ACW);
global step_size,
x=Angle_ACW_in_double/step_size;
global a,
writeDigitalPin(a,'D2',0);
global angle;
for i=1:x
    %global a,
    writeDigitalPin(a,'D3',1);
    pause(0.001);
    writeDigitalPin(a,'D3',0);
    %pause(0.001);
    %4.56s per 360 degrees
    angle=angle+step_size;
end
compass(handles.axes2,cos(pi/180*angle),sin(pi/180*angle));



function Angle_CW_Callback(hObject, eventdata, handles)
% hObject    handle to Angle_CW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Angle_CW as text
%        str2double(get(hObject,'String')) returns contents of Angle_CW as a double


% --- Executes during object creation, after setting all properties.
function Angle_CW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Angle_CW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Turn_Customised_Angle_CW.
function Turn_Customised_Angle_CW_Callback(hObject, eventdata, handles)
% hObject    handle to Turn_Customised_Angle_CW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Extracted_Angle_CW=get(handles.Angle_CW,'string');
Angle_CW_in_double=str2double(Extracted_Angle_CW);
global step_size,
x=Angle_CW_in_double/step_size;
global a,
writeDigitalPin(a,'D2',1);
global angle;

for i=1:x
    
    %writeDigitalPin(a,'D2',1);
    writeDigitalPin(a,'D3',1);
    pause(0.001);
    writeDigitalPin(a,'D3',0);
    %pause(0.001);
    angle=angle-step_size;
    
end
compass(handles.axes2,cos(pi/180*angle),sin(pi/180*angle));

% --- Executes on selection change in StepSize.
function StepSize_Callback(hObject, eventdata, handles)
% hObject    handle to StepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns StepSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from StepSize


% --- Executes during object creation, after setting all properties.
function StepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Update_Step_Size.
function Update_Step_Size_Callback(hObject, eventdata, handles)
% hObject    handle to Update_Step_Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global step_size,
step_size=get(handles.StepSize,'value');
step_size=1.8*0.5^(step_size-1);
global a,
if step_size==1.8
    writeDigitalPin(a,'D6',0);
    writeDigitalPin(a,'D7',0);
    writeDigitalPin(a,'D8',0);
elseif step_size==0.9
    writeDigitalPin(a,'D6',1);
    writeDigitalPin(a,'D7',0);
    writeDigitalPin(a,'D8',0);
elseif step_size==0.45
    writeDigitalPin(a,'D6',0);
    writeDigitalPin(a,'D7',1);
    writeDigitalPin(a,'D8',0);
elseif step_size==0.225
    writeDigitalPin(a,'D6',1);
    writeDigitalPin(a,'D7',1);
    writeDigitalPin(a,'D8',0);
elseif step_size==0.1125
    writeDigitalPin(a,'D6',1);
    writeDigitalPin(a,'D7',1);
    writeDigitalPin(a,'D8',1);
end
set(handles.step_size_dis,'String',num2str(step_size));


% --- Executes on button press in take_photo.
function take_photo_Callback(hObject, eventdata, handles)
% hObject    handle to take_photo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%global vid;
%delete(vid);
global cam;
figure('Name','Image from webcam');
imshow(snapshot(cam));

%vid=videoinput('winvideo',1);
%hImage=image(zeros(1024,768,3),'Parent',handles.axes1);
%preview(vid,hImage);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global step_size,
global angle,

if angle<0
    angle=-mod(abs(angle),360);
else
    angle=mod(angle,360);
end

x=abs(angle)/step_size;
global a,
if angle<0
    writeDigitalPin(a,'D2',0);
    for i=1:x
    writeDigitalPin(a,'D3',1);
    pause(0.001);
    writeDigitalPin(a,'D3',0);
    %pause(0.001);
    %4.56s per 360 degrees
    angle=angle+step_size;
    end
elseif angle>0
    writeDigitalPin(a,'D2',1);
    for i=1:x
    writeDigitalPin(a,'D3',1);
    pause(0.001);
    writeDigitalPin(a,'D3',0);
    %pause(0.001);
    %4.56s per 360 degrees
    angle=angle-step_size;
    end
end
compass(handles.axes2,cos(angle/180*pi),sin(angle/180*pi));


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
clear all;
