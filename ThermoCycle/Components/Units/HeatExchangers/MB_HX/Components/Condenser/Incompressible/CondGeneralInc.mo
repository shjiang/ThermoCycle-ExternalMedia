within ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components.Condenser.Incompressible;
model CondGeneralInc
 replaceable package Medium =
      ThermoCycle.Media.DummyFluid constrainedby
    Modelica.Media.Interfaces.PartialMedium
                                           annotation (choicesAllMatching=true);

 /* Components */
   Interfaces.MbOut mbOut[nCV]
    annotation (Placement(transformation(extent={{-24,34},{20,52}})));
  Cells.OnePhaseInc volumeSC(
    redeclare final package Medium = Medium,
    pstart=pstart,
    hstart=hstartSC,
    lstart=lstartSC,
    Mdotnom=Mdotnom,
    Unom=UnomSC,
    AA=AA,
    alone=false,
    YY=YY,
    eps_NTU=eps_NTU,
    Ltotal=Ltotal,
    Type=false,
    subcooled=true)
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
  Cells.TwoPhase volumeTP(
    redeclare final package Medium = Medium,
    pstart=pstart,
    hstart=hstartTP,
    lstart=lstartTP,
    Mdotnom=Mdotnom,
    Unom=UnomTP,
    AA=AA,
    alone=false,
    YY=YY,
    Ltotal=Ltotal,
    final Type=false,
    VoidFraction=VoidFraction,
    VoidF=VoidF,
    Flooded=false,
    General=true)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  ThermoCycle.Interfaces.Fluid.FlangeA InFlow(redeclare final package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-112,-8},{-92,12}})));
  ThermoCycle.Interfaces.Fluid.FlangeB OutFlow(  redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{76,-8},{96,12}})));

  Cells.OnePhaseInc volumeSH(
    redeclare final package Medium = Medium,
    pstart=pstart,
    Mdotnom=Mdotnom,
    AA=AA,
    alone=false,
    YY=YY,
    eps_NTU=eps_NTU,
    Ltotal=Ltotal,
    Type=false,
    Unom=UnomSH,
    hstart=hstartSH,
    lstart=lstartSH,
    subcooled=false)
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));

import ThermoCycle.Components.Units.HeatExchangers.MB_HX.Records;

/* Parameters */
final parameter Integer  nCV= 3;
  parameter Modelica.Units.SI.Area AA=0.0019 "Channel cross section";
  parameter Modelica.Units.SI.Length YY=1.57 "Channel perimeter";
  parameter Modelica.Units.SI.Length Ltotal=500
    "Total length of the heat exchanger";
parameter Boolean VoidFraction = true
    "Set to true to calculate the void fraction to false to keep it constant";
    parameter Real VoidF = 0.8 "Constantat void fraction" annotation (Dialog(enable= not VoidFraction));

/* Heat transfer */
parameter Boolean eps_NTU = false "Set to true for eps-NTU heat transfer" annotation (Dialog(group = "Heat transfer"));
  parameter Modelica.Units.SI.MassFlowRate Mdotnom=0 "Nominal fluid flow rate"
    annotation (Dialog(group="Heat transfer"));

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UnomSH=3000
    annotation (Dialog(group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UnomTP=9000
    annotation (Dialog(group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UnomSC=2500
    annotation (Dialog(group="Heat transfer"));

  /* Initial values */
  parameter Modelica.Units.SI.Pressure pstart=6e6 "Fluid pressure start value"
    annotation (Dialog(tab="Initialization"));

  parameter Modelica.Units.SI.Length lstartSH=1 "SH:Start value of length"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Length lstartTP=1 "TP:Start value of length"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Length lstartSC=1 "SC:Start value of length"
    annotation (Dialog(tab="Initialization"));

parameter Medium.SpecificEnthalpy hstartSH=1E5 "TP: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));
parameter Medium.SpecificEnthalpy hstartTP=1E5 "TP: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));
parameter Medium.SpecificEnthalpy hstartSC=1E5 "SC: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));

  Records.Mode mode[nCV];
/* Summary Class variables */
  Modelica.Units.SI.Temperature[9] Temp;
  Modelica.Units.SI.Length[9] length;
  Modelica.Units.SI.Power[nCV] q_dot;
  Modelica.Units.SI.Power qtot;
equation
  volumeSC.mode = mode[nCV-2];
  volumeTP.mode = mode[nCV-1];
  volumeSH.mode = mode[nCV];

  mode[nCV - 2] = Constants.ModeCompound;
  mode[nCV - 1] = Constants.ModeCompound;
  mode[nCV] = Constants.ModeCompound;
  /* Geometric constraints */
  volumeSC.ll + volumeTP.ll + volumeSH.ll = Ltotal;
  volumeSC.la = 0;

   volumeSC.lb = volumeTP.la;
   volumeTP.lb = volumeSH.la;

/* Equations for  SummaryClass variables*/
for i in 1:3 loop
  Temp[i] =  volumeSH.Temp[i];
  length[i] = volumeSH.length[i];
end for;
for i in 4:6 loop
  Temp[i] =  volumeTP.Temp[i-3];
  length[i] = volumeTP.length[i-3];
end for;
  for i in 7:9 loop
   Temp[i] = volumeSC.Temp[i-6];
   length[i] = volumeSC.length[i-6];
  end for;

   q_dot[1] = volumeSH.q_dot;
   q_dot[2] = volumeTP.q_dot;
   q_dot[3] = volumeSC.q_dot;
   qtot = sum(q_dot[:]);
public
  record SummaryClass
    replaceable Arrays T_profile;
     record Arrays
      Modelica.Units.SI.Temperature[9] T_cell;
     end Arrays;
    Modelica.Units.SI.Length[9] l_cell;
    Modelica.Units.SI.Power[3] Qflow;
    Modelica.Units.SI.Power Qtot;
  end SummaryClass;
  SummaryClass Summary(T_profile(T_cell = Temp[:]),l_cell = length[:],Qflow=q_dot[:],Qtot=qtot);

equation
  connect(volumeTP.mbOut, mbOut[2]) annotation (Line(
      points={{10,9},{10,12},{0,12},{0,46},{-2,46},{-2,43}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(InFlow, volumeSH.inFlow) annotation (Line(
      points={{-102,2},{-72,2},{-72,0},{-46,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(volumeSH.outFlow, volumeTP.inFlow) annotation (Line(
      points={{-26,0.1},{-13,0.1},{-13,0},{0,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(volumeSH.mbOut, mbOut[1]) annotation (Line(
      points={{-36,9},{-36,26},{-16.6667,26},{-16.6667,43}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(volumeTP.outFlow, volumeSC.inFlow) annotation (Line(
      points={{20,0.1},{32,0.1},{32,0},{44,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(volumeSC.outFlow,OutFlow)  annotation (Line(
      points={{64,0.1},{77,0.1},{77,2},{86,2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mbOut[3], volumeSC.mbOut) annotation (Line(
      points={{12.6667,43},{12.6667,26},{54,26},{54,9}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-20},
            {80,40}}),  graphics),Icon(coordinateSystem(extent={{-100,-20},{80,40}},
                   preserveAspectRatio=true),
                                     graphics={
                               Bitmap(extent={{-102,106},{80,-88}}, fileName="modelica://ThermoCycle/Resources/Images/MB/Cond_G_wf.png")}));
end CondGeneralInc;
