function ConfParam = Main_ConfLaunch()

ConfParam.confConst = conf_Const();
ConfParam.confCommand = conf_Command();
ConfParam.confEarthPointing = conf_EarthPointing();
ConfParam.confInerPoint = conf_InerPoint ();
ConfParam.confMTB = conf_MTB();
ConfParam.confSatFeatures = conf_SatFeatures();
ConfParam.confLeverArm = conf_LeverArm();
ConfParam.confAeroTorqueA = conf_AeroTorqueA();
ConfParam.confAeroTorqueC = conf_AeroTorqueC();
ConfParam.confDate = conf_Date();
ConfParam.confIGRF = conf_IGRF();
ConfParam.confSunEphem = conf_SunEphem();
ConfParam.confOrbit = conf_Orbit(ConfParam.confConst.mu, ConfParam.confConst.EarthR,...
    ConfParam.confSatFeatures.mass);
ConfParam.confMagnTorque = conf_MagnTorque();
ConfParam.confSatDyn = conf_SatDyn(ConfParam.confSatFeatures.I_sat);
ConfParam.confBdotController = conf_BdotController(ConfParam.confSatFeatures.I_sat);
ConfParam.confSunTorqueA = conf_SunTorqueA();
ConfParam.confSunTorqueC = conf_SunTorqueC();
ConfParam.confTargetPointing = conf_TargetPointing();
ConfParam.confEarthAndTargetPointing = conf_EarthAndTargetPointing(ConfParam.confTargetPointing.StaPosECEF);
ConfParam.confInertialAndTargetPointing = conf_InertialAndTargetPointing(ConfParam.confTargetPointing.StaPosECEF);
ConfParam.confMTM = conf_MTM();
ConfParam.confES = conf_ES();
ConfParam.confRWS = conf_RWS();
ConfParam.confRWS_PDcontroller = conf_RWS_PDcontroller(ConfParam.confSatFeatures.I_sat);
ConfParam.confEstim = conf_Estim(ConfParam.confES.frequency);
ConfParam.confMTBcontroller = conf_MTBcontroller(ConfParam.confSatFeatures.I_sat,...
    ConfParam.confES.frequency);

end
