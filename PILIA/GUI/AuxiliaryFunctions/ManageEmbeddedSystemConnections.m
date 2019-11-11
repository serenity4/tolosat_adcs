function ManageEmbeddedSystemConnections
global Handle
if ismember(2,Handle.ActuatorList.Value)
    %%%% For the Embedded System
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/QcomES'));
    set_param(strcat(Handle.FileName.String,'/Embedded System/QcomES'),'position',[390, 70, 410, 90]);
    set_param(strcat(Handle.FileName.String,'/Embedded System/QcomES'),'BackgroundColor','cyan');
    
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/OmegaComES'));
    set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaComES'),'position',[10, 100, 30, 120]);
    set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaComES'),'BackgroundColor','cyan');
    
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/OmegaDotComES'));
    set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaDotComES'),'position',[370, 130, 390, 150]);
    set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaDotComES'),'BackgroundColor','cyan');
    
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/QstES'));
    set_param(strcat(Handle.FileName.String,'/Embedded System/QstES'),'position',[10, 200, 30, 220]);
    set_param(strcat(Handle.FileName.String,'/Embedded System/QstES'),'BackgroundColor','cyan');
    
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/H_RWS_ES'));
    set_param(strcat(Handle.FileName.String,'/Embedded System/H_RWS_ES'),'position',[10, 160, 30, 180]);
    set_param(strcat(Handle.FileName.String,'/Embedded System/H_RWS_ES'),'BackgroundColor','cyan');
    
    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Embedded System/T_RWScom'));
    set_param(strcat(Handle.FileName.String,'/Embedded System/T_RWScom'),'position',[590, 145, 610, 165]);
    set_param(strcat(Handle.FileName.String,'/Embedded System/T_RWScom'),'BackgroundColor','cyan');
    
    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'));
    set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'),'position',[500, 260, 520, 280]);
    set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'),'BackgroundColor','cyan');
    
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'QcomES/1','RWS controller/1');
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'OmegaComES/1','RWS controller/2');
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'OmegaDotComES/1','RWS controller/3');
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'H_RWS_ES/1','RWS controller/4');
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'QstES/1','RWS controller/5');
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'QstES/1','Estimator/1');
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'Estimator/1','RWS controller/6');
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'RWS controller/1','T_RWScom/1');
    add_line(strcat(Handle.FileName.String,'/Embedded System'),'Estimator/1','OmegaEstim/1');
 
    
%%%%%%%%%%%%%%% For the Zero-Order %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Inputs %%%%%%%%%
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/Qcom'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Qcom'),'position',[30, 30, 55, 50]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Qcom'),'BackgroundColor','cyan');
    
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/OmegaCom'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/OmegaCom'),'position',[30, 90, 55, 110]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/OmegaCom'),'BackgroundColor','cyan');
    
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/OmegaDotCom'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/OmegaDotCom'),'position',[30, 150, 55, 170]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/OmegaDotCom'),'BackgroundColor','cyan');
    
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/Qst'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Qst'),'position',[30, 270, 55, 290]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Qst'),'BackgroundColor','cyan');
    
    add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/H_RWS_sat'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/H_RWS_sat'),'position',[30, 330, 55, 350]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/H_RWS_sat'),'BackgroundColor','cyan');
    
%%%%%%%%%%%%%%%%% Outputs %%%%%%%%%%%%%%%%%
    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/QcomES'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/QcomES'),'position',[230, 30, 255, 50]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/QcomES'),'BackgroundColor','yellow');
    
    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/OmegaComES'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/OmegaComES'),'position',[230, 90, 255, 110]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/OmegaComES'),'BackgroundColor','yellow');
    
    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/OmegaDotComES'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/OmegaDotComES'),'position',[230, 150, 255, 170]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/OmegaDotComES'),'BackgroundColor','yellow');
    
    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/QstES'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/QstES'),'position',[230, 270, 255, 290]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/QstES'),'BackgroundColor','yellow');
    
    add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/H_RWS_ES'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/H_RWS_ES'),'position',[230, 330, 255, 350]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/H_RWS_ES'),'BackgroundColor','yellow');
    
%%%%%%%%% Zero-Order Hold %%%%%%%%%%%%%%%%%%%%%%%%%%%
    add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'),'position',[130, 25, 160, 55]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'),'SampleTime','1/ConfParam.confES.frequency');
    
    add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold1'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold1'),'position',[130, 85, 160, 115]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold1'),'SampleTime','1/ConfParam.confES.frequency');
    
    add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold2'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold2'),'position',[130, 145, 160, 175]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold2'),'SampleTime','1/ConfParam.confES.frequency');
    
    add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold3'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold3'),'position',[130, 265, 160, 295]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold3'),'SampleTime','1/ConfParam.confES.frequency');
    
    add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold4'));
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold4'),'position',[130, 325, 160, 355]);
    set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold4'),'SampleTime','1/ConfParam.confES.frequency');
    
