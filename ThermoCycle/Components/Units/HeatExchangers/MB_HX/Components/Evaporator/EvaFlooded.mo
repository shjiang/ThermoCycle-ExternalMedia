within ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components.Evaporator;
model EvaFlooded
 replaceable package Medium =
      ThermoCycle.Media.DummyFluid constrainedby
    Modelica.Media.Interfaces.PartialMedium
                                           annotation (choicesAllMatching=true);

 /* Components */
  Cells.OnePhase volumeSC(
    redeclare final package Medium = Medium,
    pstart=pstart,
    hstart=hstartSC,
    lstart=lstartSC,
    Mdotnom=Mdotnom,
    Unom=UnomSC,
    AA=AA,
    alone=false,
    YY=YY,
    subcooled=true,
    eps_NTU=eps_NTU,
    Ltotal=Ltotal)
    annotation (Placement(transformation(extent={{-48,-12},{-28,8}})));
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
    Flooded=true,
    General=false,
    VoidFraction=VoidFraction,
    VoidF=VoidF)
    annotation (Placement(transformation(extent={{24,-12},{44,8}})));
  ThermoCycle.Interfaces.Fluid.FlangeA InFlow(redeclare final package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-110,0},{-90,20}}),
        iconTransformation(extent={{-110,0},{-90,20}})));
  ThermoCycle.Interfaces.Fluid.FlangeB OutFlow(  redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{70,0},{90,20}}),
        iconTransformation(extent={{70,0},{90,20}})));

import ThermoCycle.Components.Units.HeatExchangers.MB_HX.Records;

/* Parameters */
final parameter Integer  nCV= 2;
  parameter Modelica.Units.SI.Area AA=0.0019 "Channel cross section";
  parameter Modelica.Units.SI.Length YY=1.57 "Channel perimeter";
  parameter Modelica.Units.SI.Length Ltotal=500
    "Total length of the heat exchanger";

parameter Boolean VoidFraction = true
    "Set to true to calculate the void fraction to false to keep it constant";
parameter Real VoidF = 0.8 "Constantat void fraction" annotation (Dialog(enable= not VoidFraction));

    /* Heat transfer */
  parameter Modelica.Units.SI.MassFlowRate Mdotnom=0 "Nominal fluid flow rate"
    annotation (Dialog(group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UnomSC=2500
    "SC - Nominal heat transfer coefficient"
    annotation (Dialog(group="Heat transfer"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UnomTP=9000
    "TP - Nominal heat transfer coefficient"
    annotation (Dialog(group="Heat transfer"));
parameter Boolean eps_NTU = false "Set to true for eps-NTU heat transfer" annotation (Dialog(group = "Heat transfer"));

  /* Initial values */
  parameter Modelica.Units.SI.Pressure pstart=6e6 "Fluid pressure start value"
    annotation (Dialog(tab="Initialization"));
  parameter Medium.SpecificEnthalpy hstartSC=1E5 "SC: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Length lstartSC=1 "SC:Start value of length"
    annotation (Dialog(tab="Initialization"));
  parameter Medium.SpecificEnthalpy hstartTP=1E5 "TP: Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Length lstartTP=1 "TP:Start value of length"
    annotation (Dialog(tab="Initialization"));

  Records.Mode mode[nCV];
   /* Summary Class variables */
  Modelica.Units.SI.Temperature[6] Temp;
  Modelica.Units.SI.Length[6] length;
  Modelica.Units.SI.Power[nCV] q_dot;
  Modelica.Units.SI.Power qtot;
  Interfaces.MbOut mbOut[nCV]
    annotation (Placement(transformation(extent={{-14,28},{6,48}}),
        iconTransformation(extent={{-28,36},{6,48}})));
equation
  volumeSC.mode = mode[nCV-1];
  volumeTP.mode = mode[nCV];

  mode[nCV - 1] = Constants.ModeCompound;
  mode[nCV] = Constants.ModeCompound;
  /* Geometric constraints */
  volumeSC.ll + volumeTP.ll = Ltotal;
  volumeSC.la = 0;
  volumeSC.lb = volumeTP.la;

  /* Equations for  SummaryClass variables*/
for i in 1:3 loop
  Temp[i] =  volumeSC.Temp[i];
  length[i] = volumeSC.length[i];
  end for;
  for i in 4:6 loop
   Temp[i] = volumeTP.Temp[i-3];
   length[i] = volumeTP.length[i-3];
  end for;
   q_dot[1] = volumeSC.q_dot;
   q_dot[2] = volumeTP.q_dot;
   qtot = sum(q_dot[:]);
public
  record SummaryClass
    replaceable Arrays T_profile;
     record Arrays
      Modelica.Units.SI.Temperature[6] T_cell;
     end Arrays;
    Modelica.Units.SI.Length[6] l_cell;
    Modelica.Units.SI.Power[2] Qflow;
    Modelica.Units.SI.Power Qtot;
  end SummaryClass;
  SummaryClass Summary(T_profile(T_cell = Temp[:]),l_cell = length[:],Qflow=q_dot[:],Qtot=qtot);

equation
  connect(InFlow, volumeSC.inFlow) annotation (Line(
      points={{-100,10},{-76,10},{-76,-2},{-48,-2}},
      color={0,0,255},
      smooth=Smooth.None));

  connect(volumeTP.outFlow,OutFlow)  annotation (Line(
      points={{44,-1.9},{68,-1.9},{68,10},{80,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(volumeSC.outFlow, volumeTP.inFlow) annotation (Line(
      points={{-28,-1.9},{-8,-1.9},{-8,-2},{24,-2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(volumeSC.mbOut, mbOut[1]) annotation (Line(
      points={{-38,7},{-38,20},{-8,20},{-8,33},{-4,33}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(volumeTP.mbOut, mbOut[2]) annotation (Line(
      points={{34,7},{34,24},{-4,24},{-4,43}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-20},
            {80,40}}),  graphics),Icon(coordinateSystem(extent={{-100,-20},{80,40}},
                   preserveAspectRatio=true),
                                     graphics={
                               Bitmap(extent={{-102,106},{80,-88}}, fileName="modelica://ThermoCycle/Resources/Images/MB/Eva_F_wf.png")}));
end EvaFlooded;
