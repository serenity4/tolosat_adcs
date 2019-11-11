% PILIA simulator App: main functions

function PILIA_simulator

% The application is designed to offer the user an easy interactive way 
% to create a simulator, run it and post-process data. Four application 
% windows follow the logic of a simulator development.

close all

% the global variable Handle is of type structure and is used to save all 
% variables in the caller workspace for sharing the information between 
% different callback functions and build the application

global Handle;

PosBase=[10,50,730,630];
Base=figure('Position',PosBase);

%%%%%%%%%%%%%% Window 1: PILIA + CreateSim and RunSim buttons %%%%%%%%%%%%%
Handle.Win1=uipanel('Parent',Base,'Position',[0.01,0.01,0.97,0.97],'BackgroundColor',[0.45 0.5 1]);

Handle.TextPILIA=uicontrol('Style','text','Parent', Handle.Win1, 'Position', [100 530 500 40], 'String',...
    ['PILIA' ,char(169), '  Satellite ADCS Simulator'],'FontSize',20,'FontWeight','bold');

Handle.TextISAE=uicontrol('Style','text','Parent', Handle.Win1, 'Position', [100 493 500 40], 'String',...
    'ISAE - Supaero','FontSize',20);

Handle.TextISAE=uicontrol('Style','text','Parent', Handle.Win1, 'Position', [100 463 500 30], 'String',...
    'with the help of CNES supervision','FontSize',14);

%@OpenCreateSim creates and opens the second application window
Handle.CreateSimulator = uicontrol('Style','pushbutton','Parent',Handle.Win1, 'Position', [100 360 180 50], 'String', 'Create a new simulator',...
    'FontSize',12,'Callback', @OpenCreateSim);

%@OpenRunSim creates and opens the third application window
Handle.RunSimulation = uicontrol('Style','pushbutton','Parent',Handle.Win1, 'Position', [410 360 190 50], 'String', 'Run an existing simulator',...
    'FontSize',12,'Callback', @OpenRunSim);

end


%%%%%%%%%%%%%%%%%%%%%% Functions for Window 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function OpenCreateSim(~,~,~)

% the function OpenCreateSim opens the second window of the application and
% offers a number of buttons and menus to build a simulator

global Handle

Handle.FileAlreadyExists=0;

set(Handle.CreateSimulator,'Enable','off');

PosBase=[600,37,680,650];
Base2=figure('Position',PosBase);
Handle.Win2=uipanel('Parent',Base2,'Position',[0.01,0.01,0.97,0.97],'BackgroundColor',[0.8 0.5 1]);

Handle.TextWin2=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [110 560 350 35], 'String',...
    'Create your simulator','FontSize',20);

Handle.TextProjectExist=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 540 300 15], 'String',...
    'Does your project already exist?','FontSize',9);

Handle.ProjectCheckboxYes = uicontrol('Style','checkbox','Parent', Handle.Win2, 'Position',[20 520 150 20],...
    'String','Yes, choose one', 'Callback', @AddProject2Path);
Handle.ProjectCheckboxNo = uicontrol('Style','checkbox','Parent', Handle.Win2, 'Position',[170 520 150 20],...
    'String','No. Create new', 'Callback', @AddProject2Path);

Handle.TextProjectName=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 500 410 15], 'String',...
    'Please, enter the name of your new project','FontSize',9,'Visible','off');

Handle.ProjectName = uicontrol('Style','edit','Parent', Handle.Win2, 'Position',[20 480 240 20],...
    'Callback','uiresume(gcbf)','Visible','off');

Handle.TextFileName=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 460 410 15], 'String',...
    'Please, enter the name of your new simulator (without the file extension)','FontSize',9);

Handle.FileName = uicontrol('Style','edit','Parent', Handle.Win2, 'Position',[20 440 240 20],'Callback',@CreateDir);

Handle.Text7=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 410 220 15], 'String',...
    'Choose the orbit model','FontSize',8);

Handle.OrbitModelList=uicontrol('Style','popupmenu','Parent',Handle.Win2,'Position',[20 390 150 20],...
    'String', {'Keplerian','J2 J3 J4'});

Handle.Text3=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 360 200 15], 'String',...
    'Choose the Sun Ephemeris model','FontSize',8);

Handle.SunList=uicontrol('Style','popupmenu','Parent',Handle.Win2,'Position',[20 340 100 20],...
    'String',{'Accurate','Simple','None'});

Handle.Text4=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [270 360 220 15], 'String',...
    'Choose the Earth''s magnetic field model','FontSize',8);

