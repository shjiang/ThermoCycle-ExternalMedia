within ThermoCycle.Components.Units.HeatExchangers;
package MB_HX 


annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                        graphics),                             Documentation(info="<html>
<h1>MovingBoundary package</h1>
<p>The <b>MovingBoundary</b> library is an package for the modelling of heat exchanger involving two-phase flow with<br>
the moving boundary formulation.</p>
<p>The moving boundary model is developed following the object-oriented principles of abstraction, encapsulation and (limited) inheritance:<br>
two basic models are derived representing the fluid flow through a variable control volume in
single, <b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components.Cells.OnePhase\">OnePhase</a> </b>, 
and two phase state, <b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components.Cells.TwoPhase\">TwoPhase</a> </b>.<br>
The connection of these two basic models allows building <b>dry, flooded or general evaporator and condenser models</b>.<br>

<p>The general assumptions used to derive the base <b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components.Cells\">Cell models</a> </b> are reported hereunder:<\p>
<ul>
<li> The working fluid flow through a control volume of the heat exchanger is described with a mathematical formulation of the conservation laws of physics.<br>
Energy and mass balance are expressed considering the dynamic contribution. Given the low time constant characterizing the propagation of pressure throughout <br>
the heat exchanger compared to those related to mass and thermal energy transfer, a static momentum balance is assumed.<\li> 
<li> The heat exchanger is considered as a 1-dimensional tube (z-direction) through which the working fluid flows.<\li>
<li> Kinetic energy, gravitational forces and viscous stresses are neglected.<\li>
<li> No work is done on or generated by the fluid in the control volume.<\li>
<li> The cross section area is assumed constant throughout the heat exchanger length.<\li>
<li> The velocity of the fluid is uniform over the cross section area (homogeneous two-phase flow).<\li>
<li> Pressure drop through the heat exchanger are neglected (homogeneous pressure).<\li>
<li> The rate of thermal energy addition due to heat conduction is neglected in the fluid element.<\li>
<li> The rate of thermal energy addition by radiation is neglected in the fluid element.<\li>
<li> The rate of thermal energy exchanged with the ambient by convection is considered in the fluid element.<\li>
<li> Thermal energy accumulation is considered for the metal wall of the tube.<\li>
<li> Thermal energy conduction in the metal wall is neglected in the flow direction and considered static and infinite in the circumferential direction<br>
(the wall cross section area has instantaneously the same temperature).<\li>
<li> The enthalpy distribution  of the working fluid is assumed linear in each region of the tube (sub-cooled, two-phase, super-heated)<\li>
<li> In order to simplify the resolution of the model, no energy, mass and momentum accumulation is considered in the secondary fluid side.<\li> 
<li> The secondary fluid is assumed incompressible with a constant density and specific heat capacity throughout the length of the heat exchanger.<br>
A linear temperature distribution is assumed<\li>
<li> The thermal energy transfer with the metal wall is solved either with the semi-isothermal epsilon-NTU method or with Newton's law of cooling. <\li>
<li> A constant heat transfer coefficient is set in the secondary fluid side and in each region of the working fluid side.<\li>
<li> For the sake of simplicity and model robustness, no switching mechanism is implemented in the proposed MB formulation.<\li>
</ul>
</p>

<p> For a more detailed description of the moving boundary models included in the library together with the results of a comparison against the <b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.Hx1D\">finite volume approach</a> </b>, the interested user can refer to:<\p>
<p> A. Desideri, B. Dechesne, J. Wronski, M. Van Den Broek, S. Gusev, V. Lemort, S. Quoilin Comparison of moving boundary and finite-volume heat exchanger models in the Modelica Language, Energies (accepted for publications), 2016.

<h2>STRUCTURE</h2>
<p>The library is composed by 6 top-level package which are listed below: </p>
<ul>
<li><b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Components\">Components</a> </b>is the central part of the library. It is organized in six sub-packages: Cells, Wall, SecondaryFluid, Evaporator, Condenser and Reservoir.<br>
It contains all the models available in the library from the simple cell models  to complete model of the evaporator and the condenser. </li>
<li><b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Interfaces\">Interfaces</a> </b>contains the heat transfer connectors used in the library. </li>
<li><b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Functions\">Functions</a> </b>defines the functions used to compute the VoidFraction in the two-phase cell model.</li>
<li><b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Constants\">Constants</a> </b>defines the constants used in the models.</li>
<li><b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Records\">Records</a> </b> contains the Mode record used to define the conservation equations in the cell models.</li>
<li><b><a href=\"modelica://ThermoCycle.Components.Units.HeatExchangers.MB_HX.Tests\">Tests</a> </b> is the package where the models of the library are tested.<\br>
</ul>
</html>"), Icon(coordinateSystem(extent={{-100,-60},{80,
            80}},  preserveAspectRatio=false),
                                     graphics={
                               Bitmap(extent={{-102,110},{80,-92}}, fileName="modelica://ThermoCycle/Resources/Images/MB/Eva_G.png")}));
end MB_HX;
