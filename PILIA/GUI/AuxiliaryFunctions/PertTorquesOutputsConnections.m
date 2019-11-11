function PertTorquesOutputsConnections
global Handle

if (length(Handle.PertTorqueList.Value)==1 && ~ismember(5,Handle.PertTorqueList.Value))
    if Handle.PertTorqueList.Value==1
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/2','T ext/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/1','Change_Frame/2');
    elseif Handle.PertTorqueList.Value==2
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Gravity Gradient Torque/1','T ext/1');
    elseif Handle.PertTorqueList.Value==3
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Magnetic Torque/1','T ext/1');        
    elseif Handle.PertTorqueList.Value==4
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/2','T ext/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/1','Change_Frame/2');
    end
end

if length(Handle.PertTorqueList.Value)==2
    if ismember(1,Handle.PertTorqueList.Value)
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/2','Add/1');
        if ismember(4,Handle.PertTorqueList.Value)
            add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/2','Add/2');
        else
            add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/1','Change_Frame/2');
        end
    else
        if ismember(4,Handle.PertTorqueList.Value)
            add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/2','Add/1');
            add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/1','Change_Frame/2');
        end
    end
    
    if (ismember(2,Handle.PertTorqueList.Value) &&...
            (ismember(1,Handle.PertTorqueList.Value) || ismember(4,Handle.PertTorqueList.Value)))
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Gravity Gradient Torque/1','Add/2');
    end
    
    if (ismember(2,Handle.PertTorqueList.Value) && ismember(3,Handle.PertTorqueList.Value))
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Gravity Gradient Torque/1','Add/1');
    end
    
    if ismember(3,Handle.PertTorqueList.Value)
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Magnetic Torque/1','Add/2');
    end
end

if length(Handle.PertTorqueList.Value)==3
    if ~ismember(1,Handle.PertTorqueList.Value)
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/2','Add/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Gravity Gradient Torque/1','Add/2');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Magnetic Torque/1','Add/3');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/1','Change_Frame/2');
    elseif ~ismember(2,Handle.PertTorqueList.Value)
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/2','Add/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/2','Add/2');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Magnetic Torque/1','Add/3');
    elseif ~ismember(3,Handle.PertTorqueList.Value)
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/2','Add/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/2','Add/2');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Gravity Gradient Torque/1','Add/3');
    elseif ~ismember(4,Handle.PertTorqueList.Value)
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/2','Add/1');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Gravity Gradient Torque/1','Add/2');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Magnetic Torque/1','Add/3');
        add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/1','Change_Frame/2');
    end
end

if length(Handle.PertTorqueList.Value)==4
    add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Aero Torque/2','Add/1');
    add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Sun Torque/2','Add/2');
    add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Gravity Gradient Torque/1','Add/3');
    add_line(strcat(Handle.FileName.String,'/Perturbation Effects'),'Magnetic Torque/1','Add/4');
end

end