Handle.MagnList=uicontrol('Style','popupmenu','Parent',Handle.Win2,'Position',[270 340 100 20],...
    'String',{'IGRF2015','Dipole','None'});

Handle.Text2=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 300 330 15], 'String',...
    'Choose the perturbation torques you want in the simulation','FontSize',8);

Handle.PertTorqueList=uicontrol('Style','listbox','max',100,'min',0,'Parent',Handle.Win2,'Position',[20 230 150 70],...
    'String', {'Aerodynamic Torque','Gravidy Gradient torque','Magnetic Torque','Sun Torque','None'});

Handle.TextMoonEphemeris = uicontrol('Style','text','Parent', Handle.Win2, 'Position', [200 260 200 15], 'String',...
    'Do you need the Moon Ephemeris block?','FontSize',8);

Handle.MoonEphemChoice=uicontrol('Style','popupmenu','Parent',Handle.Win2,'Position',[200 240 50 20],...
    'String', {'Yes','No'});

Handle.Text5=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [300 190 220 15], 'String',...
    'Choose the actuators','FontSize',8);

Handle.ActuatorList=uicontrol('Style','listbox','max',100,'min',0,'Parent',Handle.Win2,'Position',[300 140 150 50],...
    'String', {'Magnetorquers','Reaction Wheels','None'});

Handle.Continue = uicontrol('Style','pushbutton','Parent',Handle.Win2, 'Position', [500 140 70 25],...
    'String', 'Continue', 'FontSize',10,'Callback',@ShowSecondPart);

Handle.Text9=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 190 220 15], 'String',...
        'Choose the sensors','FontSize',8);

Handle.Sensors=uicontrol('Style','listbox','max',100,'min',0,'Parent',Handle.Win2,'Position',[20 140 150 50],...
        'String', {'Star Tracker','Magnetometer','None'});
end

function AddProject2Path(~,~,~)
global Handle
if Handle.ProjectCheckboxYes.Value==1
    Handle.ProjectExists=1;
    set(Handle.ProjectCheckboxYes,'Enable','off');
    set(Handle.ProjectCheckboxNo,'Enable','off');
    set(Handle.TextProjectExist,'Enable','off');
    % if the project already exists
    try
        %find the path to the Main_GUI_PILIA function file
        StringVectorNo=which('Main_GUI_PILIA.m');
        % create a string NewCurrentDirNo containing the path to the
        % directory PROJECTS:
        FindPos=strfind(StringVectorNo,'GUI');
        % FindPos(1) is the first time 'GUI' appears in StringVector
        NewCurrentDirNo=StringVectorNo(1:FindPos(1)-1);
        NewCurrentDirNo=[NewCurrentDirNo, 'PROJECTS'];
        Handle.ChosenProjectPath=uigetdir(NewCurrentDirNo);
        evalin('base',['cd ', Handle.ChosenProjectPath]);
    catch ME
        rethrow(ME) %throw thw catched exception
    end
end

% project doesn't exist, create one:
if Handle.ProjectCheckboxNo.Value==1
    Handle.ProjectExists=0;
    set(Handle.ProjectCheckboxYes,'Enable','off');
    set(Handle.ProjectCheckboxNo,'Enable','off');
    set(Handle.TextProjectExist,'Enable','off');
    set(Handle.TextProjectName,'Visible','on');
    set(Handle.ProjectName,'Visible','on');
    try
    %%%%%%%%%%%%%%%%%
    %find the path to the Main_GUI_PILIA function file
    StringVector=which('Main_GUI_PILIA.m');
    % create a string Handle.NewCurrentDir containing the path to the directory
    % PROJECTS:
    FindPos=strfind(StringVector,'GUI');
    % FindPos(1) is the first time 'GUI' appears in StringVector
    Handle.NewCurrentDir=StringVector(1:FindPos(1)-1);
    Handle.NewCurrentDir=[Handle.NewCurrentDir, 'PROJECTS'];
    % make PROJECTS the current directory:
    evalin('base',['cd ', Handle.NewCurrentDir]);
    % create a new directory (new project) with the name chosen by the
    % user:
    uiwait(gcf);
    evalin('base',['mkdir ', Handle.ProjectName.String]);
    % update the Handle.NewCurrentDir with the new directory added to it:
    Handle.NewCurrentDir=[Handle.NewCurrentDir, filesep, Handle.ProjectName.String];
    set(Handle.ProjectName,'Enable','off');
    % add the new directory to path:
    evalin('base',['addpath ', Handle.NewCurrentDir]);
    % go to the new directory
    evalin('base',['cd ', Handle.NewCurrentDir]);
    %%%%%%%%%%%%%%%%%%% 
    catch ME
    if strcmp(ME.identifier,'MATLAB:minrhs')
       errordlg('You did not give your new project a name. Please, fix that','Choices Error');
       set(Handle.ProjectName,'Enable','on');
    end
    rethrow(ME) %throw the catched exception
    end
