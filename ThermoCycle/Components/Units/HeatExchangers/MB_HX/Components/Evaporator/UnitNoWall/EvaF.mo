within ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components.Evaporator.UnitNoWall;
model EvaF
replaceable package Medium =
      ThermoCycle.Media.DummyFluid constrainedby
    Modelica.Media.Interfaces.PartialMedium
annotation (choicesAllMatching = true);
  EvaFlooded evaFlooded(
    redeclare package Medium = Medium,
    AA=AA,
    YY=YY,
    Ltotal=Ltotal,
    Mdotnom=Mdotnom,
    UnomSC=UnomSC,
    UnomTP=UnomTP,
    eps_NTU=epsNTU_pf,
    pstart=pstart,
    hstartSC=hstartSC,
    lstartSC=lstartSC,
    lstartTP=lstartTP,
    hstartTP=hstartTP)
    annotation (Placement(transformation(extent={{-28,-98},{32,-58}})));
  ThermoCycle.Interfaces.Fluid.FlangeA InflowPF(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  ThermoCycle.Interfaces.Fluid.FlangeB OutflowPF(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{88,-88},{108,-68}})));
  SecondaryFluid.SecondaryFluid secondaryFluid(
    Usf=Unomsf,
    AA=AA,
    YY=YY,
    L_total=Ltotal,
    Tstart=Tstartsf,
    n=nCV,
    DTstart=DTstartsf,
    eps_NTU=epsNTU_sf)
    annotation (Placement(transformation(extent={{-34,60},{30,100}})));
  ThermoCycle.Interfaces.Fluid.Flange_Cdot InFlowSF
    annotation (Placement(transformation(extent={{84,70},{104,90}})));
    final parameter Integer  nCV= 2;

/* GEOMETRIES */
parameter Modelica.SIunits.Length Ltotal=500
    "Total length of the heat exchanger";
parameter Modelica.SIunits.Area AA = 0.0019 "Channel cross section";
parameter Modelica.SIunits.Length YY "Channel perimeter";
parameter Modelica.SIunits.Pressure pstart=6e6 "Fluid pressure start value"
    annotation (Dialog(tab="Initialization"));

  /* BOOLEAN */
parameter Boolean epsNTU_sf = false "SF-wall :If True use eps-NTU " annotation (Dialog(group = "Heat transfer"));
parameter Boolean epsNTU_pf = false "PF-wall :If True use eps-NTU  " annotation (Dialog(group = "Heat transfer"));
parameter Boolean counterCurrent = true
    "If true countercurrent - PARALLEL FLOW NOT STABLE";
/* INITIAL VALUES */
parameter Modelica.SIunits.MassFlowRate Mdotnom=0 "Nominal fluid flow rate" annotation (Dialog(group = "Heat transfer"));
parameter Modelica.SIunits.CoefficientOfHeatTransfer UnomSC=2500
    "SC - Nominal heat transfer coefficient"                                                annotation (Dialog(group = "Heat transfer"));
parameter Modelica.SIunits.CoefficientOfHeatTransfer UnomTP=9000
    "TP - Nominal heat transfer coefficient"                                                annotation (Dialog(group = "Heat transfer"));
parameter Modelica.SIunits.CoefficientOfHeatTransfer Unomsf=1000
    "TP - Nominal heat transfer coefficient"                                                annotation (Dialog(group = "Heat transfer"));
parameter Medium.SpecificEnthalpy hstartSC=1E5 "SC: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));
parameter Modelica.SIunits.Length lstartSC=1 "SC:Start value of length"
    annotation (Dialog(tab="Initialization"));
parameter Medium.SpecificEnthalpy hstartTP=1E5 "TP: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));
parameter Modelica.SIunits.Length lstartTP=1 "TP:Start value of length"
    annotation (Dialog(tab="Initialization"));
parameter Modelica.SIunits.Temperature Tstartsf
    "Start value for average temperature of inlet cell" annotation (Dialog(tab="Initialization",group= "Secondary fluid"));
parameter Modelica.SIunits.Temperature DTstartsf
    "Delta T to initialize second and third volume average temperature" annotation (Dialog(tab="Initialization",group= "Secondary fluid"));

parameter Medium.SpecificEnthalpy h_pf_out = 1E5
    "Outlet enthalpy of the primary fluid"                                                 annotation(Dialog(tab="Initialization", enable= Set_h_pf_out, group= "Primary fluid"));
parameter Boolean SteadyStatePF = false
    "If true set length and h_out derivative of PF to zero"                                     annotation(Dialog(tab="Initialization",group= "Primary fluid"));
parameter Boolean Set_h_pf_out = false
    "If true set PF outlet enthalpy during initialization equal to h_pf_out"                annotation(Dialog(tab="Initialization",group= "Primary fluid"));

equation
    /* If statement to allow parallel or counter current structure*/
if counterCurrent then
connect( evaFlooded.mbOut, secondaryFluid.mbIn[nCV:-1:1]);
else
  connect(evaFlooded.mbOut, secondaryFluid.mbIn);
end if;
  connect(secondaryFluid.InFlow_sf, InFlowSF) annotation (Line(
      points={{26.8,80},{94,80}},
      color={255,0,0},
      smooth=Smooth.None));

initial equation
if SteadyStatePF then
    der(evaFlooded.volumeSC.ll) = 0;
    der(evaFlooded.volumeTP.h_b) = 0;
  end if;
  if Set_h_pf_out then
    evaFlooded.volumeTP.h_b = h_pf_out;
  end if;

equation
  connect(InflowPF, evaFlooded.InFlow) annotation (Line(
      points={{-100,-80},{-66,-80},{-66,-78},{-29.2,-78}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(evaFlooded.OutFlow, OutflowPF) annotation (Line(
      points={{31.4,-77.6},{60.7,-77.6},{60.7,-78},{98,-78}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                        graphics));
end EvaF;