%%%%%%%%%% add_line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Qcom/1','Zero-Order Hold/1');
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold/1','QcomES/1');
    
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'OmegaCom/1','Zero-Order Hold1/1');
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold1/1','OmegaComES/1');
    
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'OmegaDotCom/1','Zero-Order Hold2/1');
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold2/1','OmegaDotComES/1');
    
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Qst/1','Zero-Order Hold3/1');
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold3/1','QstES/1');
    
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'H_RWS_sat/1','Zero-Order Hold4/1');
    add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold4/1','H_RWS_ES/1');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ismember(1,Handle.ActuatorList.Value)
        
        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Embedded System/Mcom'));
        set_param(strcat(Handle.FileName.String,'/Embedded System/Mcom'),'position',[590, 365, 610, 385]);
        set_param(strcat(Handle.FileName.String,'/Embedded System/Mcom'),'BackgroundColor','cyan');
        if Handle.MTBControlLawList.Value==1
            %%%%%%%%% For the Embedded System %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/B_J2000_ES'));
            set_param(strcat(Handle.FileName.String,'/Embedded System/B_J2000_ES'),'position',[390, 425, 410, 445]);
            set_param(strcat(Handle.FileName.String,'/Embedded System/B_J2000_ES'),'BackgroundColor','cyan');
            set_param(strcat(Handle.FileName.String,'/Embedded System/B_J2000_ES'),'Port','4');
            
            add_line(strcat(Handle.FileName.String,'/Embedded System'),'H_RWS_ES/1','MTB controller/3');
            add_line(strcat(Handle.FileName.String,'/Embedded System'),'OmegaComES/1','MTB controller/2');
            add_line(strcat(Handle.FileName.String,'/Embedded System'),'Estimator/1','MTB controller/1');
            add_line(strcat(Handle.FileName.String,'/Embedded System'),'QstES/1','MTB controller/4');
            add_line(strcat(Handle.FileName.String,'/Embedded System'),'B_J2000_ES/1','MTB controller/5');
            add_line(strcat(Handle.FileName.String,'/Embedded System'),'MTB controller/1','Mcom/1');
            
            %%%%%%%% For the Zero-Order %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/B_J2000'));
            set_param(strcat(Handle.FileName.String,'/Zero-Order/B_J2000'),'position',[30, 210, 55, 230]);
            set_param(strcat(Handle.FileName.String,'/Zero-Order/B_J2000'),'BackgroundColor','cyan');
            set_param(strcat(Handle.FileName.String,'/Zero-Order/B_J2000'),'Port','4');
            
            add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold5'));
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold5'),'position',[130, 205, 160, 235]);
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold5'),'SampleTime',...
                '1/ConfParam.confES.frequency');
            
            add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/B_J2000_ES'));
            set_param(strcat(Handle.FileName.String,'/Zero-Order/B_J2000_ES'),'position',[230, 210, 255, 230]);
            set_param(strcat(Handle.FileName.String,'/Zero-Order/B_J2000_ES'),'BackgroundColor','yellow');
            set_param(strcat(Handle.FileName.String,'/Zero-Order/B_J2000_ES'),'Port','4');
            
            add_line(strcat(Handle.FileName.String,'/Zero-Order'),'B_J2000/1','Zero-Order Hold5/1');
            add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold5/1','B_J2000_ES/1');
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        else
            %%%%%%%%%%%%%% For the Embedded System %%%%%%%%%%%%%%%%%%%%%%%%
            add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/Bmes_satES'));
            set_param(strcat(Handle.FileName.String,'/Embedded System/Bmes_satES'),'position',[390, 425, 410, 445]);
            set_param(strcat(Handle.FileName.String,'/Embedded System/Bmes_satES'),'BackgroundColor','cyan');
            set_param(strcat(Handle.FileName.String,'/Embedded System/Bmes_satES'),'Port','4');
            
            add_line(strcat(Handle.FileName.String,'/Embedded System'),'Bmes_satES/1','MTB controller/1');
            add_line(strcat(Handle.FileName.String,'/Embedded System'),'MTB controller/1','Mcom/1');
            
            %%%%%%%%%%%%%% For the Zero-Order %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/Bmes_sat'));
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_sat'),'position',[30, 210, 55, 230]);
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_sat'),'BackgroundColor','cyan');
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_sat'),'Port','4');
            
            add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold5'));
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold5'),'position',[130, 205, 160, 235]);
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold5'),'SampleTime',...
                '1/ConfParam.confES.frequency');
            
            add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/Bmes_satES'));
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_satES'),'position',[230, 210, 255, 230]);
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_satES'),'BackgroundColor','yellow');
            set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_satES'),'Port','4');
            
            add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Bmes_sat/1','Zero-Order Hold5/1');
            add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold5/1','Bmes_satES/1');
        end
    end