end
end

function CreateDir(~,~,~)
global Handle
if Handle.FileAlreadyExists==0
    evalin('base',['mkdir ', Handle.FileName.String]);
else
    evalin('base','cd ..');
    evalin('base',['mkdir ', Handle.FileName.String]);
end
if Handle.ProjectCheckboxNo.Value==1
    Handle.FinalDir=[Handle.NewCurrentDir, filesep, Handle.FileName.String];
elseif Handle.ProjectCheckboxYes.Value==1
    Handle.FinalDir=[Handle.ChosenProjectPath, filesep, Handle.FileName.String];
end
evalin('base',['addpath ', Handle.FinalDir]);
% go to the new directory
evalin('base',['cd ', Handle.FinalDir]);
end

function ShowSecondPart(~,~,~)

% This function deals with different errors that may appear due to the wrong
% choice made by the user; if no errors are made, the function makes the
% next buttons appear (choosing the control laws)

global Handle
err=0; MagnErr=0; SunErr=0; ActErr=0; SensErr=0;

% error: incoherent choice of perturbation torques and/or actuators
if (length(Handle.PertTorqueList.Value)>1 && ismember(5,Handle.PertTorqueList.Value) && err==0)
    if (length(Handle.ActuatorList.Value)>1 && ismember(3,Handle.ActuatorList.Value) && ActErr==0)
        errordlg(['The choices of perturbation torques and actuators are incoherent.',...
            ' Please, correct your choices.'],'Choices Error');
        set(Handle.PertTorqueList,'Enable','on')
        err=1; ActErr=1;
    else
        errordlg(['The choice of the perturbation torques is incoherent.',...
            ' Please, correct your choice.'],'Perturbation Torques Error');
        err=1;
        set(Handle.PertTorqueList,'Enable','on')
    end
end

% magnetic errors, all dealing with the fact that the user chose some model
% that has input from the Earth's magnetic field model while not having
% chosen the field model itself

if (ismember(3,Handle.MagnList.Value) && MagnErr==0)
    if ismember(3,Handle.PertTorqueList.Value)  
        if (ismember(1,Handle.ActuatorList.Value) && ismember(2,Handle.Sensors.Value))
            errordlg(['You chose to include the magnetic perturbation torque, a magnetorquer',...
                ' and a magnetometer but have not included the Earth"s magnetic field model.',...
                ' Please, correct your choices.'],'Choices Error');
            MagnErr=1;
            set(Handle.PertTorqueList,'Enable','on')
        elseif ismember(2,Handle.Sensors.Value)
            errordlg(['You chose to include the magnetic perturbation torque and a magnetometer',...
                ' but have not included the Earth"s magnetic field model.',...
                ' Please, correct your choices.'],'Choices Error');
            MagnErr=1;
            set(Handle.PertTorqueList,'Enable','on') 
        elseif ismember(1,Handle.ActuatorList.Value)
            errordlg(['You chose to include the magnetic perturbation torque and a magnetorquer but',...
                ' have not included the Earth"s magnetic field model.',...
                ' Please, correct your choices.'],'Choices Error');
            MagnErr=1;
            set(Handle.PertTorqueList,'Enable','on')             
        else 
            errordlg(['You chose to include the magnetic perturbation torque but have not included',...
                ' the Earth"s magnetic field model.',...
                ' Please, correct your choices.'],'Choices Error');
            MagnErr=1;
            set(Handle.PertTorqueList,'Enable','on')
        end
    elseif ismember(1,Handle.ActuatorList.Value)
        if ismember(2,Handle.Sensors.Value)
            errordlg(['You chose to include a magnetorquer and a magnetometer but have not included',...
               ' the Earth"s magnetic field model.',...
               ' Please, correct your choices.'],'Choices Error');
            MagnErr=1;          
        else        
            errordlg(['You chose to include a magnetorquer but have not included the Earth"s magnetic field model.',...
                ' Please, correct your choices.'],'Choices Error');
            MagnErr=1;
        end
    elseif ismember(2,Handle.Sensors.Value)
            errordlg(['You chose to include a magnetometer but have not included the Earth"s magnetic field model.',...
                ' Please, correct your choices.'],'Choices Error');
            MagnErr=1;          
    end
end

