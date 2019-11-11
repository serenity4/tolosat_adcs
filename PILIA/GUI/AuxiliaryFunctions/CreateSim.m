function CreateSim(~, ~, ~)
global Handle

try

    new_system(Handle.FileName.String)

    set_param(Handle.FileName.String,'Solver','ode4');
    set_param(Handle.FileName.String,'StartTime','0');
    set_param(Handle.FileName.String,'FixedStep','ConfParam.confOrbit.dt');

    set_param(Handle.FileName.String,'SaveTime','off');
    set_param(Handle.FileName.String,'LibraryLinkDisplay','all');
    set_param(Handle.FileName.String,'MultiTaskRateTransMsg','warning')

    %% Date And Orbit
    add_block('simulink/Ports & Subsystems/Subsystem',strcat(Handle.FileName.String,'/Date And Orbit'));
    set_param(strcat(Handle.FileName.String,'/Date And Orbit'),'position',[60, 50, 230, 130]);
    set_param(strcat(Handle.FileName.String,'/Date And Orbit'),'BackgroundColor','red');

    delete_line(strcat(Handle.FileName.String,'/Date And Orbit'),'In1/1','Out1/1');
    delete_block(strcat(Handle.FileName.String,'/Date And Orbit/In1'));
    delete_block(strcat(Handle.FileName.String,'/Date And Orbit/Out1'));

    add_block('Date/Current Simulation Date',strcat(Handle.FileName.String,'/Date And Orbit/Current Simulation Date'));
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/Current Simulation Date'),'position',[50, 50, 190, 100]);

    add_block('simulink/Sources/Clock',strcat(Handle.FileName.String,'/Date And Orbit/Clock'));
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/Clock'),'position',[0, 65, 30, 95]);
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/Clock'),'BackgroundColor','cyan');

    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Date And Orbit/JulianDay'));
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/JulianDay'),'position',[250, 50, 280, 70]);
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/JulianDay'),'BackgroundColor','yellow');

    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Date And Orbit/JulianSec'));
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/JulianSec'),'position',[250, 90, 280, 110]);
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/JulianSec'),'BackgroundColor','yellow');

    add_line(strcat(Handle.FileName.String,'/Date And Orbit'),'Current Simulation Date/1','JulianDay/1');
    add_line(strcat(Handle.FileName.String,'/Date And Orbit'),'Current Simulation Date/2','JulianSec/1');
    add_line(strcat(Handle.FileName.String,'/Date And Orbit'),'Clock/1','Current Simulation Date/1');

    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Date And Orbit/SatPos_J2000'));
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/SatPos_J2000'),'position',[450, 160, 480, 180]);
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/SatPos_J2000'),'BackgroundColor','yellow');

    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Date And Orbit/SatVel_J2000'));
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/SatVel_J2000'),'position',[450, 200, 480, 220]);
    set_param(strcat(Handle.FileName.String,'/Date And Orbit/SatVel_J2000'),'BackgroundColor','yellow');

    if Handle.OrbitModelList.Value==1
        add_block('KepOrbit/Keplerian Orbit',strcat(Handle.FileName.String,'/Date And Orbit/Orbit'));
        set_param(strcat(Handle.FileName.String,'/Date And Orbit/Orbit'),'position',[250, 140, 410, 240]);    
    elseif Handle.OrbitModelList.Value==2
        add_block('Orbit/Orbit',strcat(Handle.FileName.String,'/Date And Orbit/Orbit'));
        set_param(strcat(Handle.FileName.String,'/Date And Orbit/Orbit'),'position',[250, 140, 410, 240]);
        add_line(strcat(Handle.FileName.String,'/Date And Orbit'),'Current Simulation Date/1','Orbit/1');
        add_line(strcat(Handle.FileName.String,'/Date And Orbit'),'Current Simulation Date/2','Orbit/2');

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Date And Orbit/SurfaceForces_J2000'));
        set_param(strcat(Handle.FileName.String,'/Date And Orbit/SurfaceForces_J2000'),'position',[0, 200, 30, 220]);
        set_param(strcat(Handle.FileName.String,'/Date And Orbit/SurfaceForces_J2000'),'BackgroundColor','cyan');
        add_line(strcat(Handle.FileName.String,'/Date And Orbit'),'SurfaceForces_J2000/1','Orbit/3');
    else
        disp('You have not chosen the model of the orbit')
    end

    add_line(strcat(Handle.FileName.String,'/Date And Orbit'),'Orbit/1','SatPos_J2000/1');
    add_line(strcat(Handle.FileName.String,'/Date And Orbit'),'Orbit/2','SatVel_J2000/1');

    %% Command

    add_block('Command/Command',strcat(Handle.FileName.String,'/Command'));
    set_param(strcat(Handle.FileName.String,'/Command'),'position',[300, 195, 450, 275]);


    %% Actuators
    if ismember(1,Handle.ActuatorList.Value)
        add_block('MTB/MTB',strcat(Handle.FileName.String,'/MTB'));
        set_param(strcat(Handle.FileName.String,'/MTB'),'position',[1180,300,1270,360]);
    end

    if ismember(2,Handle.ActuatorList.Value)
        add_block('RWS/RWS',strcat(Handle.FileName.String,'/RWS'));
        set_param(strcat(Handle.FileName.String,'/RWS'),'position',[1000,215,1140,255]);
    end

    %% Zero-Order Hold
    add_block('simulink/Ports & Subsystems/Subsystem',strcat(Handle.FileName.String,'/Zero-Order'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order'),'position',[520, 190, 680, 340]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order'),'BackgroundColor','white');

    delete_line(strcat(Handle.FileName.String,'/Zero-Order'),'In1/1','Out1/1');
    delete_block(strcat(Handle.FileName.String,'/Zero-Order/In1'));
    delete_block(strcat(Handle.FileName.String,'/Zero-Order/Out1'));
    
    %% Embedded System

    add_block('simulink/Ports & Subsystems/Subsystem',strcat(Handle.FileName.String,'/Embedded System'));
    set_param(strcat(Handle.FileName.String,'/Embedded System'),'position',[750, 190, 920, 340]);
    set_param(strcat(Handle.FileName.String,'/Embedded System'),'BackgroundColor','lightBlue');

    delete_line(strcat(Handle.FileName.String,'/Embedded System'),'In1/1','Out1/1');
    delete_block(strcat(Handle.FileName.String,'/Embedded System/In1'));
    delete_block(strcat(Handle.FileName.String,'/Embedded System/Out1'));

    add_block('Estimator/Estimator',strcat(Handle.FileName.String,'/Embedded System/Estimator'));
    set_param(strcat(Handle.FileName.String,'/Embedded System/Estimator'),'position',[300,200,400,230]);
    % set_param(strcat(Handle.FileName.String,'/Estimator'),'Orientation','left')

    if ismember(1,Handle.ActuatorList.Value)
        if length(Handle.ActuatorList.Value)==1
            add_block('BdotController/Bdot Controller',strcat(Handle.FileName.String,'/Embedded System/MTB controller'));
            set_param(strcat(Handle.FileName.String,'/Embedded System/MTB controller'),'position',[440,300,560,450]);
        else
            if Handle.MTBControlLawList.Value==1
                add_block('MTBcontroller/MTB controller',strcat(Handle.FileName.String,'/Embedded System/MTB controller'));
                set_param(strcat(Handle.FileName.String,'/Embedded System/MTB controller'),'position',[440,300,560,450]);
            else
                add_block('BdotController/Bdot Controller',strcat(Handle.FileName.String,'/Embedded System/MTB controller'));
                set_param(strcat(Handle.FileName.String,'/Embedded System/MTB controller'),'position',[440,300,560,450]);
            end
        end
    end

    if ismember(2,Handle.ActuatorList.Value)
        if Handle.RWSControlLawList.Value==1
            add_block('RWS_PDcontroller/RWS PD controller',strcat(Handle.FileName.String,'/Embedded System/RWS controller'));
            set_param(strcat(Handle.FileName.String,'/Embedded System/RWS controller'),'position',[440, 70, 560, 230]);
        elseif Handle.RWSControlLawList.Value==2
            add_block('RWS_PIDcontroller/RWS PID controller',strcat(Handle.FileName.String,'/Embedded System/RWS controller'));
            set_param(strcat(Handle.FileName.String,'/Embedded System/RWS controller'),'position',[440, 70, 560, 230]);
        end

    end

    ManageEmbeddedSystemConnections

    %% Satellite dynamics

    add_block('SatDyn/Satellite Dynamics', strcat(Handle.FileName.String,'/Satellite Dynamics'));
    set_param(strcat(Handle.FileName.String,'/Satellite Dynamics'),'position',[1310,190,1420,280]);

    %% Sensors
    if ismember(1,Handle.Sensors.Value)
        add_block('StarTracker/Star Tracker',strcat(Handle.FileName.String,'/Star Tracker'));
        set_param(strcat(Handle.FileName.String,'/Star Tracker'),'position',[1230,460,1300,490]);
        set_param(strcat(Handle.FileName.String,'/Star Tracker'),'Orientation','left')
    end
    if ismember(2,Handle.Sensors.Value)
        add_block('Magnetometer/Magnetometer',strcat(Handle.FileName.String,'/Magnetometer'));
        set_param(strcat(Handle.FileName.String,'/Magnetometer'),'position',[500,500,590,550]);
    end

    %% Environment
    if (Handle.SunList.Value~=3 || Handle.MagnList.Value~=3 || Handle.MoonEphemChoice.Value==1)
        add_block('simulink/Ports & Subsystems/Subsystem',strcat(Handle.FileName.String,'/Environment'));
        set_param(strcat(Handle.FileName.String,'/Environment'),'position',[310, 50, 460, 110]);
        set_param(strcat(Handle.FileName.String,'/Environment'),'BackgroundColor','darkGreen');

        delete_line(strcat(Handle.FileName.String,'/Environment'),'In1/1','Out1/1');
        delete_block(strcat(Handle.FileName.String,'/Environment/In1'));
        delete_block(strcat(Handle.FileName.String,'/Environment/Out1'));
    end

    if (Handle.SunList.Value~=3 || Handle.MagnList.Value==1 || Handle.MoonEphemChoice.Value==1)
        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Environment/JulianDay'));
        set_param(strcat(Handle.FileName.String,'/Environment/JulianDay'),'position',[20, 130, 40, 150]);
        set_param(strcat(Handle.FileName.String,'/Environment/JulianDay'),'BackgroundColor','cyan');

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Environment/JulianSec'));
        set_param(strcat(Handle.FileName.String,'/Environment/JulianSec'),'position',[20, 170, 40, 190]);
        set_param(strcat(Handle.FileName.String,'/Environment/JulianSec'),'BackgroundColor','cyan');
    end

    if Handle.MoonEphemChoice.Value==1
        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Environment/MoonPos_J2000'));
        set_param(strcat(Handle.FileName.String,'/Environment/MoonPos_J2000'),'position',[280, 80, 300, 100]);
        set_param(strcat(Handle.FileName.String,'/Environment/MoonPos_J2000'),'BackgroundColor','yellow');

        add_block('MoonEphemeris_MathWorks/Moon Ephemeris',strcat(Handle.FileName.String,'/Environment/Moon Ephemeris J2000'));
        set_param(strcat(Handle.FileName.String,'/Environment/Moon Ephemeris J2000'),'position',[100, 60, 230, 110]);

        add_line(strcat(Handle.FileName.String,'/Environment'),'Moon Ephemeris J2000/1','MoonPos_J2000/1');
        add_line(strcat(Handle.FileName.String,'/Environment'),'JulianDay/1','Moon Ephemeris J2000/1');
        add_line(strcat(Handle.FileName.String,'/Environment'),'JulianSec/1','Moon Ephemeris J2000/2'); 
    end

    if Handle.SunList.Value~=3
        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Environment/SunPos_J2000'));
        set_param(strcat(Handle.FileName.String,'/Environment/SunPos_J2000'),'position',[280, 160, 300, 180]);
        set_param(strcat(Handle.FileName.String,'/Environment/SunPos_J2000'),'BackgroundColor','yellow');

        if ismember(1,Handle.SunList.Value)
            add_block('SunEphemeris_MathWorks/Sun Ephemeris J2000',strcat(Handle.FileName.String,'/Environment/Sun Ephemeris J2000'));

        elseif ismember(2,Handle.SunList.Value)
            add_block('SunPosition/Sun position in the J2000 frame',strcat(Handle.FileName.String,'/Environment/Sun Ephemeris J2000'));

        end
        set_param(strcat(Handle.FileName.String,'/Environment/Sun Ephemeris J2000'),'position',[100, 140, 230, 190]);    
        add_line(strcat(Handle.FileName.String,'/Environment'),'Sun Ephemeris J2000/1','SunPos_J2000/1');
        add_line(strcat(Handle.FileName.String,'/Environment'),'JulianDay/1','Sun Ephemeris J2000/1');
        add_line(strcat(Handle.FileName.String,'/Environment'),'JulianSec/1','Sun Ephemeris J2000/2');   
    end

    if Handle.MagnList.Value~=3
        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Environment/SatPos_J2000'));
        set_param(strcat(Handle.FileName.String,'/Environment/SatPos_J2000'),'position',[40, 240, 60, 260]);
        set_param(strcat(Handle.FileName.String,'/Environment/SatPos_J2000'),'BackgroundColor','cyan');

        if ismember(1,Handle.MagnList.Value)
            add_block('IGRF/IGRF in the J2000 frame',strcat(Handle.FileName.String,'/Environment/B J2000'));
            add_line(strcat(Handle.FileName.String,'/Environment'),'JulianDay/1','B J2000/1');
            add_line(strcat(Handle.FileName.String,'/Environment'),'JulianSec/1','B J2000/2');
            add_line(strcat(Handle.FileName.String,'/Environment'),'SatPos_J2000/1','B J2000/3');
        elseif ismember(2,Handle.MagnList.Value)
            add_block('DipoleField/Earth dipole magnetic field',strcat(Handle.FileName.String,'/Environment/B J2000'));
            add_line(strcat(Handle.FileName.String,'/Environment'),'SatPos_J2000/1','B J2000/1');
        end

        set_param(strcat(Handle.FileName.String,'/Environment/B J2000'),'position',[100, 220, 230, 270]);
        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Environment/B_J2000'));
        set_param(strcat(Handle.FileName.String,'/Environment/B_J2000'),'position',[280, 230, 300, 250]);
        set_param(strcat(Handle.FileName.String,'/Environment/B_J2000'),'BackgroundColor','yellow');
        add_line(strcat(Handle.FileName.String,'/Environment'),'B J2000/1','B_J2000/1');

    end

    %% Perturbation Effects

    if ~ismember(5,Handle.PertTorqueList.Value)

        add_block('simulink/Ports & Subsystems/Subsystem',strcat(Handle.FileName.String,'/Perturbation Effects'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects'),'position',[1000, 50, 1190, 170]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects'),'BackgroundColor','Green');

        delete_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'In1/1','Out1/1');
        delete_block(strcat(Handle.FileName.String,'/Perturbation Effects/In1'));
        delete_block(strcat(Handle.FileName.String,'/Perturbation Effects/Out1'));

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Perturbation Effects/Qsat'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Qsat'),'position',[5, 250, 25, 270]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Qsat'),'BackgroundColor','cyan');

        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Perturbation Effects/T ext'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/T ext'),'position',[690, 345, 710, 365]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/T ext'),'BackgroundColor','yellow');

    end

    if (ismember(1,Handle.PertTorqueList.Value) || ismember(4,Handle.PertTorqueList.Value))
        add_block('Qinverse/Compute Q Inverse',strcat(Handle.FileName.String,'/Perturbation Effects/Compute Q Inverse'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Compute Q Inverse'),'position',[560, 15, 630, 45]);
        add_block('ChangeFrame/Change_Frame',strcat(Handle.FileName.String,'/Perturbation Effects/Change_Frame'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Change_Frame'),'position',[740, 15, 930, 75]);

        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Perturbation Effects/Surface Forces_J2000'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Surface Forces_J2000'),'position',[1000, 30, 1020, 50]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Surface Forces_J2000'),'BackgroundColor','yellow');
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Surface Forces_J2000'),'Port','1');

        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Compute Q Inverse/1','Change_Frame/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Change_Frame/1','Surface Forces_J2000/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Qsat/1','Compute Q Inverse/1');   

    end

    % Do not change the order of the next four if, not to change the port
    % numbers of the inputs

    if ismember(2,Handle.PertTorqueList.Value)
        add_block('GravGradTorque/Gravity Gradient Torque',strcat(Handle.FileName.String,'/Perturbation Effects/Gravity Gradient Torque'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Gravity Gradient Torque'),'position',[270, 400, 420, 450]);
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Qsat/1','Gravity Gradient Torque/2');  
    end

    if ismember(4,Handle.PertTorqueList.Value)
        add_block('SunTorqueA/Sun Torque',strcat(Handle.FileName.String,'/Perturbation Effects/Sun Torque'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Sun Torque'),'position',[270, 290, 420, 370]);

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Perturbation Effects/SunPos_J2000'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/SunPos_J2000'),'position',[210, 320, 230, 340]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/SunPos_J2000'),'BackgroundColor','cyan');

        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Qsat/1','Sun Torque/3');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'SunPos_J2000/1','Sun Torque/2');   

    end

    if ismember(3,Handle.PertTorqueList.Value)
        add_block('MagnTorque/Magnetic Torque',strcat(Handle.FileName.String,'/Perturbation Effects/Magnetic Torque'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Magnetic Torque'),'position',[270, 480, 420, 530]);

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Perturbation Effects/B_J2000'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/B_J2000'),'position',[210, 510, 230, 530]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/B_J2000'),'BackgroundColor','cyan');

        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Qsat/1','Magnetic Torque/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'B_J2000/1','Magnetic Torque/2');
    end

    if (ismember(1,Handle.PertTorqueList.Value) || ismember(2,Handle.PertTorqueList.Value)...
            || ismember(4,Handle.PertTorqueList.Value))

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Perturbation Effects/SatPos_J2000'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/SatPos_J2000'),'position',[30, 160, 50, 180]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/SatPos_J2000'),'BackgroundColor','cyan');
    end

    if ismember(4,Handle.PertTorqueList.Value)
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'SatPos_J2000/1','Sun Torque/1');
    end

    if ismember(2,Handle.PertTorqueList.Value)
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'SatPos_J2000/1','Gravity Gradient Torque/1');
    end

    if ismember(1,Handle.PertTorqueList.Value)
        add_block('AeroTorqueA/Aero Torque',strcat(Handle.FileName.String,'/Perturbation Effects/Aero Torque'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Aero Torque'),'position',[270, 160, 410, 260]);

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Perturbation Effects/SatVel_J2000'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/SatVel_J2000'),'position',[200, 200, 220, 220]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/SatVel_J2000'),'BackgroundColor','cyan');

        add_block('simulink/Sinks/Terminator',strcat(Handle.FileName.String,'/Perturbation Effects/Terminator'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Terminator'),'position',[435, 235, 450, 250]);

        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'SatPos_J2000/1','Aero Torque/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Qsat/1','Aero Torque/3');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'SatVel_J2000/1','Aero Torque/2');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/3','Terminator/1');
    end

    if (ismember(1,Handle.PertTorqueList.Value) && ismember(4,Handle.PertTorqueList.Value))

        add_block('simulink/Math Operations/Add',strcat(Handle.FileName.String,'/Perturbation Effects/Add1'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Add1'),'position',[630, 70, 660, 120]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Add1'),'Inputs','++');

        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Add1/1','Change_Frame/2');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/1','Add1/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/1','Add1/2');
    end

    if length(Handle.PertTorqueList.Value)>1
        plus='++';
        for i=3:length(Handle.PertTorqueList.Value)
            plus=strcat(plus,'+');
        end
        add_block('simulink/Math Operations/Add',strcat(Handle.FileName.String,'/Perturbation Effects/Add'));
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Add'),'position',[630, 155, 660, 550]);
        set_param(strcat(Handle.FileName.String,'/Perturbation Effects/Add'),'Inputs',plus);
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Add/1','T ext/1');
    end

    PertTorquesOutputsConnections

    %%

    % add_line(Handle.FileName.String,'Command/1','RWS PD controller/1');
    % add_line(Handle.FileName.String,'Command/2','RWS PD controller/2');
    % add_line(Handle.FileName.String,'Command/3','RWS PD controller/3');

    % set_param(Handle.FileName.String,'ZoomFactor','FitSystem');
    set_param(Handle.FileName.String,'ZoomFactor','80');

    open_system(Handle.FileName.String);
    save_system(Handle.FileName.String);

    set(Handle.FileName,'Enable','off')
    set(Handle.CreateSim,'Enable','off')

    evalin('base',['mkdir ', 'CONF']);
    evalin('base',['mkdir ', 'AUTOCODE']);
    
    Handle.ConfDir=[Handle.FinalDir, filesep, 'CONF'];
    
    evalin('base',['addpath ', Handle.ConfDir]);
catch ME
    if strcmp(ME.identifier,'Simulink:LoadSave:InvalidBlockDiagramName')
        Handle.NameError=uicontrol('Style','text','Parent', Handle.Win2, 'Position', [300 400 250 50], 'String',...
            'The name of your Simulator is not valid. Please Enter a valid name and press the red button at the bottom.','FontSize',10,...
            'ForegroundColor','r');
        
        Handle.NameErrorOk=uicontrol('Style','checkbox','Parent', Handle.Win2, 'Position', [300 385 250 20], 'ForegroundColor',...
            [1 0 0], 'String', 'Ok','FontSize',10,'Callback',@DisableNameError);
        
        set(Handle.FileName,'Enable','on')
        set(Handle.CreateSim,'visible','off')
        set(Handle.finish,'Enable','on')
        set(Handle.finish,'BackgroundColor',[1 0 0]) 
    elseif strcmp(ME.identifier,'MATLAB:MException:MultipleErrors')
        delete_block(strcat(Handle.FileName.String,'/Date And Orbit'));
        open_system(Handle.FileName.String);
        errordlg(['You might not have added the library blocks to your Matlab path.',...
            ' Please, add them and press again the button "Create Simulink model".'],...
            'Library blocks not found');
    else
        rethrow(ME)
    end
end
end