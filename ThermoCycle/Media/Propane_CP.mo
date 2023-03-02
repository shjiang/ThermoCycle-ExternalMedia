within ThermoCycle.Media;
package Propane_CP "Propane - Coolprop  - TC"
  extends ExternalMedia.Media.CoolPropMedium(
    mediumName="propane",
    substanceNames={"propane"},
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph);
end Propane_CP;