% sun error: incoherent choice from the menu
if (ismember(3,Handle.SunList.Value) && SunErr==0 && ismember(4,Handle.PertTorqueList.Value))   
    errordlg(['You chose to include the Sun perturbation torque but have not included the Sun ephemeris model.',...
            ' Please, correct your choices.'],'Choices Error');
    SunErr=1;
    set(Handle.PertTorqueList,'Enable','on')              
end

% actuator error: incoherent choice from the menu
if (length(Handle.ActuatorList.Value)>1 && ismember(3,Handle.ActuatorList.Value) && ActErr==0)
    errordlg(['The choice of the actuators is incoherent.',...
        ' Please, correct your choice.'],'Actuators Choice Error');
    ActErr=1;
end

% sensor error: incoherent choice from the menu
if (length(Handle.Sensors.Value)>1 && ismember(3,Handle.Sensors.Value) && SensErr==0)
   errordlg(['The choice of the sensors is incoherent.',...
        ' Please, correct your choice.'],'Sensors choice Error');
   SensErr=1;
end
% if there are no errors, the next step will appear for choosing the
% control laws:
if (err==0 && MagnErr==0 && SunErr==0 && ActErr==0 && SensErr==0 )
    set(Handle.PertTorqueList,'Enable','off')
    set(Handle.Continue,'Enable','off')
    set(Handle.ActuatorList,'Enable','off')
    set(Handle.SunList,'Enable','off')
    set(Handle.MagnList,'Enable','off')
    set(Handle.Sensors,'Enable','off')

    if (ismember(1,Handle.ActuatorList.Value) && ismember(2,Handle.ActuatorList.Value))
        Handle.Text6=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 110 220 15], 'String',...
            'Choose the MTB control law','FontSize',8);

        Handle.MTBControlLawList=uicontrol('Style','popupmenu','Parent',Handle.Win2,'Position',[20 90 150 20],...
            'String', {'Proportional','Bdot'});
        
        Handle.Text8=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [300 110 220 15], 'String',...
            'Choose the RWS control law','FontSize',8);

        Handle.RWSControlLawList=uicontrol('Style','popupmenu','Parent',Handle.Win2,'Position',[300 90 150 20],...
            'String', {'PD','PID'});

    elseif ismember(2,Handle.ActuatorList.Value)
        Handle.Text8=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [300 110 220 15], 'String',...
            'Choose the RWS control law','FontSize',8);

        Handle.RWSControlLawList=uicontrol('Style','popupmenu','Parent',Handle.Win2,'Position',[300 90 150 20],...
            'String', {'PD','PID'});
        
    elseif ismember(1,Handle.ActuatorList.Value)
        Handle.Text6=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [20 110 220 15], 'String',...
            'Choose the MTB control law','FontSize',8);

        Handle.MTBControlLawList=uicontrol('Style','popupmenu','Parent',Handle.Win2,'Position',[20 90 150 20],...
            'String', 'Bdot');
    end

    Handle.finish = uicontrol('Style','pushbutton','Parent',Handle.Win2, 'Position', [20 15 230 30],...
         'String','Press here if you have finished','FontSize',12,'Callback',@ShowCreateSim);
end
end

function ShowCreateSim(~,~,~)

% This function disables the last editable boxes and checks the possible
% error of applying a name that already exists to the Simulink model. If no
% error appears, the user can create one's simulator and it will appear in
% the Simulink window

global Handle

Handle.FileAlreadyExists=0;

set(Handle.FileName,'Enable','off')
set(Handle.MoonEphemChoice,'Enable','off')
set(Handle.OrbitModelList,'Enable','off')

if ismember(2,Handle.ActuatorList.Value)
    set(Handle.RWSControlLawList,'Enable','off')
end

if ismember(1,Handle.ActuatorList.Value)
    set(Handle.MTBControlLawList,'Enable','off')
end
    
set(Handle.finish,'Enable','off')
set(Handle.finish,'BackgroundColor',[0.94 0.94 0.94])
    
CurrentFolderStructure=dir;
CurrentFolder=struct2cell(CurrentFolderStructure);
name1=strcat(Handle.FileName.String,'.slx');
name2=strcat(Handle.FileName.String,'.mdl');
    
