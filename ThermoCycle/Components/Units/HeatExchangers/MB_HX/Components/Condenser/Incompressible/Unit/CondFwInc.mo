within ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components.Condenser.Incompressible.Unit;
model CondFwInc
replaceable package Medium =
      ThermoCycle.Media.DummyFluid constrainedby
    Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching = true);

    /* Components */

  Incompressible.CondFloodedInc
    CondFlooded(
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
    hstartTP=hstartTP,
    VoidFraction=VoidFraction,
    VoidF=VoidF)
    annotation (Placement(transformation(extent={{-22,-98},{38,-58}})));
  ThermoCycle.Interfaces.Fluid.FlangeA InflowPF(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-108,-46},{-88,-26}}),
        iconTransformation(extent={{-108,-46},{-88,-26}})));
  ThermoCycle.Interfaces.Fluid.FlangeB OutflowPF(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{72,-50},{92,-30}}),
        iconTransformation(extent={{72,-50},{92,-30}})));
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
  ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components.Wall.wall Wall(
    cp_w=cpw,
    L_total=Ltotal,
    M_w=Mw,
    TstartWall=TstartWall,
    n=2) annotation (Placement(transformation(extent={{-18,-24},{22,24}})));
  ThermoCycle.Interfaces.Fluid.Flange_Cdot InFlowSF
    annotation (Placement(transformation(extent={{72,44},{92,64}}),
        iconTransformation(extent={{72,44},{92,64}})));

/* GEOMETRIES */
 final parameter Integer  nCV= 2;
  parameter Modelica.Units.SI.Area AA=0.0019 "Channel cross section";
  parameter Modelica.Units.SI.Length YY "Channel perimeter";
  parameter Modelica.Units.SI.Length Ltotal=500
    "Total length of the heat exchanger";

parameter Boolean VoidFraction = true
    "Set to true to calculate the void fraction to false to keep it constant";
    parameter Real VoidF = 0.8 "Constantat void fraction" annotation (Dialog(enable= not VoidFraction));

    /* WALL */
  parameter Modelica.Units.SI.SpecificHeatCapacity cpw
    "Specific heat capacity (constant)"
    annotation (Dialog(group="Metal Wall", __Dymola_label="Cp wall:"));
  parameter Modelica.Units.SI.Mass Mw "Total mass flow of the wall"
    annotation (Dialog(group="Metal Wall", __Dymola_label="Mass wall:"));

  /* BOOLEAN */