else
    if ismember(1,Handle.ActuatorList.Value)
        
        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Embedded System/Mcom'));
        set_param(strcat(Handle.FileName.String,'/Embedded System/Mcom'),'position',[590, 365, 610, 385]);
        set_param(strcat(Handle.FileName.String,'/Embedded System/Mcom'),'BackgroundColor','cyan');
        
        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'));
        set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'),'position',[500, 260, 520, 280]);
        set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'),'BackgroundColor','cyan');
        
        %%%%%%%%%%%%%%%% For the Embedded System %%%%%%%%%%%%%%%%%%%%%%%%%%
        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/Bmes_satES'));
        set_param(strcat(Handle.FileName.String,'/Embedded System/Bmes_satES'),'position',[390, 425, 410, 445]);
        set_param(strcat(Handle.FileName.String,'/Embedded System/Bmes_satES'),'BackgroundColor','cyan');

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/QstES'));
        set_param(strcat(Handle.FileName.String,'/Embedded System/QstES'),'position',[10, 200, 30, 220]);
        set_param(strcat(Handle.FileName.String,'/Embedded System/QstES'),'BackgroundColor','cyan');

        add_line(strcat(Handle.FileName.String,'/Embedded System'),'QstES/1','Estimator/1');
        add_line(strcat(Handle.FileName.String,'/Embedded System'),'Estimator/1','OmegaEstim/1');
        add_line(strcat(Handle.FileName.String,'/Embedded System'),'Bmes_satES/1','MTB controller/1');
        add_line(strcat(Handle.FileName.String,'/Embedded System'),'MTB controller/1','Mcom/1');

        %%%%%%%%%%%%%% For the Zero-Order %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/Bmes_sat'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_sat'),'position',[30, 90, 55, 110]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_sat'),'BackgroundColor','cyan');

        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/Qst'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Qst'),'position',[30, 150, 55, 170]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Qst'),'BackgroundColor','cyan');

        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/Bmes_satES'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_satES'),'position',[230, 90, 255, 110]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Bmes_satES'),'BackgroundColor','yellow');

        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/QstES'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/QstES'),'position',[230, 150, 255, 170]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/QstES'),'BackgroundColor','yellow');

        add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'),'position',[130, 85, 160, 115]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'),'SampleTime','1/ConfParam.confES.frequency');

        add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold1'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold1'),'position',[130, 145, 160, 175]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold1'),'SampleTime','1/ConfParam.confES.frequency');

        add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Bmes_sat/1','Zero-Order Hold/1');
        add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold/1','Bmes_satES/1');
        add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Qst/1','Zero-Order Hold1/1');
        add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold1/1','QstES/1');
        
    else
        %%%%%%%%%%%% For the Embedded System %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Embedded System/QstES'));
        set_param(strcat(Handle.FileName.String,'/Embedded System/QstES'),'position',[10, 200, 30, 220]);
        set_param(strcat(Handle.FileName.String,'/Embedded System/QstES'),'BackgroundColor','cyan');
        
        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'));
        set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'),'position',[500, 260, 520, 280]);
        set_param(strcat(Handle.FileName.String,'/Embedded System/OmegaEstim'),'BackgroundColor','cyan');
        
        add_line(strcat(Handle.FileName.String,'/Embedded System'),'QstES/1','Estimator/1');
        add_line(strcat(Handle.FileName.String,'/Embedded System'),'Estimator/1','OmegaEstim/1');
        
        %%%%%%%%%%%%%% For the Zero-Order %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        add_block('simulink/Sources/In1',strcat(Handle.FileName.String,'/Zero-Order/Qst'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Qst'),'position',[30, 150, 55, 170]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Qst'),'BackgroundColor','cyan');
        
        add_block('simulink/Sinks/Out1',strcat(Handle.FileName.String,'/Zero-Order/QstES'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/QstES'),'position',[230, 150, 255, 170]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/QstES'),'BackgroundColor','yellow');
        
        add_block('simulink/Discrete/Zero-Order Hold',strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'));
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'),'position',[130, 145, 160, 175]);
        set_param(strcat(Handle.FileName.String,'/Zero-Order/Zero-Order Hold'),'SampleTime','1/ConfParam.confES.frequency');
        
        add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Qst/1','Zero-Order Hold/1');
        add_line(strcat(Handle.FileName.String,'/Zero-Order'),'Zero-Order Hold/1','QstES/1');
    end
end
end