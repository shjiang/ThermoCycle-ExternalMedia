within ThermoCycle.Media;
package R290_CP "R290, computation of Propane Properties using CoolProp"
  extends ExternalMedia.Media.CoolPropMedium(
    mediumName="TestMedium",
    substanceNames={"propane"},
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph);

  annotation ();
end R290_CP;
