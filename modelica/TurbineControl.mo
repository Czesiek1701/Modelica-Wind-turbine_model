model TurbineControl
  inner WindTurbinePackage.WindSource windSource(nin = 3)  annotation(
    Placement(transformation(origin = {88, -50}, extent = {{-10, -10}, {10, 10}})));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(transformation(origin = {88, -90}, extent = {{-10, -10}, {10, 10}})));
  WindTurbinePackage.Rotor rotor(BLADE_PARAMETERS_FILE = "D:/OM_Turbine/NREL/WPC_NRELp3_v20.txt", blade_r_CM = {0, 0, 5}, blade_m = 100, blade_I_21 = 0.001, blade_I_31 = 0.001, blade_I_32 = 0.001, LIMIT_INDUCTION_COEFFICIENT = true, AIRFOIL_CHARACTERISTICS_SMOOTHNESS = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, AIRFOIL_CHARACTERISTICS_EXTRAPOLATION = Modelica.Blocks.Types.Extrapolation.LastTwoPoints, correction_Spera = 1, correction_Glauert = true)  annotation(
    Placement(transformation(origin = {-56.05, 51.8571}, extent = {{-15.45, -44.1429}, {15.45, 44.1429}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(useAxisFlange = true, w(start = 7), n = {1, 0, 0})  annotation(
    Placement(transformation(origin = {-28, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r = {0, 0, 25})  annotation(
    Placement(transformation(origin = {50, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange = true, phi(start = 0)) annotation(
    Placement(transformation(origin = {50, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r = {5, 0, 0})  annotation(
    Placement(transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 10)  annotation(
    Placement(transformation(origin = {-38, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 13, duration = 10000, offset = 3)  annotation(
    Placement(transformation(origin = {28, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position position(useSupport = true)  annotation(
    Placement(transformation(origin = {22, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Ramp ramp11(duration = 10000, height = 0, offset = 0) annotation(
    Placement(transformation(origin = {23, -17}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Sources.Speed speed_shaft(phi(fixed = false), useSupport = true) annotation(
    Placement(transformation(origin = {-120, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp source_speed(duration = 1000, height = 0, offset = 71.6*3.14/30, startTime = 0) annotation(
    Placement(transformation(origin = {-156, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 10000, height = 0, offset = 0) annotation(
    Placement(transformation(origin = {28, -80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp3(duration = 10000, height = 0, offset = 25) annotation(
    Placement(transformation(origin = {28, -110}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation(
    Placement(transformation(origin = {-78, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape(r = {0, 0, 0}, r_CM = {0, 0, 0}, m = 5000, I_11 = 1000, I_22 = 1000, I_33 = 1000)  annotation(
    Placement(transformation(origin = {90, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Add add(k1 = +1, k2 = -1)  annotation(
    Placement(transformation(origin = {-114, -92}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 3.14/180/1000)  annotation(
    Placement(transformation(origin = {-82, -92}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Derivative derivative annotation(
    Placement(transformation(origin = {-114, -64}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LowpassButterworth lowpassButterworth(f = 0.1, initType = Modelica.Blocks.Types.Init.SteadyState)  annotation(
    Placement(transformation(origin = {-158, -64}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Sign sign1 annotation(
    Placement(transformation(origin = {-82, -66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.PID PID(initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 3.14/180, k = 1, Ti = 0.8, Td = 0.5)  annotation(
    Placement(transformation(origin = {-46, -92}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp nom_power(duration = 10000, height = 0, offset = 8000) annotation(
    Placement(transformation(origin = {-160, -102}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 10000, height = 0, offset = 3*3.14/180) annotation(
    Placement(transformation(origin = {-104, 32}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(fixed.frame_b, revolute1.frame_a) annotation(
    Line(points = {{50, 2}, {50, 18}}, color = {95, 95, 95}));
  connect(revolute.frame_a, fixedTranslation.frame_b) annotation(
    Line(points = {{-18, 52}, {-10, 52}}, color = {95, 95, 95}));
  connect(revolute.frame_b, rotor.frame_a) annotation(
    Line(points = {{-38, 52}, {-48, 52}}, color = {95, 95, 95}));
  connect(inertia.flange_b, revolute.axis) annotation(
    Line(points = {{-28, -10}, {-28, 42}}));
  connect(ramp.y, windSource.wind_global_args[1]) annotation(
    Line(points = {{39, -50}, {76, -50}}, color = {0, 0, 127}));
  connect(ramp11.y, position.phi_ref) annotation(
    Line(points = {{23, -9.3}, {22, -9.3}, {22, -0.3}}, color = {0, 0, 127}));
  connect(source_speed.y, speed_shaft.w_ref) annotation(
    Line(points = {{-145, -10}, {-132, -10}}, color = {0, 0, 127}));
  connect(ramp2.y, windSource.wind_global_args[2]) annotation(
    Line(points = {{39, -80}, {59, -80}, {59, -50}, {75, -50}}, color = {0, 0, 127}));
  connect(ramp3.y, windSource.wind_global_args[3]) annotation(
    Line(points = {{39, -110}, {63, -110}, {63, -50}, {75, -50}}, color = {0, 0, 127}));
  connect(position.support, revolute1.support) annotation(
    Line(points = {{32, 12}, {38, 12}, {38, 22}, {40, 22}}));
  connect(fixed.frame_b, bodyShape.frame_a) annotation(
    Line(points = {{50, 2}, {90, 2}, {90, 18}}, color = {95, 95, 95}));
  connect(revolute1.frame_b, fixedTranslation.frame_a) annotation(
    Line(points = {{50, 38}, {50, 52}, {10, 52}}, color = {95, 95, 95}));
  connect(revolute1.axis, position.flange) annotation(
    Line(points = {{40, 28}, {22, 28}, {22, 22}}));
  connect(speed_shaft.support, revolute.support) annotation(
    Line(points = {{-120, -20}, {-120, -30}, {-22, -30}, {-22, 42}}));
  connect(powerSensor.flange_a, inertia.flange_a) annotation(
    Line(points = {{-68, -10}, {-48, -10}}));
  connect(add.y, gain.u) annotation(
    Line(points = {{-103, -92}, {-95, -92}}, color = {0, 0, 127}));
  connect(speed_shaft.flange, powerSensor.flange_b) annotation(
    Line(points = {{-110, -10}, {-88, -10}}));
  connect(powerSensor.power, lowpassButterworth.u) annotation(
    Line(points = {{-70, 2}, {-70, 10}, {-184, 10}, {-184, -64}, {-170, -64}}, color = {0, 0, 127}));
  connect(lowpassButterworth.y, derivative.u) annotation(
    Line(points = {{-146, -64}, {-126, -64}}, color = {0, 0, 127}));
  connect(lowpassButterworth.y, add.u1) annotation(
    Line(points = {{-146, -64}, {-142, -64}, {-142, -86}, {-126, -86}}, color = {0, 0, 127}));
  connect(derivative.y, sign1.u) annotation(
    Line(points = {{-102, -64}, {-94, -64}, {-94, -66}}, color = {0, 0, 127}));
  connect(gain.y, PID.u) annotation(
    Line(points = {{-70, -92}, {-58, -92}}, color = {0, 0, 127}));
  connect(nom_power.y, add.u2) annotation(
    Line(points = {{-149, -102}, {-138, -102}, {-138, -98}, {-126, -98}}, color = {0, 0, 127}));
  connect(ramp1.y, rotor.pitch) annotation(
    Line(points = {{-92, 32}, {-68, 32}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram);
end TurbineControl;