% checking if the file already exists:
if ismember(name1,CurrentFolder(1,:)) || ismember(name2,CurrentFolder(1,:))
    x=questdlg(['A Simulink file with this name already exists. If you continue creating your simulator, you might'...
        ' overwrite this file. Do you want to continue or change the name?'],'File already existing','Continue',...
        'Change Name','Change Name');
    if strcmp(x,'Change Name')||isempty(x)
        set(Handle.FileName,'Enable','on')
        set(Handle.finish,'Enable','on')
        Handle.FileAlreadyExists=1;
    else
        % showing the last button and calling the @CreateSim function:
        Handle.CreateSim = uicontrol('Style','pushbutton','Parent',Handle.Win2, 'Position', [400 290 250 50],...
            'FontSize',14,'String', 'Create Simulink model','Callback',@CreateSim);
    end
else
        
% showing the last button and calling the @CreateSim function:
    Handle.CreateSim = uicontrol('Style','pushbutton','Parent',Handle.Win2, 'Position', [400 290 250 50],...
        'FontSize',14,'String', 'Create Simulink model','Callback',@CreateSim);
end

end
%%%%%%%%%%%%%%%%%% Functions for Window 2 END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% Functions for Window 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function OpenRunSim(~,~,~)

% The function OpenRunSim opens the third window of PILIA and presents the
% first push button "Save to Workspace" in the window. Later, with help of
% callback functions, more buttons will appear in the window.

global Handle

% the flag is a veriable that helps to check if a button has been activated
% and enable/disable the button
Handle.PostProcFlag=0;
Handle.EditSimTimeFlag=0;

PosBase=[600,37,730,650];
Base3=figure('Position',PosBase);
set(Handle.RunSimulation, 'Enable', 'off');
Handle.Win3=uipanel('Parent',Base3,'Position',[0.01,0.01,0.97,0.97],'BackgroundColor',[0.8 0.5 1]);

Handle.TextWin3=uicontrol('Style','text','Parent', Handle.Win3, 'Position', [110 550 300 35], 'String',...
    'Run your simulator','FontSize',20);

Handle.SimFile = uicontrol('Style','pushbutton','Parent',Handle.Win3, 'Position', [20 450 260 30],...
     'String', 'Choose/Open your Simulink model','FontSize',12,'Callback', @FindSimFile);

end

function LaunchConf(~,~,~)

% This function calls the function Main_ConfLaunch in the caller workspace
% to define all the necessary parameters for a simulation and saves 
% the parameters in the base workspace

global Handle

% refresh Current Folder to see if all configuration files are in the
% Matlab path
rehash

% change directory to that of the current CONF folder
% if Handle.ProjectExists==0
%     Handle.DirectoryCONF=[Handle.NewCurrentDir, filesep, 'CONF'];
%     evalin('base', ['cd ', Handle.DirectoryCONF]);
% elseif Handle.ProjectExists==1
%     evalin('base', ['cd ', Handle.ChosenProjectPath]);
% end

Handle.DirectoryCONF=[Handle.ChosenFilePath, filesep, 'CONF'];
evalin('base', ['cd ', Handle.DirectoryCONF]);
try
    % call the Main_ConfLaunch() function and create a variable ConfParam:
    ConfParam = Main_ConfLaunch();
    
    % save the variable ConfParam into the base workspace:
    assignin('base', 'ConfParam', ConfParam)
    set(Handle.LaunchConfButton, 'ForegroundColor', [0.5 0.2 1]);
    
%     Handle.SimFile = uicontrol('Style','pushbutton','Parent',Handle.Win3, 'Position', [20 360 260 30],...
%      'String', 'Choose/Open your Simulink model','FontSize',12,'Callback', @FindSimFile);

    Handle.TextSimTime=uicontrol('Style','text','Parent', Handle.Win3, 'Position', [20 260 200 50],...
        'FontSize',12,'String', 'Enter the duration of your simulation [s]:');
    
    if Handle.EditSimTimeFlag==0
        Handle.SimTime = uicontrol('Style','edit','Parent', Handle.Win3, 'Position',[20 220 201 40],...
            'FontSize',12);
        Handle.EditSimTimeFlag=1;
    end
    
    Handle.ApplySimTime = uicontrol('Style','pushbutton','Parent',Handle.Win3, 'Position', [20 170 300 30],...
        'FontSize',12,'String', 'Apply the time duration to your simulator','Callback', @FunApplySimTime);
    
    evalin('base', ['cd ', Handle.ChosenFilePath]);
    
catch ME
    % the error in case the configuration files have not been previously
    % added to the Matlab path
    if(strcmp(ME.identifier,'MATLAB:UndefinedFunction'))
        Handle.TextErrorConfNotInPath=uicontrol('Style','text','Parent', Handle.Win3, 'Position', [320 450 330 40], 'ForegroundColor',...
            [1 0 0], 'String', ['Make sure to add all configuration files and',...
            ' the function Main_ConfLaunch.m to path and try again'],'FontSize',10);
        Handle.ErrorConfNotInPath=uicontrol('Style','checkbox','Parent', Handle.Win3, 'Position', [320 430 330 20], 'ForegroundColor',...
            [1 0 0], 'String', 'Ok','FontSize',10,'Callback',@DisableErrorConfNotInPath);
    else
        rethrow(ME)
    end
