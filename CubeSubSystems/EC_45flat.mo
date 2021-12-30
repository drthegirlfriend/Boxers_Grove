within CubeSubSystems;

model EC_45flat "Maxon Motor 45Flat plus Escon current controller"
  parameter Modelica.Mechanics.MultiBody.Types.Axis n = {0, 1, 0} "Rotational Axis of motor rotor";
  parameter Boolean animation = true "Enable rotor animation";
  parameter Boolean useSupport = true "Enable Motor Housing Support";
  parameter Modelica.Mechanics.MultiBody.Types.Color colour "Colour of Rotor";
  parameter Modelica.SIunits.Mass m "Mass of Motor";
  //  Modelica.Electrical.Analog.Basic.RotationalEMF emf1(k = 0.0335) annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.EMF ElectricMotorForce(k = 0.0335, useSupport = useSupport) annotation(Placement(visible = true, transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -1080)));
  Modelica.Mechanics.MultiBody.Parts.Rotor1D.RotorWith3DEffects RotorInertia3D(J = 0.0000135, animation = animation, n = n, cylinderLength = 0.006, cylinderDiameter = 0.109, cylinderColor = {100, 100, 100}, w.start = 0) annotation(Placement(visible = true, transformation(origin = {150, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -360)));
  Modelica.Electrical.Analog.Sources.SignalVoltage VoltageSource annotation(Placement(visible = true, transformation(origin = {-50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 450)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor AmpMeter annotation(Placement(visible = true, transformation(origin = {60, 60}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Electrical.Analog.Basic.Inductor L(L.displayUnit = "mH", L = 0.000572) annotation(Placement(visible = true, transformation(origin = {20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R(R = 1.03) annotation(Placement(visible = true, transformation(origin = {-15, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(Placement(visible = true, transformation(origin = {-110, 30}, extent = {{10, -10}, {-10, 10}}, rotation = -180)));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-215, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b w annotation(Placement(visible = true, transformation(origin = {200, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a HousingMount annotation(Placement(visible = true, transformation(origin = {150, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -450), iconTransformation(origin = {-50, -90}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.PointMass motor_mass(m = m, animation = false, sphereDiameter = 0.02, sphereColor = {255, 0, 255}) annotation(Placement(visible = true, transformation(origin = {170, -17.237}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia RotorInertia(J = 0.0000135) if false annotation(Placement(visible = true, transformation(origin = {150, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Support support if useSupport annotation(Placement(visible = true, transformation(origin = {70, -55}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -85.533}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape bodyshape(shapeType = "cylinder", lengthDirection = n, length = 0.02, width = 0.045, height = 0.045, animation = animation, color = {100, 100, 100}) annotation(Placement(visible = true, transformation(origin = {125, -15}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
  Modelica.Blocks.Continuous.PID PIController(Ti = 1e-5, Td = 0, initType = Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState) annotation(Placement(visible = true, transformation(origin = {-80, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter CurrentLimit(uMax = 2.2) annotation(Placement(visible = true, transformation(origin = {-172.032, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.DeadZone DeadZone(uMax = 0.1, uMin = -0.11) annotation(Placement(visible = true, transformation(origin = {-140, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  //connect(emf1.flange, rotor.flange_a) annotation(Line(visible = true, origin = {10, 30}, points = {{-10, 0}, {10, 0}}));
  connect(VoltageSource.p, R.p) annotation(Line(visible = true, origin = {-41.667, 53.333}, points = {{-8.333, -13.333}, {-8.333, 6.667}, {16.667, 6.667}}));
  connect(R.n, L.p) annotation(Line(visible = true, origin = {2.5, 60}, points = {{-7.5, 0}, {7.5, 0}}));
  connect(L.n, AmpMeter.p) annotation(Line(visible = true, origin = {40, 60}, points = {{-10, 0}, {10, 0}}));
  connect(AmpMeter.n, ElectricMotorForce.p) annotation(Line(visible = true, origin = {83.333, 53.333}, points = {{-13.333, 6.667}, {6.667, 6.667}, {6.667, -13.333}}));
  connect(ElectricMotorForce.n, VoltageSource.n) annotation(Line(visible = true, origin = {10, 17.115}, points = {{80, 2.885}, {80, -17.115}, {-60, -17.115}, {-60, 2.885}}));
  connect(ground.p, VoltageSource.n) annotation(Line(visible = true, origin = {-50, 0}, points = {{0, -20}, {0, 20}}));
  connect(AmpMeter.i, feedback.u2) annotation(Line(visible = true, origin = {-25, 64.5}, points = {{85, 5.5}, {85, 10.5}, {-85, 10.5}, {-85, -26.5}}));
  connect(RotorInertia3D.flange_b, w) annotation(Line(visible = true, origin = {180, 30}, points = {{-20, 0}, {20, 0}}));
  connect(motor_mass.frame_a, HousingMount) annotation(Line(visible = true, origin = {163.333, -39.079}, points = {{6.667, 21.842}, {6.667, -10.921}, {-13.333, -10.921}}));
  connect(RotorInertia3D.frame_a, HousingMount) annotation(Line(visible = true, origin = {150, -15}, points = {{0, 35}, {0, -35}}));
  connect(ElectricMotorForce.flange, RotorInertia.flange_a) annotation(Line(visible = true, origin = {112.5, 45}, points = {{-12.5, -15}, {-7.5, -15}, {-7.5, 15}, {27.5, 15}}));
  connect(RotorInertia.flange_b, w) annotation(Line(visible = true, origin = {186.667, 50}, points = {{-26.667, 10}, {13.333, 10}, {13.333, -20}}));
  connect(ElectricMotorForce.flange, RotorInertia3D.flange_a) annotation(Line(visible = true, origin = {120, 30}, points = {{-20, 0}, {20, 0}}));
  connect(ElectricMotorForce.support, support) annotation(Line(visible = true, origin = {73.333, 1.667}, points = {{6.667, 28.333}, {-3.333, 28.333}, {-3.333, -56.667}}));
  connect(bodyshape.frame_a, HousingMount) annotation(Line(visible = true, origin = {133.333, -41.667}, points = {{-8.333, 16.667}, {-8.333, -8.333}, {16.667, -8.333}}));
  connect(PIController.y, VoltageSource.v) annotation(Line(visible = true, origin = {-63, 30}, points = {{-6, 0}, {6, 0}}));
  connect(feedback.y, PIController.u) annotation(Line(visible = true, origin = {-96.5, 30}, points = {{-4.5, 0}, {4.5, 0}}));
  connect(u, CurrentLimit.u) annotation(Line(visible = true, origin = {-199.516, 30}, points = {{-15.484, 0}, {15.484, 0}}));
  connect(DeadZone.y, feedback.u1) annotation(Line(visible = true, origin = {-123.5, 30}, points = {{-5.5, 0}, {5.5, 0}}));
  connect(CurrentLimit.y, DeadZone.u) annotation(Line(visible = true, origin = {-156.516, 30}, points = {{-4.516, 0}, {4.516, 0}}));
  annotation(Diagram(coordinateSystem(extent = {{-220, -60}, {220, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Rectangle(visible = true, origin = {0, 19.5}, fillColor = {156, 187, 183}, fillPattern = FillPattern.Solid, extent = {{-220, -80.5}, {220, 80.5}}), Rectangle(visible = true, origin = {-126.682, 28.386}, fillColor = {169, 169, 169}, fillPattern = FillPattern.Solid, extent = {{-61.682, -21.614}, {61.682, 21.614}})}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Text(visible = true, textColor = {64, 64, 64}, extent = {{-150, 110}, {150, 150}}, textString = "%name"), Text(visible = true, origin = {1.396, 5}, extent = {{-28.604, -35}, {28.604, 35}}, textString = " bldc"), Rectangle(visible = true, origin = {5, 0}, fillColor = {84, 211, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-35, -70}, {35, 70}}), Rectangle(visible = true, origin = {45, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-5, -60}, {5, 60}}), Rectangle(visible = true, origin = {56.06, 0}, fillColor = {84, 211, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-6.06, -70}, {6.06, 70}}), Rectangle(visible = true, origin = {81.06, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-18.94, -10}, {18.94, 10}}), Rectangle(visible = true, origin = {-47.5, 0}, fillColor = {84, 211, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-12.5, -70}, {12.5, 70}}), Rectangle(visible = true, origin = {-32.417, -15.485}, fillColor = {0, 128, 0}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-2.417, -78.989}, {2.417, 78.989}})}));
end EC_45flat;
