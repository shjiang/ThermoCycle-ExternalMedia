within ThermoCycle.Components.Units.ExpansionAndCompressionMachines.Reciprocating.BaseClasses;
partial record SimpleGeometry "Simple geometry"
  extends
    ThermoCycle.Components.Units.ExpansionAndCompressionMachines.Reciprocating.BaseClasses.BaseGeometry(
    final d_ppin=0,
    final crankArm(height=0.5*stroke),
    final piston(radius=0.5*bore,height=bore),
    final conrod(height=l_conrod),
    crankShaft(height=0.2));
  parameter Modelica.Units.SI.Length l_conrod(displayUnit="mm")
    "Length of connection rod";
  parameter Modelica.Units.SI.Length stroke(displayUnit="mm") "Stroke length";
  parameter Modelica.Units.SI.Length bore(displayUnit="mm") "Cylinder bore";
  parameter Modelica.Units.SI.Volume V_tdc(displayUnit="ml")
    "ml=cm^3 - clearance volume";
  annotation (Documentation(info="<html>
<p>This is a simplified geometry definition assuming no piston pin offset. This allows us to define the geometry using the well-established quantities stroke and bore. </p>
</html>"));
end SimpleGeometry;