end
end

% All DisableError~ functions serve to disable the error messages that they
% are linked to
function DisableErrorConfNotInPath(~,~,~)
global Handle 
if Handle.ErrorConfNotInPath.Value==1
    set(Handle.ErrorConfNotInPath, 'Enable', 'off');
    set(Handle.TextErrorConfNotInPath, 'Enable', 'off');
end
end

function FindSimFile(~,~,~)

% This callback function finds and opens a Simulink file from a pop-up
% dialogue window

global Handle

% to make the search for a simulator easier, make the PROJECTS folder the
% current one:
%find the path to the Main_GUI_PILIA function file
StringVector=which('Main_GUI_PILIA.m');
% create a string DirectoryToProjects containing the path to the
% directory PROJECTS:
FindPos=strfind(StringVector,'GUI');
% FindPos(1) is the first time 'GUI' appears in StringVector
DirectoryToProjects=StringVector(1:FindPos(1)-1);
DirectoryToProjects=[DirectoryToProjects, 'PROJECTS'];
% make PROJECTS the current directory:
evalin('base',['cd ', DirectoryToProjects]);

% uigetfile() is the main action funciton of the FindSimFile function. It
% is a Matlab inbuilt function that allows to choose a file from the
% interface and assign a varibale to it
[Handle.ChosenFile, Handle.ChosenFilePath]=uigetfile();

% change the current directory to that of the chosen file:
evalin('base',['cd ', Handle.ChosenFilePath]);

% refresh Current Folder to see if the chosen file is in the Matlab path
rehash

FindSimErr=0;
try
    % use the inbuilt Matlab function open() to open a Simulink model
    open(Handle.ChosenFile);
catch ME
    
    % the first if-case deals with the error in case the Simulink model
    % chosen is not in path
    if strcmp(ME.identifier,'MATLAB:open:fileNotFound')
        Handle.TextErrorSimulinkNotInPath=uicontrol('Style','text','Parent', Handle.Win3, 'Position', [320 360 280 50], 'ForegroundColor',...
            [1 0 0], 'String', 'Make sure to add the Simulink model to path and try again','FontSize',14);
        Handle.ErrorSimulinkNotInPath=uicontrol('Style','checkbox','Parent', Handle.Win3, 'Position', [320 320 280 40], 'ForegroundColor',...
            [1 0 0], 'String', 'Ok','FontSize',12,'Callback',@DisableErrorSimulinkNotInPath);
        FindSimErr=1;
    % The second if-case deals with an invalid input to the open()
    % function, if the input is for example a null statement, which happens
    % if the dialogue window was closed without having chosen any file
    elseif strcmp(ME.identifier,'MATLAB:open:invalidInput')
        Handle.TextErrorOpenWindowClosed=uicontrol('Style','text','Parent', Handle.Win3, 'Position', [320 360 280 50], 'ForegroundColor',...
            [1 0 0], 'String', 'You have closed the window without choosing your Simulink model. Please try again','FontSize',9);
        Handle.ErrorOpenWindowClosed=uicontrol('Style','checkbox','Parent', Handle.Win3, 'Position', [320 320 280 40], 'ForegroundColor',...
            [1 0 0], 'String', 'Ok','FontSize',9,'Callback',@DisableErrorOpenWindowClosed);
        FindSimErr=1;
    % The rest of the error messages will appear in the Matlab Command
    % Window
    else
        rethrow(ME)
    end
end
if FindSimErr==0    
Handle.TextSaveToWorkspace=uicontrol('Style','text','Parent', Handle.Win3, 'Position', [20 370 260 40], 'String',...
    'Save the configuration parameters to Workspace for the simulation','FontSize',11);

% @LaunchConf is the callback function of the "Save to Workspace" button
% and it adds more fields to the window
Handle.LaunchConfButton = uicontrol('Style','pushbutton','Parent', Handle.Win3, 'Position', [20 340 260 30],...
     'String', 'Save to Workspace','FontSize',12,'Callback',@LaunchConf);    
end    
end

function DisableErrorSimulinkNotInPath(~,~,~)
global Handle
if Handle.ErrorSimulinkNotInPath.Value==1
    set(Handle.ErrorSimulinkNotInPath, 'Enable', 'off');
    set(Handle.TextErrorSimulinkNotInPath, 'Enable', 'off');
