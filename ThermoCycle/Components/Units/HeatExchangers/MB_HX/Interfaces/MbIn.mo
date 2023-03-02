within ThermoCycle.Components.Units.HeatExchangers.MB_HX.Interfaces;
connector MbIn
 // parameter Integer n = 1;
  Modelica.Units.SI.Temperature T;
  flow Modelica.Units.SI.Power Q_flow;
  input Modelica.Units.SI.Length ll;
 input Real Cdot;
end MbIn;
