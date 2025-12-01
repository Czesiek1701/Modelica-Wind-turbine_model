package WindTurbinePackage
  //AGH WIMiR 2024.09.01 Grzegorz Czaja
  //this function is a modification of Modelica.Utilities.Files.splitPathName

  package Examples
    model TestTower
      extends Modelica.Icons.Example;
      //parameter String BLADE_PARAMETERS_FILE = "D:/OM_Turbine/RISO/WPC_RISO_v16h.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/NREL/WPC_NRELp3_v16.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/ECN/WPC_ECN_base_v9.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/QBlade_test2/WPC_QBlade_test2.txt";
      parameter Real YAW = 0;
      parameter Real PITCH = 0;
      parameter Real TILT = 0;
      parameter Real RPM = 47.6;
      Modelica.Units.SI.Power genPower;
      parameter Real WIND = 12;
      Real eff(start = 1);
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed_ground(animation = false, r = {0, 0, 0}) annotation(
        Placement(transformation(origin = {83, -89}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_yaw(useAxisFlange = true) annotation(
        Placement(transformation(origin = {83, -17}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Mechanics.Rotational.Sources.Position position_yaw(useSupport = true) annotation(
        Placement(transformation(origin = {41, -17}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute shaft(n = {1, 0, 0}, useAxisFlange = true, w(start = 0), phi(start = 0)) annotation(
        Placement(transformation(origin = {2, 94}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_column(r = {0, 0, 22.4}, width = 1) annotation(
        Placement(transformation(origin = {83, -55}, extent = {{-13, -13}, {13, 13}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant source_yaw(k = YAW*3.14/180) annotation(
        Placement(transformation(origin = {-9, -51}, extent = {{-11, -11}, {11, 11}})));
      inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}, gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity) annotation(
        Placement(transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Sources.Speed speed_shaft(phi(fixed = false), useSupport = true) annotation(
        Placement(transformation(origin = {-56, 34}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp source_speed(height = (155)*3.14159/30*1, duration = 10000, offset = (RPM*0 + 5)*3.14159/30, startTime = 0) annotation(
        Placement(transformation(origin = {-90, 34}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation(
        Placement(transformation(origin = {-20, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_tilt(useAxisFlange = true, n = {0, 1, 0}) annotation(
        Placement(transformation(origin = {42, 94}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Mechanics.Rotational.Sources.Position position_tilt(useSupport = true) annotation(
        Placement(transformation(origin = {43, 57}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant source_tilt(k = TILT*3.14/180) annotation(
        Placement(transformation(origin = {-9, -11}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_nacelle(r = {-5, 0, 0}) annotation(
        Placement(transformation(origin = {79, 93}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
      Modelica.Blocks.Sources.Ramp source_pitch(duration = 10000, height = -30*3.14/180*0, offset = -1*PITCH*3.14159/180, startTime = 0) annotation(
        Placement(transformation(origin = {-90, 74}, extent = {{-10, -10}, {10, 10}})));
      inner WindSource windSource(density(displayUnit = "kg/m3"), redeclare function windDistribution = WindDistributions.Shear, nin = 3) annotation(
        Placement(transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp source_wind_velocity(height = 0, duration = 10000, offset = WIND) annotation(
        Placement(transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant Shear_coefficient(k = 0) annotation(
        Placement(transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant hub_height(k = 22.4) annotation(
        Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
      Rotor rotor(final BLADE_PARAMETERS_FILE = "D:/OM_Turbine/QBlade_test2/WPC_QBlade_test2_short.txt", final NOB = 3, final CONE = 0, SECTION_SPLIT_NUMBER = 9, correction_Spera = 0.35, correction_Glauert = true, correction_Prandtl = true, INDEPENDENT_PITCH_ANGLES = false) annotation(
        Placement(transformation(origin = {-44.5, 94.3333}, extent = {{-12.5, -41.6667}, {12.5, 41.6667}}, rotation = 180)));
    equation
      genPower = powerSensor.power*eff;
      eff = 100*genPower/(0.0045332233*genPower^2 + 111.5023*genPower + 150.0035);
      connect(position_yaw.flange, revolute_yaw.axis) annotation(
        Line(points = {{52, -17}, {72, -17}}));
      connect(source_yaw.y, position_yaw.phi_ref) annotation(
        Line(points = {{3, -51}, {22.5, -51}, {22.5, -17}, {28, -17}}, color = {0, 0, 127}));
      connect(source_speed.y, speed_shaft.w_ref) annotation(
        Line(points = {{-79, 34}, {-68, 34}}, color = {0, 0, 127}));
      connect(speed_shaft.flange, powerSensor.flange_b) annotation(
        Line(points = {{-46, 34}, {-30, 34}}));
      connect(position_tilt.support, revolute_tilt.support) annotation(
        Line(points = {{54, 57}, {54, 71}, {50, 71}, {50, 80}}));
      connect(position_tilt.flange, revolute_tilt.axis) annotation(
        Line(points = {{43, 68}, {43, 75}, {42, 75}, {42, 80}}));
      connect(powerSensor.flange_a, shaft.axis) annotation(
        Line(points = {{-10, 34}, {2, 34}, {2, 80}}));
      connect(shaft.frame_b, rotor.frame_a) annotation(
        Line(points = {{-12, 94}, {-38, 94}}, color = {95, 95, 95}));
      connect(revolute_yaw.support, position_yaw.support) annotation(
        Line(points = {{72, -24}, {41, -24}, {41, -28}}));
      connect(revolute_tilt.frame_a, fixedTranslation_nacelle.frame_b) annotation(
        Line(points = {{56, 94}, {56, 93}, {66, 93}}, color = {95, 95, 95}));
      connect(fixed_ground.frame_b, fixedTranslation_column.frame_a) annotation(
        Line(points = {{83, -78}, {83, -68}}, color = {95, 95, 95}));
      connect(fixedTranslation_column.frame_b, revolute_yaw.frame_a) annotation(
        Line(points = {{83, -42}, {83, -28}}, color = {95, 95, 95}));
      connect(source_tilt.y, position_tilt.phi_ref) annotation(
        Line(points = {{3, -11}, {3, 12.25}, {43, 12.25}, {43, 44}}, color = {0, 0, 127}));
      connect(fixedTranslation_nacelle.frame_a, revolute_yaw.frame_b) annotation(
        Line(points = {{92, 93}, {98, 93}, {98, 18}, {83, 18}, {83, -6}}, color = {95, 95, 95}));
      connect(shaft.frame_a, revolute_tilt.frame_b) annotation(
        Line(points = {{16, 94}, {28, 94}}, color = {95, 95, 95}));
      connect(speed_shaft.support, shaft.support) annotation(
        Line(points = {{-56, 24}, {-56, 20}, {10, 20}, {10, 80}}));
      connect(hub_height.y, windSource.wind_global_args[3]) annotation(
        Line(points = {{-78, -90}, {-74, -90}, {-74, -56}, {-62, -56}, {-62, -50}}, color = {0, 0, 127}));
      connect(Shear_coefficient.y, windSource.wind_global_args[2]) annotation(
        Line(points = {{-78, -50}, {-62, -50}}, color = {0, 0, 127}));
      connect(source_wind_velocity.y, windSource.wind_global_args[1]) annotation(
        Line(points = {{-78, -10}, {-74, -10}, {-74, -44}, {-62, -44}, {-62, -50}}, color = {0, 0, 127}));
      connect(source_pitch.y, rotor.pitch) annotation(
        Line(points = {{-78, 74}, {-54, 74}, {-54, 76}}, color = {0, 0, 127}));
      annotation(
        uses(Modelica(version = "4.0.0")),
        Diagram);
    end TestTower;

    model TestTowerRISO
      extends Modelica.Icons.Example;
      //parameter String BLADE_PARAMETERS_FILE = "D:/OM_Turbine/RISO/WPC_RISO_v16h.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/NREL/WPC_NRELp3_v16.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/ECN/WPC_ECN_base_v9.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/QBlade_test2/WPC_QBlade_test2.txt";
      parameter Real YAW = 15.45;
      parameter Real PITCH[3] = {1.8, 1.8, 1.5}.*0;
      parameter Real TILT = 0;
      parameter Real RPM = 47.6;
      Modelica.Units.SI.Power genPower;
      //parameter Real WIND = 12;
      Real eff(start = 1);
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed_ground(animation = false, r = {0, 0, 0}) annotation(
        Placement(transformation(origin = {83, -89}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_yaw(useAxisFlange = true) annotation(
        Placement(transformation(origin = {83, -17}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Mechanics.Rotational.Sources.Position position_yaw(useSupport = true) annotation(
        Placement(transformation(origin = {41, -17}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute shaft(n = {1, 0, 0}, useAxisFlange = true, w(start = 0), phi(start = 0)) annotation(
        Placement(transformation(origin = {2, 94}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_column(r = {0, 0, 29.3}, width = 1) annotation(
        Placement(transformation(origin = {83, -55}, extent = {{-13, -13}, {13, 13}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant source_yaw(k = YAW*3.14/180) annotation(
        Placement(transformation(origin = {-9, -51}, extent = {{-11, -11}, {11, 11}})));
      inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}, gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity) annotation(
        Placement(transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Sources.Speed speed_shaft(phi(fixed = false), useSupport = true) annotation(
        Placement(transformation(origin = {-56, 34}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp source_speed(height = (155)*3.14159/30*0, duration = 10000, offset = (RPM*1 + 0*5)*3.14159/30, startTime = 0) annotation(
        Placement(transformation(origin = {-90, 34}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation(
        Placement(transformation(origin = {-20, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_tilt(useAxisFlange = true, n = {0, 1, 0}) annotation(
        Placement(transformation(origin = {42, 94}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Mechanics.Rotational.Sources.Position position_tilt(useSupport = true) annotation(
        Placement(transformation(origin = {43, 57}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant source_tilt(k = TILT*3.14/180) annotation(
        Placement(transformation(origin = {-9, -11}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_nacelle(r = {-5, 0, 0}) annotation(
        Placement(transformation(origin = {79, 93}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
      inner WindSource windSource(density(displayUnit = "kg/m3"), redeclare function windDistribution = WindDistributions.Shear, nin = 3) annotation(
        Placement(transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp source_wind_velocity(height = 8, duration = 10000, offset = 8) annotation(
        Placement(transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant Shear_coefficient(k = 0.26) annotation(
        Placement(transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant hub_height(k = 29.3) annotation(
        Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
      Rotor rotor(final BLADE_PARAMETERS_FILE = "D:/OM_Turbine/RISO/WPC_RISO_v19.txt", final NOB = 3, final CONE = 0, SECTION_SPLIT_NUMBER = 3, correction_Spera = 0.2, correction_Glauert = true, correction_Prandtl = true, blade_r_CM = {0, 0, 5}, blade_m = 0.001, INDEPENDENT_PITCH_ANGLES = true, LIMIT_INDUCTION_COEFFICIENT = false) annotation(
        Placement(transformation(origin = {-44.5, 94.3333}, extent = {{-12.5, -41.6667}, {12.5, 41.6667}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant source_pitch[3](k = PITCH[:].*3.14159/180) annotation(
        Placement(transformation(origin = {-90, 72}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_column1(r = {1, 0, 0}, width = 1) annotation(
        Placement(transformation(origin = {119, -37}, extent = {{-13, -13}, {13, 13}})));
    equation
      genPower = powerSensor.power*eff;
      eff = 100*genPower/(0.0045332233*genPower^2 + 111.5023*genPower + 150.0035);
      connect(position_yaw.flange, revolute_yaw.axis) annotation(
        Line(points = {{52, -17}, {72, -17}}));
      connect(source_yaw.y, position_yaw.phi_ref) annotation(
        Line(points = {{3, -51}, {22.5, -51}, {22.5, -17}, {28, -17}}, color = {0, 0, 127}));
      connect(source_speed.y, speed_shaft.w_ref) annotation(
        Line(points = {{-79, 34}, {-68, 34}}, color = {0, 0, 127}));
      connect(speed_shaft.flange, powerSensor.flange_b) annotation(
        Line(points = {{-46, 34}, {-30, 34}}));
      connect(position_tilt.support, revolute_tilt.support) annotation(
        Line(points = {{54, 57}, {54, 71}, {50, 71}, {50, 80}}));
      connect(position_tilt.flange, revolute_tilt.axis) annotation(
        Line(points = {{43, 68}, {43, 75}, {42, 75}, {42, 80}}));
      connect(powerSensor.flange_a, shaft.axis) annotation(
        Line(points = {{-10, 34}, {2, 34}, {2, 80}}));
      connect(shaft.frame_b, rotor.frame_a) annotation(
        Line(points = {{-12, 94}, {-38, 94}}, color = {95, 95, 95}));
      connect(revolute_yaw.support, position_yaw.support) annotation(
        Line(points = {{72, -24}, {41, -24}, {41, -28}}));
      connect(revolute_tilt.frame_a, fixedTranslation_nacelle.frame_b) annotation(
        Line(points = {{56, 94}, {56, 93}, {66, 93}}, color = {95, 95, 95}));
      connect(fixed_ground.frame_b, fixedTranslation_column.frame_a) annotation(
        Line(points = {{83, -78}, {83, -68}}, color = {95, 95, 95}));
      connect(fixedTranslation_column.frame_b, revolute_yaw.frame_a) annotation(
        Line(points = {{83, -42}, {83, -28}}, color = {95, 95, 95}));
      connect(source_tilt.y, position_tilt.phi_ref) annotation(
        Line(points = {{3, -11}, {3, 12.25}, {43, 12.25}, {43, 44}}, color = {0, 0, 127}));
      connect(fixedTranslation_nacelle.frame_a, revolute_yaw.frame_b) annotation(
        Line(points = {{92, 93}, {98, 93}, {98, 18}, {83, 18}, {83, -6}}, color = {95, 95, 95}));
      connect(shaft.frame_a, revolute_tilt.frame_b) annotation(
        Line(points = {{16, 94}, {28, 94}}, color = {95, 95, 95}));
      connect(speed_shaft.support, shaft.support) annotation(
        Line(points = {{-56, 24}, {-56, 20}, {10, 20}, {10, 80}}));
      connect(hub_height.y, windSource.wind_global_args[3]) annotation(
        Line(points = {{-78, -90}, {-74, -90}, {-74, -56}, {-62, -56}, {-62, -50}}, color = {0, 0, 127}));
      connect(Shear_coefficient.y, windSource.wind_global_args[2]) annotation(
        Line(points = {{-78, -50}, {-62, -50}}, color = {0, 0, 127}));
      connect(source_wind_velocity.y, windSource.wind_global_args[1]) annotation(
        Line(points = {{-78, -10}, {-74, -10}, {-74, -44}, {-62, -44}, {-62, -50}}, color = {0, 0, 127}));
      connect(source_pitch.y, rotor.pitch_array) annotation(
        Line(points = {{-79, 72}, {-67, 72}, {-67, 76}, {-54, 76}}, color = {0, 0, 127}));
      connect(fixedTranslation_column1.frame_a, fixedTranslation_column.frame_b) annotation(
        Line(points = {{106, -36}, {84, -36}, {84, -42}}, color = {95, 95, 95}));
      annotation(
        uses(Modelica(version = "4.0.0")),
        Diagram);
    end TestTowerRISO;

    model TestTowerNREL
      extends Modelica.Icons.Example;
      //parameter String BLADE_PARAMETERS_FILE = "D:/OM_Turbine/RISO/WPC_RISO_v16h.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/NREL/WPC_NRELp3_v16.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/ECN/WPC_ECN_base_v9.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/QBlade_test2/WPC_QBlade_test2.txt";
      parameter Real YAW = 0;
      parameter Real PITCH = 3;
      // 3
      parameter Real TILT = 0;
      parameter Real CONE = (3+25/60)*0;
      parameter Real RPM = 71.63;
      Modelica.Units.SI.Power genPower;
      //parameter Real WIND = 12;
      Real eff(start = 1);
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed_ground(animation = false, r = {0, 0, 0}) annotation(
        Placement(transformation(origin = {83, -89}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_yaw(useAxisFlange = true) annotation(
        Placement(transformation(origin = {83, -17}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Mechanics.Rotational.Sources.Position position_yaw(useSupport = true) annotation(
        Placement(transformation(origin = {41, -17}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute shaft(n = {1, 0, 0}, useAxisFlange = true, w(start = 0), phi(start = 0)) annotation(
        Placement(transformation(origin = {2, 94}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_column(r = {0, 0, 17.03}, width = 1) annotation(
        Placement(transformation(origin = {83, -55}, extent = {{-13, -13}, {13, 13}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant source_yaw(k = YAW*3.14/180) annotation(
        Placement(transformation(origin = {-9, -51}, extent = {{-11, -11}, {11, 11}})));
      inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}, gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity) annotation(
        Placement(transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Sources.Speed speed_shaft(phi(fixed = false), useSupport = true) annotation(
        Placement(transformation(origin = {-56, 34}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp source_speed(height = (155)*3.14159/30*0, duration = 10000, offset = (RPM*1 + 0*5)*3.14159/30, startTime = 0) annotation(
        Placement(transformation(origin = {-90, 34}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation(
        Placement(transformation(origin = {-20, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_tilt(useAxisFlange = true, n = {0, 1, 0}) annotation(
        Placement(transformation(origin = {42, 94}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Mechanics.Rotational.Sources.Position position_tilt(useSupport = true) annotation(
        Placement(transformation(origin = {43, 57}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant source_tilt(k = TILT*3.14/180) annotation(
        Placement(transformation(origin = {-9, -11}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_nacelle(r = {-5, 0, 0}) annotation(
        Placement(transformation(origin = {79, 93}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
      inner WindSource windSource(density(displayUnit = "kg/m3") = 0.9792999999999999, redeclare function windDistribution = WindDistributions.Shear, nin = 3) annotation(
        Placement(transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp source_wind_velocity(height = 1, duration = 10000, offset = 4) annotation(
        Placement(transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant Shear_coefficient(k = 0.14) annotation(
        Placement(transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant hub_height(k = 17.03) annotation(
        Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
      Rotor rotor(final BLADE_PARAMETERS_FILE = "D:/OM_Turbine/NREL/WPC_NRELp3_v20.txt", final NOB = 3, final CONE = CONE*3.14159/180, SECTION_SPLIT_NUMBER = 1, correction_Spera = 0.2, correction_Glauert = true, correction_Prandtl = true, blade_r_CM = {0, 0, 5}, blade_m = 0.001, INDEPENDENT_PITCH_ANGLES = false, LIMIT_INDUCTION_COEFFICIENT = false, AIRFOIL_CHARACTERISTICS_SMOOTHNESS = Modelica.Blocks.Types.Smoothness.LinearSegments, AIRFOIL_CHARACTERISTICS_EXTRAPOLATION = Modelica.Blocks.Types.Extrapolation.LastTwoPoints) annotation(
        Placement(transformation(origin = {-44.5, 94.3333}, extent = {{-12.5, -41.6667}, {12.5, 41.6667}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant source_pitch(k = PITCH*3.14159/180) annotation(
        Placement(transformation(origin = {-90, 72}, extent = {{-10, -10}, {10, 10}})));
    equation
      genPower = powerSensor.power*eff;
      eff = 100*genPower/(0.0045332233*genPower^2 + 111.5023*genPower + 150.0035);
      connect(position_yaw.flange, revolute_yaw.axis) annotation(
        Line(points = {{52, -17}, {72, -17}}));
      connect(source_yaw.y, position_yaw.phi_ref) annotation(
        Line(points = {{3, -51}, {22.5, -51}, {22.5, -17}, {28, -17}}, color = {0, 0, 127}));
      connect(source_speed.y, speed_shaft.w_ref) annotation(
        Line(points = {{-79, 34}, {-68, 34}}, color = {0, 0, 127}));
      connect(speed_shaft.flange, powerSensor.flange_b) annotation(
        Line(points = {{-46, 34}, {-30, 34}}));
      connect(position_tilt.support, revolute_tilt.support) annotation(
        Line(points = {{54, 57}, {54, 71}, {50, 71}, {50, 80}}));
      connect(position_tilt.flange, revolute_tilt.axis) annotation(
        Line(points = {{43, 68}, {43, 75}, {42, 75}, {42, 80}}));
      connect(powerSensor.flange_a, shaft.axis) annotation(
        Line(points = {{-10, 34}, {2, 34}, {2, 80}}));
      connect(shaft.frame_b, rotor.frame_a) annotation(
        Line(points = {{-12, 94}, {-38, 94}}, color = {95, 95, 95}));
      connect(revolute_yaw.support, position_yaw.support) annotation(
        Line(points = {{72, -24}, {41, -24}, {41, -28}}));
      connect(revolute_tilt.frame_a, fixedTranslation_nacelle.frame_b) annotation(
        Line(points = {{56, 94}, {56, 93}, {66, 93}}, color = {95, 95, 95}));
      connect(fixed_ground.frame_b, fixedTranslation_column.frame_a) annotation(
        Line(points = {{83, -78}, {83, -68}}, color = {95, 95, 95}));
      connect(fixedTranslation_column.frame_b, revolute_yaw.frame_a) annotation(
        Line(points = {{83, -42}, {83, -28}}, color = {95, 95, 95}));
      connect(source_tilt.y, position_tilt.phi_ref) annotation(
        Line(points = {{3, -11}, {3, 12.25}, {43, 12.25}, {43, 44}}, color = {0, 0, 127}));
      connect(fixedTranslation_nacelle.frame_a, revolute_yaw.frame_b) annotation(
        Line(points = {{92, 93}, {98, 93}, {98, 18}, {83, 18}, {83, -6}}, color = {95, 95, 95}));
      connect(shaft.frame_a, revolute_tilt.frame_b) annotation(
        Line(points = {{16, 94}, {28, 94}}, color = {95, 95, 95}));
      connect(speed_shaft.support, shaft.support) annotation(
        Line(points = {{-56, 24}, {-56, 20}, {10, 20}, {10, 80}}));
      connect(hub_height.y, windSource.wind_global_args[3]) annotation(
        Line(points = {{-78, -90}, {-74, -90}, {-74, -56}, {-62, -56}, {-62, -50}}, color = {0, 0, 127}));
      connect(Shear_coefficient.y, windSource.wind_global_args[2]) annotation(
        Line(points = {{-78, -50}, {-62, -50}}, color = {0, 0, 127}));
      connect(source_wind_velocity.y, windSource.wind_global_args[1]) annotation(
        Line(points = {{-78, -10}, {-74, -10}, {-74, -44}, {-62, -44}, {-62, -50}}, color = {0, 0, 127}));
  connect(source_pitch.y, rotor.pitch) annotation(
        Line(points = {{-78, 72}, {-54, 72}, {-54, 76}}, color = {0, 0, 127}));
      annotation(
        uses(Modelica(version = "4.0.0")),
        Diagram);
    end TestTowerNREL;
    
    model TestTowerNREL_dynamic
      extends Modelica.Icons.Example;
      //parameter String BLADE_PARAMETERS_FILE = "D:/OM_Turbine/RISO/WPC_RISO_v16h.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/NREL/WPC_NRELp3_v16.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/ECN/WPC_ECN_base_v9.txt";
      //parameter String blade_parameters_file = "D:/OM_Turbine/QBlade_test2/WPC_QBlade_test2.txt";
      parameter Real YAW = 0;
      parameter Real PITCH = 3;
      // 3
      Real t = time;
      parameter Real TILT = 0;
      parameter Real CONE = (3+25/60);
      parameter Real RPM = 71.63*(1+0.0159*16/20);
      Modelica.Units.SI.Power genPower;
      //parameter Real WIND = 12;
      Real eff(start = 1);
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed_ground(animation = false, r = {0, 0, 0}) annotation(
        Placement(transformation(origin = {83, -89}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_yaw(useAxisFlange = true) annotation(
        Placement(transformation(origin = {83, -17}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Mechanics.Rotational.Sources.Position position_yaw(useSupport = true) annotation(
        Placement(transformation(origin = {41, -17}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute shaft(n = {1, 0, 0}, useAxisFlange = true, w(start = RPM*3.14/30), phi(start = 0)) annotation(
        Placement(transformation(origin = {2, 94}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_column(r = {0, 0, 17.03}, width = 1) annotation(
        Placement(transformation(origin = {83, -55}, extent = {{-13, -13}, {13, 13}}, rotation = 90)));
      inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}, gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity) annotation(
        Placement(transformation(origin = {-48, -90}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Sources.Speed speed_shaft(phi(fixed = false), useSupport = true) annotation(
        Placement(transformation(origin = {-56, 34}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp source_speed(height = (155)*3.14159/30*0, duration = 10000, offset = (RPM*1 + 0*5)*3.14159/30, startTime = 0) annotation(
        Placement(transformation(origin = {-108, 34}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation(
        Placement(transformation(origin = {-26, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_tilt(useAxisFlange = true, n = {0, 1, 0}) annotation(
        Placement(transformation(origin = {42, 94}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
      Modelica.Mechanics.Rotational.Sources.Position position_tilt(useSupport = true) annotation(
        Placement(transformation(origin = {43, 57}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant source_tilt(k = TILT*3.14/180) annotation(
        Placement(transformation(origin = {-9, -11}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation_nacelle(r = {-5, 0, 0}) annotation(
        Placement(transformation(origin = {79, 93}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
      inner WindSource windSource(density(displayUnit = "kg/m3") = 0.9792999999999999, redeclare function windDistribution = WindDistributions.Shear, nin = 3) annotation(
        Placement(transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant Shear_coefficient(k = 0.14*0) annotation(
        Placement(transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant hub_height(k = 17.03) annotation(
        Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
      Rotor rotor(final BLADE_PARAMETERS_FILE = "D:/OM_Turbine/NREL/WPC_NRELp2_v20.txt", final NOB = 3, final CONE = CONE*3.14159/180, SECTION_SPLIT_NUMBER = 1, correction_Spera = 0.2, correction_Glauert = true, correction_Prandtl = true, blade_r_CM = {0, 0, 5}, blade_m = 0.001, INDEPENDENT_PITCH_ANGLES = false, LIMIT_INDUCTION_COEFFICIENT = false, AIRFOIL_CHARACTERISTICS_SMOOTHNESS = Modelica.Blocks.Types.Smoothness.LinearSegments, AIRFOIL_CHARACTERISTICS_EXTRAPOLATION = Modelica.Blocks.Types.Extrapolation.LastTwoPoints) annotation(
        Placement(transformation(origin = {-50.5, 94.3333}, extent = {{-12.5, -41.6667}, {12.5, 41.6667}}, rotation = 180)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_pitch(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = "D:/OM_Turbine/NREL/ny_rot_nu_005.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "pitch", tableOnFile = true) annotation(
        Placement(transformation(origin = {-114, 74}, extent = {{-12, -12}, {12, 12}})));
  Modelica.Blocks.Math.Gain gain(k = 3.14159/180)  annotation(
        Placement(transformation(origin = {-79, 73}, extent = {{-7, -7}, {7, 7}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_wind(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = "D:/OM_Turbine/NREL/ny_rot_nu_005.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "wind", tableOnFile = true) annotation(
        Placement(transformation(origin = {-108, -12}, extent = {{-12, -12}, {12, 12}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_yaw(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = "D:/OM_Turbine/NREL/ny_rot_nu_005.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "yaw", tableOnFile = true) annotation(
        Placement(transformation(origin = {-2, -60}, extent = {{-12, -12}, {12, 12}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_power(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = "D:/OM_Turbine/NREL/ny_rot_nu_005.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "power", tableOnFile = true) annotation(
        Placement(transformation(origin = {124, -54}, extent = {{-12, -12}, {12, 12}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_alpha(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, fileName = "D:/OM_Turbine/NREL/ny_rot_nu_005.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "alpha", tableOnFile = true) annotation(
        Placement(transformation(origin = {124, -88}, extent = {{-12, -12}, {12, 12}})));
  Modelica.Blocks.Math.Gain gain_power(k = 1000) annotation(
        Placement(transformation(origin = {155, -55}, extent = {{-7, -7}, {7, 7}})));
  Modelica.Blocks.Math.Gain gain1(k = 3.14159/180) annotation(
        Placement(transformation(origin = {27, -59}, extent = {{-7, -7}, {7, 7}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 1535)  annotation(
        Placement(transformation(origin = {-4, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    equation
      genPower = powerSensor.power*eff;
      eff = 100*genPower/(0.0045332233*genPower^2 + 111.5023*genPower + 150.0035);
      connect(position_yaw.flange, revolute_yaw.axis) annotation(
        Line(points = {{52, -17}, {72, -17}}));
      connect(speed_shaft.flange, powerSensor.flange_b) annotation(
        Line(points = {{-46, 34}, {-36, 34}}));
      connect(position_tilt.support, revolute_tilt.support) annotation(
        Line(points = {{54, 57}, {54, 71}, {50, 71}, {50, 80}}));
      connect(position_tilt.flange, revolute_tilt.axis) annotation(
        Line(points = {{43, 68}, {43, 75}, {42, 75}, {42, 80}}));
      connect(revolute_yaw.support, position_yaw.support) annotation(
        Line(points = {{72, -24}, {41, -24}, {41, -28}}));
      connect(revolute_tilt.frame_a, fixedTranslation_nacelle.frame_b) annotation(
        Line(points = {{56, 94}, {56, 93}, {66, 93}}, color = {95, 95, 95}));
      connect(fixed_ground.frame_b, fixedTranslation_column.frame_a) annotation(
        Line(points = {{83, -78}, {83, -68}}, color = {95, 95, 95}));
      connect(fixedTranslation_column.frame_b, revolute_yaw.frame_a) annotation(
        Line(points = {{83, -42}, {83, -28}}, color = {95, 95, 95}));
      connect(source_tilt.y, position_tilt.phi_ref) annotation(
        Line(points = {{3, -11}, {3, 12.25}, {43, 12.25}, {43, 44}}, color = {0, 0, 127}));
      connect(fixedTranslation_nacelle.frame_a, revolute_yaw.frame_b) annotation(
        Line(points = {{92, 93}, {98, 93}, {98, 18}, {83, 18}, {83, -6}}, color = {95, 95, 95}));
      connect(shaft.frame_a, revolute_tilt.frame_b) annotation(
        Line(points = {{16, 94}, {28, 94}}, color = {95, 95, 95}));
      connect(speed_shaft.support, shaft.support) annotation(
        Line(points = {{-56, 24}, {-56, 20}, {10, 20}, {10, 80}}));
      connect(gain.y, rotor.pitch) annotation(
        Line(points = {{-72, 74}, {-64, 74}, {-64, 75}, {-63, 75}}, color = {0, 0, 127}));
      connect(combiTimeTable_pitch.y[1], gain.u) annotation(
        Line(points = {{-101, 74}, {-88, 74}}, color = {0, 0, 127}));
      connect(combiTimeTable_power.y[1], gain_power.u) annotation(
        Line(points = {{138, -54}, {146, -54}}, color = {0, 0, 127}));
      connect(source_speed.y, speed_shaft.w_ref) annotation(
        Line(points = {{-96, 34}, {-68, 34}}, color = {0, 0, 127}));
      connect(combiTimeTable_yaw.y[1], gain1.u) annotation(
        Line(points = {{11.2, -60}, {17.2, -60}, {17.2, -58}}, color = {0, 0, 127}));
      connect(gain1.y, position_yaw.phi_ref) annotation(
        Line(points = {{34, -58}, {42, -58}, {42, -34}, {28, -34}, {28, -16}}, color = {0, 0, 127}));
      connect(windSource.wind_global_args[1], combiTimeTable_wind.y[1]) annotation(
        Line(points = {{-62, -50}, {-68, -50}, {-68, -12}, {-94, -12}}, color = {0, 0, 127}, thickness = 0.5));
      connect(Shear_coefficient.y, windSource.wind_global_args[2]) annotation(
        Line(points = {{-78, -50}, {-62, -50}}, color = {0, 0, 127}));
      connect(hub_height.y, windSource.wind_global_args[3]) annotation(
        Line(points = {{-78, -90}, {-70, -90}, {-70, -50}, {-62, -50}}, color = {0, 0, 127}));
  connect(shaft.frame_b, rotor.frame_a) annotation(
        Line(points = {{-12, 94}, {-42, 94}}, color = {95, 95, 95}));
  connect(powerSensor.flange_a, inertia.flange_a) annotation(
        Line(points = {{-16, 34}, {-4, 34}, {-4, 46}}));
  connect(inertia.flange_b, shaft.axis) annotation(
        Line(points = {{-4, 66}, {2, 66}, {2, 80}}));
      annotation(
        uses(Modelica(version = "4.0.0")),
        Diagram);
    end TestTowerNREL_dynamic;

    extends Modelica.Icons.ExamplesPackage;
  end Examples;

  block WindSource
    // PACKAGES
    import Modelica.Units.SI;
    extends Modelica.Blocks.Icons.Block;
    // PARAMETERS
    parameter Integer nin = 4 "Number of inputs";
    parameter SI.Density density = 1.225 "Wind density";
    parameter SI.KinematicViscosity k_viscosity = 1.48e-5 "wind kinematic wiscosity";
    inner replaceable function windDistribution = WindDistributions.Shear annotation(
      Dialog(group = "Wind distribution function", enable = true),
      choicesAllMatching = true)/*a*/;
    // INPUT
    Modelica.Blocks.Interfaces.RealInput wind_global_args[nin] "Connector of Real input signals" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    /*a*/
    /*a*/
    annotation(
      defaultComponentName = "medium",
      defaultComponentPrefixes = "inner",
      Icon(graphics = {Line(origin = {-68, 56}, points = {{0, 0}}), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(points = {{-100, -118}, {-100, 61}}, thickness = 0.5), Polygon(fillPattern = FillPattern.Solid, points = {{-100, 100}, {-120, 60}, {-80, 60}, {-100, 100}, {-100, 100}}), Line(points = {{-119, -100}, {59, -100}}, thickness = 0.5), Polygon(fillPattern = FillPattern.Solid, points = {{99, -100}, {59, -80}, {59, -120}, {99, -100}}), Line(rotation = 90, points = {{-56, 78}, {-56, 48}}, color = {0, 255, 200}), Polygon(origin = {-76, 0}, rotation = 90, lineColor = {0, 255, 200}, fillColor = {0, 255, 200}, fillPattern = FillPattern.Solid, points = {{-68, -26}, {-56, -66}, {-44, -26}, {-68, -26}}), Line(rotation = 90, points = {{2, 78}, {2, -26}}, color = {0, 255, 200}), Polygon(origin = {-28, 0}, rotation = 90, lineColor = {0, 255, 200}, fillColor = {0, 255, 200}, fillPattern = FillPattern.Solid, points = {{-10, -26}, {2, -66}, {14, -26}, {-10, -26}}), Line(origin = {-0.29, 0}, rotation = 90, points = {{66, 80}, {66, -26}}, color = {0, 255, 200}), Polygon(rotation = 90, lineColor = {0, 255, 200}, fillColor = {0, 255, 200}, fillPattern = FillPattern.Solid, points = {{54, -26}, {66, -66}, {78, -26}, {54, -26}})}));
  end WindSource;

  model Rotor
    // PACKAGES
    import Modelica.Units.SI;
    // REFERENCES
    outer Modelica.Mechanics.MultiBody.World world;
    outer WindSource windSource;
    // PARAMETERS
    parameter String BLADE_PARAMETERS_FILE = "D:/OM_Turbine/NREL/WPC_NRELp3.txt" "Blade shape parameters file" annotation(
      Dialog(group = "Propeller geometry"));
    parameter Integer SECTION_SPLIT_NUMBER = 1 "Number of parts into which the section is split" annotation(
      Dialog(tab = "Blade", group = "Discretization"));
    /*a*/
    inner parameter Integer NOB = 3 "Number of blades" annotation(
      Dialog(group = "Propeller geometry"));
    parameter SI.Angle CONE = 0 "Cone angle" annotation(
      Dialog(group = "Propeller geometry"));
    parameter Boolean INDEPENDENT_PITCH_ANGLES = false "Use independent pitch controls" annotation(
      Dialog(group = "Propeller geometry"));
    inner parameter Boolean correction_Glauert = true "Glauert model" annotation(
      Dialog(group = "Aerodynamic model"));
    inner parameter Boolean correction_Prandtl = true "Prandtl-Glauert tip-loss correction" annotation(
      Dialog(group = "Aerodynamic model"));
    inner parameter Real correction_Spera = 0.2 "Spera correction" annotation(
      Dialog(group = "Aerodynamic model"));
    inner parameter Boolean LIMIT_INDUCTION_COEFFICIENT = false "Limit induction coefficients to 0.5" annotation(
      Dialog(group = "Aerodynamic model"));
    // airfoil interpolation and approximation
    inner parameter Modelica.Blocks.Types.Smoothness AIRFOIL_CHARACTERISTICS_SMOOTHNESS = Modelica.Blocks.Types.Smoothness.LinearSegments
    "Interpolation type"annotation(
      Dialog(tab = "Blade", group = "Airfoil characteristics"));
      
      //=Modelica.Blocks.Types.Smoothness.LinearSegments;
    inner parameter Modelica.Blocks.Types.Extrapolation AIRFOIL_CHARACTERISTICS_EXTRAPOLATION = Modelica.Blocks.Types.Extrapolation.LastTwoPoints
    "Extrapolation type"annotation(
      Dialog(tab = "Blade", group = "Airfoil characteristics"));
    
    // VARIABLES
    SI.Velocity outflow_mean_velocity[3] "outflow wind velocity";
    //Modelica.Units.SI.Velocity global_wind_velocity_outflow[3] "Wind velocity vector at hub";
    Modelica.Units.SI.Velocity wind_inflow_magnitude "Wind magnitude at hub";
    // COMPONENTS
    // NOB x Blade
    Internal.Blade[NOB] blade(each BLADE_PARAMETERS_FILE = BLADE_PARAMETERS_FILE, each SECTION_SPLIT_NUMBER = SECTION_SPLIT_NUMBER, each bodyShape(animation = blade_animation, animateSphere = blade_animateSphere, r_CM = blade_r_CM, m = blade_m, I_11 = blade_I_11, I_22 = blade_I_22, I_33 = blade_I_33, I_21 = blade_I_21, I_31 = blade_I_31, I_32 = blade_I_32)) annotation(
      Placement(transformation(origin = {21, -1}, extent = {{-35, -35}, {35, 35}})));
    /*a*/
    // input pitch angle
    Modelica.Blocks.Interfaces.RealInput pitch if not INDEPENDENT_PITCH_ANGLES annotation(
      Placement(transformation(origin = {-110, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {34, 46}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput pitch_array[NOB] if INDEPENDENT_PITCH_ANGLES annotation(
      Placement(transformation(origin = {-110, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {34, 46}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
    /*a*/
    // cone rotations
    Modelica.Mechanics.MultiBody.Parts.FixedRotation[NOB] fixedRotation_CONE(each n = {0, -1, 0}, each angle = CONE) annotation(
      Placement(transformation(origin = {-42, 0}, extent = {{-10, -10}, {10, 10}})));
    /*a*/
    // wind inflow block
    Internal.InflowWind inflowWind;
    //for wind at hub
    // rotor main frame hub to shaft
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
      Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-18, 0}, extent = {{-16, -16}, {16, 16}})));
    /*a*/
    // spacing blades around circumference
    Modelica.Mechanics.MultiBody.Parts.FixedRotation[NOB] fixedRotation_spacing(angle = blade_angles, each n = {1, 0, 0}, each r = {0, 0, 0}, each rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis) annotation(
      Placement(transformation(origin = {-76, 0}, extent = {{-10, -10}, {10, 10}})));
    /*a*/
    // wind velocity vector at hub
    Modelica.Blocks.Interfaces.RealOutput global_wind_velocity_outflow[3] annotation(
      Placement(transformation(origin = {28, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {35, -47}, extent = {{-5, -5}, {5, 5}})));
    /*a*/
    // BODYSHAPE SECTION
    parameter Boolean blade_animation = true "= true, if animation shall be enabled (show shape between frame_a and frame_b and optionally a sphere at the center of mass)" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter Boolean blade_animateSphere = true "= true, if mass shall be animated as sphere provided animation=true" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter SI.Position blade_r_CM[3](start = {0, 0, 0}) "Vector from frame_a to center of mass, resolved in frame_a" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter SI.Mass blade_m(min = 0, start = 1) "Mass of rigid body" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter SI.Inertia blade_I_11(min = 0) = 0.001 "Element (1,1) of inertia tensor (resolved in center of mass, parallel to frame_a)" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter SI.Inertia blade_I_22(min = 0) = 0.001 "Element (2,2) of inertia tensor (resolved in center of mass, parallel to frame_a)" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter SI.Inertia blade_I_33(min = 0) = 0.001 "Element (3,3) of inertia tensor (resolved in center of mass, parallel to frame_a)" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter SI.Inertia blade_I_21(min = 0.00001) = 0 "Element (2,1) of inertia tensor (resolved in center of mass, parallel to frame_a)" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter SI.Inertia blade_I_31(min = 0.00001) = 0 "Element (3,1) of inertia tensor (resolved in center of mass, parallel to frame_a)" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
    parameter SI.Inertia blade_I_32(min = 0.00001) = 0 "Element (3,2) of inertia tensor (resolved in center of mass, parallel to frame_a)" annotation(
      Dialog(tab = "Blade", group = "BodyShape"));
    /*a*/
  protected
    parameter Real blade_angles[NOB] = (0:(360/NOB):360) "spacing angles";
  equation
  // mean outflow velocity
    outflow_mean_velocity[1] = sum(blade.mean_outflow_velocity[1])/NOB;
    outflow_mean_velocity[2] = sum(blade.mean_outflow_velocity[2])/NOB;
    outflow_mean_velocity[3] = sum(blade.mean_outflow_velocity[3])/NOB;
  // hub position
    inflowWind.point_position = frame_a.r_0;
  // wind velocity at hub
    global_wind_velocity_outflow = inflowWind.wind_vector;
    wind_inflow_magnitude = Modelica.Math.Vectors.length(global_wind_velocity_outflow);
  // CONNECTIONS
    for nob in 1:NOB loop
      connect(fixedRotation_spacing[nob].frame_b, fixedRotation_CONE[nob].frame_a);
      connect(fixedRotation_CONE[nob].frame_b, blade[nob].frame_fix_hub);
      connect(fixedRotation_spacing[nob].frame_a, frame_a);
      if not INDEPENDENT_PITCH_ANGLES then
        connect(pitch, blade[nob].blade_pitch);
      else
        connect(pitch_array[nob], blade[nob].blade_pitch);
      end if;
    end for;
  /*a*/
    annotation(
      Dialog(group = "Propeller geometry"),
      Icon(graphics = {Polygon(origin = {-1, 50}, fillColor = {212, 212, 212}, fillPattern = FillPattern.Solid, lineThickness = 1, points = {{-9, -50}, {-9, 50}, {-1, 50}, {9, -50}, {9, -50}, {-9, -50}}), Polygon(origin = {-1, -42}, fillColor = {212, 212, 212}, fillPattern = FillPattern.Solid, lineThickness = 1, points = {{-9, 42}, {-9, -58}, {-1, -58}, {9, 42}, {-9, 42}, {-9, 42}}), Ellipse(origin = {6, 0}, fillColor = {212, 212, 212}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-10, -10}, {10, 10}}), Rectangle(origin = {-3, 0}, fillColor = {212, 212, 212}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{11, 10}, {-11, -10}}), Text(origin = {21, 58}, extent = {{-17, 6}, {17, -6}}, textString = "pitch angle"), Text(origin = {16, -32}, extent = {{-22, 8}, {22, -8}}, textString = "wind velocity"), Text(origin = {29, 3}, rotation = -90, extent = {{-27, 9}, {27, -9}}, textString = "%name")}, coordinateSystem(extent = {{-30, 100}, {40, -100}})),
      uses(Modelica(version = "4.0.0")),
      Diagram(graphics = {Line(origin = {-57, 0}, points = {{43, 0}, {-43, 0}, {-43, 0}}), Rectangle(origin = {-20, 6}, pattern = LinePattern.Dash, extent = {{-80, -26}, {80, 26}})}));
  end Rotor;

  package WindDistributions
    extends Modelica.Icons.FunctionsPackage;

    partial function basic "interface"
      extends Modelica.Icons.Function;
      // extension for icon
      input Real pos[3] "Position";
      output Real wind[3] "Wind velocity";
    end basic;

    function Shear
      // EXTENSION
      extends basic;
      //input Real pos[3], output Real wind[3]
      // INPUT (from InfloWind)
      input Real args[:] = {10, 0.26, 25, 1, 0, 0};
      //default global args
    protected
      // ENCODING VARIABLES
      Modelica.Units.SI.Velocity wind_hub_magnitude = args[1] "wind velocity magnitude at chracteristik point";
      Real shear_coefficient = args[2] "shear coefficient";
      Modelica.Units.SI.Position hub_height = args[3] "height of haracteristic point";
      Modelica.Units.SI.Velocity wind_direction[3] "wind direction";
      Modelica.Units.SI.Velocity wind_magnitude "wind velocity magnitude";
    algorithm
//Hellman dependency
      wind_direction := {1,0,0};
      wind_magnitude := (wind_hub_magnitude)*((pos[3])/hub_height)^shear_coefficient;
//inclusion of direction
      wind := wind_direction.*wind_magnitude;
    end Shear;

    function Flat
      import Modelica.Math.Vectors;
      extends basic;
      input Modelica.Units.SI.Velocity args[:] = {10, 1, 0, 0};
      //default
    protected
      Modelica.Units.SI.Velocity wind_hub_magnitude = args[1];
      Modelica.Units.SI.Velocity wind_direction[3] = Vectors.normalize(vector(args[2:4]));
    algorithm
      wind := wind_direction.*wind_hub_magnitude;
    end Flat;
  end WindDistributions;

  package Internal
    function txt2mat "transpose text file to string matrix"
      extends Modelica.Icons.Function;
      extends Modelica.Utilities;
      input String filePath "path to file";
      input String separator = " " "separator between numbers";
      input Integer numColums = 1 "number of columns to read";
      input Integer RTO = 1 "number of rows to omite";
      input Integer numRows = Streams.countLines(filePath) "absolute number of rows";
      output String outputMatrix[numRows - RTO, numColums] "ouput matrix";
    protected
      parameter String file = Modelica.Utilities.Files.loadResource(filePath) "File on which data is present" annotation(
        Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
      parameter String fileString[:] = Modelica.Utilities.Streams.readFile(file);
      parameter Integer num_lines = Streams.countLines(filePath);
      Integer i_back;
      Integer i_front;
      Integer notr;
      String c;
      String string_to_split;
      Integer lenLine;
    algorithm
      for nor in (RTO + 1):(numRows) loop
        string_to_split := fileString[nor];
//Streams.print(string_to_split);
        lenLine := Strings.length(string_to_split);
        i_front := 1;
        i_back := i_front;
        notr := 1;
        while i_front < lenLine loop
          c := Strings.substring(string_to_split, i_front, i_front);
          if (c == separator) then
            outputMatrix[nor - RTO, notr] := Strings.substring(string_to_split, i_back, i_front);
//Streams.print(String(outputMatrix[nor-RTO,notr]));
            i_back := i_front;
            i_front := i_front + 1;
            notr := notr + 1;
          else
            i_front := i_front + 1;
          end if;
        end while;
        outputMatrix[nor - RTO, notr] := Strings.substring(string_to_split, i_back, i_front);
//Streams.print(String(outputMatrix[nor-RTO,notr]));
      end for;
//Streams.print(String(outputMatrix[6,7]));
      Streams.print("Matrix loaded succesfully");
    end txt2mat;

    block InflowWind
      //REFERENCE
      outer WindSource windSource;
      //INPUT
      input Modelica.Units.SI.Position point_position[3];
      //OUTPUT
      output Modelica.Units.SI.Velocity wind_vector[3];
    algorithm
// get wind velocity vector
      wind_vector := windSource.windDistribution(point_position, //local args from BladeSection
      windSource.wind_global_args[:]//global args from windSource
      );
    end InflowWind;

    model BladeSection
    
    
    // Sorry, cannot be shared :( 
    
    
    end BladeSection;

    model Blade
      // PACKAGES
      import Modelica.Units.SI;
      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Math.Vectors;
      import Modelica.Math.sin;
      import Modelica.Math.cos;
      import Modelica.Math.asin;
      import Modelica.Constants.pi;
      // REFERENCES
      outer Modelica.Mechanics.MultiBody.World world;
      outer WindSource windSource;
      outer parameter Boolean correction_Glauert;
      outer parameter Boolean correction_Prandtl;
      outer parameter Real correction_Spera;
      outer parameter Boolean LIMIT_INDUCTION_COEFFICIENT;
      outer parameter Integer NOB;
      outer parameter Modelica.Blocks.Types.Smoothness AIRFOIL_CHARACTERISTICS_SMOOTHNESS;
      outer parameter Modelica.Blocks.Types.Extrapolation AIRFOIL_CHARACTERISTICS_EXTRAPOLATION;
      // VARIABLES
      inner SI.Angle blade_pitch_angle = blade_pitch "Blade pitch angle";
      SI.Angle tip_pitch_angle "Tip pitch angle";
      SI.Velocity mean_outflow_velocity[3] "Outflow velocity";
      // PARAMETERS
      inner parameter SI.Length TOTAL_RADIUS = RP.TOTAL_RADIUS "Total blade radius";
      parameter String BLADE_PARAMETERS_FILE = "D:/OM_Turbine/RISO/WPC_RISO_10_L.txt" "Blade parameters file";
      parameter Integer SECTION_SPLIT_NUMBER = 1 "Number of parts  to cut for each ridden section";
      final parameter BladeProperties RP(BLADE_PARAMETERS_FILE = BLADE_PARAMETERS_FILE, SECTION_SPLIT_NUMBER = SECTION_SPLIT_NUMBER) "Rotor properties";
      parameter SI.Area BLADE_WHEEL_SLICE_AREA = pi*TOTAL_RADIUS^2/NOB "Wheel slice part blade area";
      // COMPONENTS
      // NOP x BladeSection
      BladeSection bladeSection[RP.NOS](RADIUS = RP.RADIUS, DELTA_R = RP.DELTA_R, CHORD = RP.CHORD, TWIST = RP.TWIST, AIRFOIL_FILE = RP.AIRFOIL_FILE, THICKNESS = RP.THICKNESS);
      // hub frame
      inner Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_fix_hub annotation(
        Placement(transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 180), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
      // agular velocity of hub in Gcs
      inner SI.AngularVelocity hub_angular_velocity[3] = absoluteAngularVelocity.w annotation(
        Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));
      // angular velocity sensor
      Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity absoluteAngularVelocity(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) annotation(
        Placement(transformation(origin = {-82, -16}, extent = {{-10, -10}, {10, 10}})));
      // parameters overriden during declaration
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape(r = {0, 0, TOTAL_RADIUS}, r_CM = {0, 0, TOTAL_RADIUS/2}, m = 500, shapeType = "box", width = bodyShape.length/20, height = bodyShape.length/30, I_11 = 1, I_22 = 1, I_33 = 1, I_21 = 1, I_31 = 1, I_32 = 1) annotation(
        Placement(transformation(origin = {-6, 56}, extent = {{-10, -10}, {10, 10}})));
      // aerodynamic force and torque on hub
      Modelica.Mechanics.MultiBody.Forces.WorldForceAndTorque forceAndTorque(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b) annotation(
        Placement(transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      // blade frame
      Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame annotation(
        Placement(transformation(origin = {-34, 16}, extent = {{-10, -10}, {10, 10}})));
      // input for global blade pitch
      Modelica.Blocks.Interfaces.RealInput blade_pitch annotation(
        Placement(transformation(origin = {-100, 86}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-92, 32}, extent = {{-8, -8}, {8, 8}})));
      // pitch positioning
      Modelica.Mechanics.Rotational.Sources.Position position(useSupport = true) annotation(
        Placement(transformation(origin = {-54, 86}, extent = {{-10, -10}, {10, 10}})));
      // revolute joint for pitch angle
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute_pitch(each n = {0, 0, 1}, each useAxisFlange = true) annotation(
        Placement(transformation(origin = {-40, 56}, extent = {{-10, -10}, {10, 10}})));
    equation
// blade tip global pitch angle
      tip_pitch_angle = bladeSection[RP.NOS].TWIST + blade_pitch_angle;
// aerodynamic forces
      forceAndTorque.force[1] = sum(bladeSection.aerodynamic_force[1, 1]);
      forceAndTorque.force[2] = sum(bladeSection.aerodynamic_force[1, 2]);
      forceAndTorque.force[3] = sum(bladeSection.aerodynamic_force[1, 3]);
// aerodynamic torques
      forceAndTorque.torque[1] = sum(bladeSection.torque_Hcs[1, 1]);
      forceAndTorque.torque[2] = sum(bladeSection.torque_Hcs[1, 2]);
      forceAndTorque.torque[3] = sum(bladeSection.torque_Hcs[1, 3]);
// wind outflow velocity
      mean_outflow_velocity[1] = sum(bladeSection.outflow_volume_stream[1])/BLADE_WHEEL_SLICE_AREA;
      mean_outflow_velocity[2] = sum(bladeSection.outflow_volume_stream[2])/BLADE_WHEEL_SLICE_AREA;
      mean_outflow_velocity[3] = sum(bladeSection.outflow_volume_stream[3])/BLADE_WHEEL_SLICE_AREA;
      when terminal() then
        Modelica.Utilities.Streams.close(BLADE_PARAMETERS_FILE);
      end when;
// CONNECTIONS
      connect(forceAndTorque.frame_b, frame_fix_hub) annotation(
        Line(points = {{-12, 0}, {-100, 0}}, color = {95, 95, 95}));
      connect(fixedFrame.frame_a, frame_fix_hub) annotation(
        Line(points = {{-44, 16}, {-44, 1}, {-100, 1}, {-100, 0}}, color = {95, 95, 95}));
      connect(absoluteAngularVelocity.frame_a, frame_fix_hub) annotation(
        Line(points = {{-92, -16}, {-92, -15}, {-100, -15}, {-100, 0}}, color = {95, 95, 95}));
      connect(revolute_pitch.frame_a, frame_fix_hub) annotation(
        Line(points = {{-50, 56}, {-100, 56}, {-100, 0}}, color = {95, 95, 95}));
      connect(bodyShape.frame_a, revolute_pitch.frame_b) annotation(
        Line(points = {{-16, 56}, {-30, 56}}, color = {95, 95, 95}));
      connect(blade_pitch, position.phi_ref) annotation(
        Line(points = {{-100, 86}, {-66, 86}}, color = {0, 0, 127}));
      connect(position.flange, revolute_pitch.support) annotation(
        Line(points = {{-44, 86}, {-38, 86}, {-38, 74}, {-46, 74}, {-46, 66}}));
      connect(position.support, revolute_pitch.axis) annotation(
        Line(points = {{-54, 76}, {-40, 76}, {-40, 66}}));
      annotation(
        uses(Modelica(version = "4.0.0")),
        Icon(graphics = {Polygon(origin = {0, 1}, fillColor = {221, 221, 221}, fillPattern = FillPattern.Solid, lineThickness = 1, points = {{-100, 7}, {100, 5}, {100, -1}, {-100, -9}, {-100, 7}}), Text(origin = {-6, 31}, textColor = {0, 0, 255}, extent = {{-40, 11}, {40, -11}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
        Diagram);
    end Blade;

    model cl_cd_test
      parameter String filePath_coeff_CL_CD = "D:/OM_Turbine/NREL/S809.txt";
      //parameter String filePath_coeff_CL_CD = "D:/OM_Turbine/NREL/S809.txt";
      Real thickness;
      Modelica.Blocks.Tables.CombiTable2Ds f_lift_alpha_thickness(fileName = filePath_coeff_CL_CD, tableName = "lift", tableOnFile = true, extrapolation = Modelica.Blocks.Types.Extrapolation(1), smoothness = Modelica.Blocks.Types.Smoothness(2));
      Modelica.Blocks.Tables.CombiTable2Ds f_drag_alpha_thickness(fileName = filePath_coeff_CL_CD, tableName = "drag", tableOnFile = true, extrapolation = Modelica.Blocks.Types.Extrapolation(1), smoothness = Modelica.Blocks.Types.Smoothness(1));
      Modelica.Units.SI.Angle alpha(displayUnit = "deg");
      Real liftCoeff, dragCoeff, lift_to_drag;
    equation
      thickness = 21;
      alpha = (time - 0.5)*2*Modelica.Constants.pi;
      f_lift_alpha_thickness.u1 = alpha*180/Modelica.Constants.pi;
      f_lift_alpha_thickness.u2 = thickness;
      f_drag_alpha_thickness.u1 = alpha*180/Modelica.Constants.pi;
      f_drag_alpha_thickness.u2 = thickness;
      liftCoeff = f_lift_alpha_thickness.y;
      dragCoeff = f_drag_alpha_thickness.y;
      lift_to_drag = liftCoeff/dragCoeff;
    end cl_cd_test;

    block BladeProperties
      //PACKAGES
      import Modelica.Units.SI;
      import Modelica.Utilities.Strings;
      import Modelica.Constants.pi;
      //INPUT PARAMETERS
      parameter String BLADE_PARAMETERS_FILE = "D:/OM_Turbine/RISO/WPC_RISO_v19.txt" "Path to blade sections parameters file";
      parameter Integer SECTION_SPLIT_NUMBER = 2 "Number of parts into which the section is split";
      // TRANSFORMING TO ELEMENTS
      final parameter Integer NOS = (rNOS - 1)*SCN "Number of sections";
      parameter SI.Length RADIUS[NOS] = {rRADIUS[div(n - 1, SCN) + 1] + (rRADIUS[div(n - 1, SCN) + 2] - rRADIUS[div(n - 1, SCN) + 1])*(2*mod(n - 1, SCN) + 1)/(2*SCN) for n in 1:(NOS)};
      parameter SI.Length DELTA_R[NOS] = {(rRADIUS[div(n - 1, SCN) + 2] - rRADIUS[div(n - 1, SCN) + 1])/SCN for n in 1:(NOS)};
      parameter SI.Length CHORD[NOS] = {rCHORD[div(n - 1, SCN) + 1] + (rCHORD[div(n - 1, SCN) + 2] - rCHORD[div(n - 1, SCN) + 1])*(2*mod(n - 1, SCN) + 1)/(2*SCN) for n in 1:(NOS)};
      parameter SI.Angle TWIST[NOS] = {rTWIST[div(n - 1, SCN) + 1] + (rTWIST[div(n - 1, SCN) + 2] - rTWIST[div(n - 1, SCN) + 1])*(2*mod(n - 1, SCN) + 1)/(2*SCN) for n in 1:(NOS)};
      parameter SI.Angle THICKNESS[NOS] = {rTHICKNESS[div(n - 1, SCN) + 1] + (rTHICKNESS[div(n - 1, SCN) + 2] - rTHICKNESS[div(n - 1, SCN) + 1])*(2*mod(n - 1, SCN) + 1)/(2*SCN) for n in 1:(NOS)};
      parameter String AIRFOIL_FILE[NOS] = {rAIRFOIL_FILE[div(n - 1, SCN) + 1] for n in 1:(NOS)};
      parameter SI.Length TOTAL_RADIUS = rRADIUS[rNOS] "Total blade radius";
    protected
      //READING TEXT FILE
      parameter String PARAMETERS_MATRIX[:, :] = txt2mat(filePath = BLADE_PARAMETERS_FILE, separator = "\t", numColums = 5);
      // READING CROSS SECTIONS PARAMETERS
      //get parameters matrix size
      parameter Integer matrix_size[:] = size(PARAMETERS_MATRIX) "Matrix size";
      parameter Integer rNOS = (matrix_size[1]) "Number of rows in file";
      //read cross-section rotor parameters
      parameter SI.Length rRADIUS[rNOS] = {Strings.scanReal(PARAMETERS_MATRIX[n, 1]) for n in 1:rNOS} "Blade section radius";
      parameter SI.Length rCHORD[rNOS] = {Strings.scanReal(PARAMETERS_MATRIX[n, 2]) for n in 1:rNOS} "Blade section chord";
      parameter SI.Angle rTWIST[rNOS] = {pi/180*Strings.scanReal(PARAMETERS_MATRIX[n, 3]) for n in 1:rNOS} "Blade section twist angle";
      parameter String rAIRFOIL_FILE[rNOS] = {Strings.scanString(PARAMETERS_MATRIX[n, 4]) for n in 1:rNOS} "Section airfoil characteristic file";
      parameter Real rTHICKNESS[rNOS] = {Strings.scanReal(PARAMETERS_MATRIX[n, 5]) for n in 1:rNOS} "Profile thickness";
      parameter Integer SCN = SECTION_SPLIT_NUMBER;
    end BladeProperties;

    extends Modelica.Icons.Package;
  end Internal;
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Rectangle(lineColor = {128, 128, 128}, extent = {{-100, -100}, {100, 100}}, radius = 25), Ellipse(origin = {0, 32}, fillColor = {192, 192, 197}, fillPattern = FillPattern.VerticalCylinder, extent = {{-8, 42}, {8, -42}}), Ellipse(origin = {-36, -32}, rotation = 120, fillColor = {192, 192, 197}, fillPattern = FillPattern.VerticalCylinder, extent = {{-8, 42}, {8, -42}}), Ellipse(origin = {36, -32}, rotation = 240, fillColor = {192, 192, 197}, fillPattern = FillPattern.VerticalCylinder, extent = {{-8, 42}, {8, -42}}), Ellipse(origin = {0, -10}, fillColor = {190, 190, 190}, fillPattern = FillPattern.Sphere, extent = {{-10, 10}, {10, -10}})}));
end WindTurbinePackage;