end
end

function DisableErrorOpenWindowClosed(~,~,~)
global Handle
if Handle.ErrorOpenWindowClosed.Value==1
    set(Handle.ErrorOpenWindowClosed, 'Enable', 'off');
    set(Handle.TextErrorOpenWindowClosed, 'Enable', 'off');
end 
end

function FunApplySimTime(~,~,~)

% This function applies the simulation time to the chosen Simulink model
% and sets up some parameters to run the simulation 

global Handle
try
    % Define a variable attached to the file chosen by the user with help
    % of Matlab inbuilt function fileparts()
    [~,Handle.ChosenFileName,~]=fileparts(Handle.ChosenFile);
    
    % set up certain parameters for the chosen Simulink model:   
    set_param(Handle.ChosenFileName,'StartTime','0');
    set_param(Handle.ChosenFileName,'StopTime',Handle.SimTime.String);
    set_param(Handle.ChosenFileName,'Solver','ode4');
    set_param(Handle.ChosenFileName,'FixedStep','ConfParam.confOrbit.dt');
    set_param(Handle.ChosenFileName,'SaveTime','off');
    set_param(Handle.ChosenFileName,'LibraryLinkDisplay','all');
    set_param(Handle.ChosenFileName,'MultiTaskRateTransMsg','warning')
    
    if Handle.PostProcFlag==0
    % calling the ShowDataProcButton() function which opens the next
    % window, the data post-processing
        ShowDataProcButton();
    end
    
catch ME
    
    % error when the user tries to push the "Apply the time duration to
    % your simulation" button before having chosen any Simulink model    
    if strcmp(ME.identifier,'MATLAB:nonExistentField') || strcmp(ME.identifier,'MATLAB:fileparts:MustBeChar')
        Handle.TextErrorSimulinkNotChosen=uicontrol('Style','text','Parent', Handle.Win3, 'Position', [330 190 320 50], 'ForegroundColor',...
            [1 0 0], 'String', 'You have not chosen a Simulink model yet. Return to that step and try again','FontSize',10);

        Handle.ErrorSimulinkNotChosen=uicontrol('Style','checkbox','Parent', Handle.Win3, 'Position', [330 160 320 30], 'ForegroundColor',...
            [1 0 0], 'String', 'Ok','FontSize',10,'Callback',@DisableErrorSimulinkNotChosen);
        set(Handle.SimFile, 'BackgroundColor', [1 0 0]);
        
    % error when no file was chosen upon opening the dialogue window
    elseif(strcmp(ME.identifier,'Simulink:Commands:InvSimulinkObjectName'))
        Handle.TextErrorSimulinkClosed=uicontrol('Style','text','Parent', Handle.Win3, 'Position', [330 190 320 50], 'ForegroundColor',...
            [1 0 0], 'String', ['You have either closed the previously chosen Simulink model or the file',...
            ' you have chosen is not a Simulink model', ' (or it is not in your Matlab path). Please try again'],...
            'FontSize',9);

        Handle.ErrorSimulinkClosed=uicontrol('Style','checkbox','Parent', Handle.Win3, 'Position', [330 160 320 30], 'ForegroundColor',...
            [1 0 0], 'String', 'Ok','FontSize',9,'Callback',@DisableErrorSimulinkClosed);   
    else
        rethrow(ME)
    end
end
end

function DisableErrorSimulinkNotChosen(~,~,~)
global Handle
if Handle.ErrorSimulinkNotChosen.Value==1
    set(Handle.ErrorSimulinkNotChosen, 'Enable', 'off');
    set(Handle.TextErrorSimulinkNotChosen, 'Enable', 'off');
    set(Handle.SimFile, 'BackgroundColor', [0.94 0.94 0.94]);
end
end

function DisableErrorSimulinkClosed(~,~,~)
global Handle
if Handle.ErrorSimulinkClosed.Value==1
    set(Handle.ErrorSimulinkClosed, 'Enable', 'off');
    set(Handle.TextErrorSimulinkClosed, 'Enable', 'off');
end
end

function ShowDataProcButton(~,~,~)

% The callback function @OpenDataProc opens the fourth window of the
% application

global Handle
Handle.RunSim = uicontrol('Style','text','Parent', Handle.Win3, 'Position', [20 120 300 30], 'String',...
    'Now you can run your simulink file','FontSize',13,'ForegroundColor','b','BackgroundColor','w');