parameter Boolean epsNTU_sf = false "SF-wall :If True use eps-NTU " annotation (Dialog(group = "Heat transfer"));
parameter Boolean epsNTU_pf = false "PF-wall :If True use eps-NTU  " annotation (Dialog(group = "Heat transfer"));
parameter Boolean counterCurrent = true
    "If true countercurrent - PARALLEL FLOW NOT STABLE";

    /* HEAT TRANSFER */
  parameter Modelica.Units.SI.MassFlowRate Mdotnom=0 "Nominal fluid flow rate"
    annotation (Dialog(group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UnomSC=2500
    "SC - Nominal heat transfer coefficient"
    annotation (Dialog(group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UnomTP=9000
    "TP - Nominal heat transfer coefficient"
    annotation (Dialog(group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer Unomsf=1000
    "TP - Nominal heat transfer coefficient"
    annotation (Dialog(group="Heat transfer"));

/* INITIAL VALUES */
  parameter Modelica.Units.SI.Pressure pstart=6e6 "Fluid pressure start value"
    annotation (Dialog(tab="Initialization"));
parameter Medium.SpecificEnthalpy hstartTP=1E5 "TP: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Length lstartTP=1 "TP:Start value of length"
    annotation (Dialog(tab="Initialization"));

parameter Medium.SpecificEnthalpy hstartSC=1E5 "SC: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Length lstartSC=1 "SC:Start value of length"
    annotation (Dialog(tab="Initialization"));

    /* initialization wall */
  parameter Modelica.Units.SI.Temperature TstartWall[nCV]
    "Start temperature of the wall"
    annotation (Dialog(tab="Initialization", group="Wall"));
parameter Boolean SteadyStateWall = false
    "If true set Twall to zero during initialization"                                      annotation (Dialog(tab="Initialization",group= "Wall"));

    /* initialization secondary fluid */
  parameter Modelica.Units.SI.Temperature Tstartsf
    "Start value for average temperature of inlet cell"
    annotation (Dialog(tab="Initialization", group="Secondary fluid"));
  parameter Modelica.Units.SI.Temperature DTstartsf
    "Delta T to initialize second and third volume average temperature"
    annotation (Dialog(tab="Initialization", group="Secondary fluid"));

    /* Steady state working fluid */
parameter Medium.SpecificEnthalpy h_pf_out = 1E5
    "Outlet enthalpy of the primary fluid"                                                 annotation(Dialog(tab="Initialization", enable= Set_h_pf_out, group= "Primary fluid"));
parameter Boolean SteadyStatePF = false
    "If true set length and h_out derivative of PF to zero"                                     annotation(Dialog(tab="Initialization",group= "Primary fluid"));
parameter Boolean Set_h_pf_out = false
    "If true set PF outlet enthalpy during initialization equal to h_pf_out"                annotation(Dialog(tab="Initialization",group= "Primary fluid"));

equation
    /* If statement to allow parallel or counter current structure*/
if counterCurrent then
connect( Wall.QmbOut, secondaryFluid.mbIn[nCV:-1:1]);
else
  connect(Wall.QmbOut, secondaryFluid.mbIn);
end if;
  connect(secondaryFluid.InFlow_sf, InFlowSF) annotation (Line(
      points={{26.8,80},{54,80},{54,54},{82,54}},
      color={255,0,0},
      smooth=Smooth.None));

initial equation
  if SteadyStateWall then
    der(Wall.Tw) = {0,0};
  end if;
if SteadyStatePF then
    der(CondFlooded.volumeTP.ll) = 0;
    der(CondFlooded.volumeSC.h_b) = 0;
  end if;
  if Set_h_pf_out then
    CondFlooded.volumeSC.h_b = h_pf_out;
  end if;
public
  record SummaryClass
    replaceable Arrays T_profile;
     record Arrays
      Modelica.Units.SI.Temperature[6] Twf;
      Modelica.Units.SI.Temperature[6] Tw;
      Modelica.Units.SI.Temperature[6] Tsf;
     end Arrays;
    Modelica.Units.SI.Length[6] l_cell;
    Modelica.Units.SI.Power Qwf;
    Modelica.Units.SI.Power Qsf;
  end SummaryClass;
  SummaryClass Summary(T_profile(Twf = CondFlooded.Summary.T_profile.T_cell[:],Tw= Wall.Summary.T_profile.T_cell[:], Tsf = secondaryFluid.Summary.T_profile.T_cell[:]),l_cell = CondFlooded.Summary.l_cell[:],Qwf = CondFlooded.Summary.Qtot,Qsf = secondaryFluid.Summary.Qtot);

equation
  connect(Wall.QmbIn, CondFlooded.mbOut) annotation (Line(
      points={{0.4,-21.6},{0.4,-48},{11,-48},{11,-54.6667}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(InflowPF, CondFlooded.InFlow) annotation (Line(
      points={{-98,-36},{-62,-36},{-62,-83.3333},{-22.6667,-83.3333}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(CondFlooded.OutFlow, OutflowPF) annotation (Line(
      points={{38,-82},{82,-82},{82,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                        graphics),Icon(coordinateSystem(extent={{-100,-60},{80,
            80}},  preserveAspectRatio=false),
                                     graphics={
                               Bitmap(extent={{-100,110},{82,-94}}, fileName="modelica://ThermoCycle/Resources/Images/MB/Cond_F.png")}));
end CondFwInc;
