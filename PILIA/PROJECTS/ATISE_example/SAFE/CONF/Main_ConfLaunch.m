function ConfParam = Main_ConfLaunch()

ConfParam.confConst = conf_Const();
ConfParam.confMTB = conf_MTB();
ConfParam.confSatFeatures = conf_SatFeatures();
ConfParam.confLeverArm = conf_LeverArm();
ConfParam.confAeroTorqueA = conf_AeroTorqueA();
ConfParam.confDate = conf_Date();
ConfParam.confSunEphem = conf_SunEphem();
ConfParam.confOrbit = conf_Orbit(ConfParam.confConst.mu, ConfParam.confConst.EarthR,...
    ConfParam.confSatFeatures.mass);
ConfParam.confMagnTorque = conf_MagnTorque();
ConfParam.confSatDyn = conf_SatDyn(ConfParam.confSatFeatures.I_sat);
ConfParam.confBdotController = conf_BdotController(ConfParam.confSatFeatures.I_sat);
ConfParam.confSunTorqueA = conf_SunTorqueA();
ConfParam.confMTM = conf_MTM();
ConfParam.confES = conf_ES();

end