Handle.PostTreatmentButton = uicontrol('Style','pushbutton','Parent', Handle.Win3, 'Position', [20 60 250 30],...
     'String', 'Start data post-processing','FontSize',12,'Callback',@OpenDataProc);
set(Handle.SimFile, 'BackgroundColor', [0.94 0.94 0.94]);
end
%%%%%%%%%%%%%%%%%% Functions for Window 3 END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% Functions for Window 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function OpenDataProc(~,~,~)
global Handle
% Disable the post-processing button to avoid problems with variable
% parenting:
set(Handle.PostTreatmentButton,'Enable','off');
Handle.PostProcFlag=1;

PosBase=[15,60,720,620];
Base4=figure('Position',PosBase);
Handle.Win4=uipanel('Parent',Base4,'Position',[0.01,0.01,0.97,0.97],'BackgroundColor',[0.8 0.5 1]);

Handle.TextWin4=uicontrol('Style','text','Parent', Handle.Win4, 'Position', [100 540 350 40], 'String',...
    'Data post-processing','FontSize',20);

Handle.TextPlot=uicontrol('Style','text','Parent', Handle.Win4, 'Position', [100 480 50 20], 'String', 'Plot',...
    'FontSize',12);

Handle.UpdateVariables=uicontrol('Style','pushbutton','Parent', Handle.Win4, 'Position', [100 410 200 30],...
    'String', 'Update variable list','FontSize',12,'Callback',@UpdateVars);
end

function UpdateVars(~,~,~)

% This function updates the variables of the function from those that exist
% in the base workspace. It is done to save and be able to plot the data
% saved after running a simulation.

global Handle

% use the evalin() function to evaluate the variables existing in the base
% workspace and assign them to a structure variable in the calling
% workspace
Handle.Vars = evalin('base','who');

% Erase the ConfParam variable and the eventual tout variable from the
% Handle.Vars variable not to show it for plotting options
idx = find(strcmp(Handle.Vars, 'ConfParam'));
Handle.Vars =[Handle.Vars(1:idx-1); Handle.Vars(idx+1:end)];

idx2 = find(strcmp(Handle.Vars, 'tout'));
if ~isempty(idx2)
    Handle.Vars =[Handle.Vars(1:idx2-1); Handle.Vars(idx2+1:end)];
end

if isempty(Handle.Vars)
    % if the Handle.Vars is empty upon the deletion of the ConfParam and
    % tout, it means that the user has not launched or saved any data, the
    % error then shows:     
    Handle.TextErrorNoVars=uicontrol('Style','text','Parent', Handle.Win4, 'Position', [360 365 250 100],'ForegroundColor',[1 0 0],...
        'String',['You have either not launched your simulation from the Simulink window or you have not added',...
        ' the "To Workspace" blocks in your model. Please, launch your simulation saving the variables',...
        ' you want in the Workspace.'], 'FontSize',9);

    Handle.ErrorNoVars=uicontrol('Style','checkbox','Parent', Handle.Win4, 'Position', [360 340 250 30], 'ForegroundColor',...
        [1 0 0], 'String', 'Ok','FontSize',9,'Callback',@DisableErrorNoVars);
else
    % if no error appears, the user can choose one's variable to plot
    Handle.TextXvar=uicontrol('Style','text','Parent', Handle.Win4, 'Position', [100 340 250 30],...
        'String', 'Choose a variable to plot','FontSize',12);

    Handle.Xvariables=uicontrol('Style','listbox','max',1,'min',0,'Parent', Handle.Win4, 'Position', [100 230 250 100],...
        'String', Handle.Vars,'FontSize',10);

    Handle.PlotButton=uicontrol('Style','pushbutton','Parent', Handle.Win4, 'Position', [170 180 90 30],...
        'String', 'Plot','FontSize',12,'Callback',@Plot);
end
end

function DisableErrorNoVars(~,~,~)
global Handle
if Handle.ErrorNoVars.Value==1
    set(Handle.ErrorNoVars, 'Enable', 'off');
    set(Handle.TextErrorNoVars, 'Enable', 'off');
end
end

function Plot(~,~,~)

% the plot funciton takes the chosen variable from the base workspace and
% plots it in the caller workspace

global Handle

%define the variable to plot from the user's choice 
x_value=get(Handle.Xvariables,'Value');
x_str=get(Handle.Xvariables,'String');
[x]=x_str{x_value(1)};

% Getting the variable's value from the base into the caller workspace
xx=evalin('base',x);

figure
plot(xx.time,xx.data)
title(x)

end
%%%%%%%%%%%%%%%%%% Functions for Window 4 END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%