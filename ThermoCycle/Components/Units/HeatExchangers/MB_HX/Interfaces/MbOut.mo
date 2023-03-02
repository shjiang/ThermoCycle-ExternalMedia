within ThermoCycle.Components.Units.HeatExchangers.MB_HX.Interfaces;
connector MbOut

// parameter Integer n = 1;
  Modelica.Units.SI.Temperature T;
  flow Modelica.Units.SI.Power Q_flow;
  output Modelica.Units.SI.Length ll;
 output Real Cdot;
end MbOut;
