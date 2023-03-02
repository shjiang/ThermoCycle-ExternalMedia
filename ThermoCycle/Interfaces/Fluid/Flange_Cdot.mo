within ThermoCycle.Interfaces.Fluid;
connector Flange_Cdot "Flange for a Cdot-type heat source"
  input Modelica.Units.SI.MassFlowRate Mdot "Mass flow rate";
  input Modelica.Units.SI.SpecificHeatCapacity cp "Specific Heat capacity";
  input Modelica.Units.SI.Density rho "Density of entering fluid";
  input Modelica.Units.SI.Temperature T "Temperature of entering fluid";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Ellipse(extent={{-100,100},{100,-100}},
            lineColor={255,0,0})}));
end Flange_Cdot;
