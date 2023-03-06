within ExternalMedia;
package MyTests
  model TestFunc "test the coolprop fuction directly here"
    ThermodynamicState state;
  equation
    state = setState_ph(1e6,2e5,0,"My","CoolProp","REFPROP::CO2[0.7]&R125[0.3]|calc_transport=1|debug=true");
    annotation (Icon(graphics={Ellipse(extent={{-70,76},{78,-68}}, lineColor={
                28,108,200}), Text(
            extent={{-62,52},{70,-52}},
            textColor={238,46,47},
            textString="T")}));
  end TestFunc;

  function setState_ph
      "Return thermodynamic state record from p and h"

    input Modelica.Media.Interfaces.Types.AbsolutePressure p "pressure";
    input Modelica.Media.Interfaces.Types.SpecificEnthalpy h "specific enthalpy";
    input Modelica.Media.Interfaces.Types.FixedPhase phase "2 for two-phase, 1 for one-phase, 0 if not known";
    input String mediumName "Name of the medium";
    input String libraryName  "Name of the external fluid property computation library";
    input String substanceName;
    output ThermodynamicState state;
  external"C" TwoPhaseMedium_setState_ph_C_impl(
      p,
      h,
      phase,
      state,
      mediumName,
      libraryName,
      substanceName) annotation (
      Include="#include \"externalmedialib.h\"",
      Library="ExternalMediaLib",
      IncludeDirectory="modelica://ExternalMedia/Resources/Include",
      LibraryDirectory="modelica://ExternalMedia/Resources/Library");
  end setState_ph;

  record ThermodynamicState
    // Fields in ASCII lexicographical order to work in Dymola
    Modelica.Media.Interfaces.Types.Temperature T "temperature";
    Modelica.Media.Interfaces.Types.VelocityOfSound a "velocity of sound";
    Modelica.Units.SI.CubicExpansionCoefficient beta
      "isobaric expansion coefficient";
    Modelica.Media.Interfaces.Types.SpecificHeatCapacity cp
      "specific heat capacity cp";
    Modelica.Media.Interfaces.Types.SpecificHeatCapacity cv
      "specific heat capacity cv";
    Modelica.Media.Interfaces.Types.Density d "density";
    Modelica.Media.Interfaces.Types.DerDensityByEnthalpy ddhp
      "derivative of density wrt enthalpy at constant pressure";
    Modelica.Media.Interfaces.Types.DerDensityByPressure ddph
      "derivative of density wrt pressure at constant enthalpy";
    Modelica.Media.Interfaces.Types.DynamicViscosity eta "dynamic viscosity";
    Modelica.Media.Interfaces.Types.SpecificEnthalpy h "specific enthalpy";
    Modelica.Units.SI.Compressibility kappa "compressibility";
    Modelica.Media.Interfaces.Types.ThermalConductivity lambda
      "thermal conductivity";
    Modelica.Media.Interfaces.Types.AbsolutePressure p "pressure";
    Modelica.Media.Interfaces.Types.FixedPhase phase(min=0, max=2)
      "phase flag: 2 for two-phase, 1 for one-phase";
    Modelica.Media.Interfaces.Types.SpecificEntropy s "specific entropy";
  end ThermodynamicState;

  model Unnamed

    package Medium = ExternalMedia.Media.CoolPropMedium (mediumName="REFPROP::Water");

    Medium.AbsolutePressure p1=8e6;
    Medium.SpecificEnthalpy h1=1.0e5;

    Medium.Density d;

  equation

    d = Medium.density_ph(
      p1,
      h1,
      0);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Unnamed;
end MyTests;
