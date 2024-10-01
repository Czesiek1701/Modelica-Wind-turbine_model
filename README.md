# Wind turbine modeling in Modelica language

## Physical model
<p align="center">
<img src="https://github.com/user-attachments/assets/57209a9d-1b9c-4e7b-9e3f-02a5b7e08ad4" width="800"
</p>

<p align="center">
<img src="https://github.com/user-attachments/assets/32259229-234b-489a-8e41-ee4f845ff3d1" width="600"
</p>

## Modelica scheme
<p align="center">
<img src="https://github.com/user-attachments/assets/cda04deb-f9b6-4e54-9301-8cb014e7527e" width="800"
</p>

## Mathematical model
Nonlinear airfoil characteristics crossed with Betz theory. Corrections applied: Glauert, Prandtl, Spera.
<p align="center">
<img src="https://github.com/user-attachments/assets/d50133d6-0e46-408e-a552-e455d479f772" width="300"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/2a6d3ccc-eb71-45d9-8dac-4513a2448e5c" width="300"
</p>

## Programming results
Useful model aspects:
* Rotor can be connected with generator by modelica _flange_
* Rotor can have non axial direction to wind
* Blades are parametrized by files (section radius, chord, twist, thickness and airfoil characteristic file)
* Airfoil characteristics can be inteerpolated between given thicknessees
* Pitch angle is controlled all time, each blade can have independent pitch
* You can set many rotors in one _WindSource_, couple wind distributions or connect rotor _WindSource_ with many rotors
* Gyroscopic torque is coupled to construction by _frame_.
<p align="center">
<img src="https://github.com/user-attachments/assets/3066870d-5fbb-4107-8d70-47693da81ed0" width="200"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/555f4e0b-a1a8-49eb-98e0-061e7a530110" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/2e54f709-50fd-45d3-8225-664795e0e2a8" width="800"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/4e8e443b-cc8e-4c7a-a143-b7fca0d360dc" width="800"
</p>

---
**Sample input files**

*Blade Geometry* </br>
"Radius [m]"		"Chord [m]"	"Twist [deg]"	"Characteristic file [""]"	"Thickness [%]" </br>
2.70	1.090	15.0	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	24.6 </br>
3.55	1.005	09.5	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	20.7 </br>
4.40	0.925	06.1	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	18.7 </br>
5.25	0.845	03.9	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	17.6 </br>
6.10	0.765	02.4	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	16.6 </br>
6.95	0.685	01.5	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	15.6 </br>
7.80	0.605	00.9	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	14.6 </br>
8.65	0.525	00.4	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	13.6 </br>
9.50	0.445	00.0	"D:/OM_Turbine/RISO/NACA_63n-2nn_2D.txt"	12.6 </br> </br> 

*Airfoil characteristics* </br>
#1
double lift(35,6)   # 	thickness, alfa - lift </br>
 0.00	 12.0	 15.0	 16.0	 21.0	 25.0	# foil thicknesses </br>
-4.00	-0.25	-0.25	-0.25	-0.25	-0.25 </br>
-2.00	-0.06	-0.06	-0.06	-0.06	-0.06 </br>
 0.00	 0.16	 0.16	 0.16	 0.16	 0.16 </br>
 2.00	 0.38	 0.38	 0.38	 0.38	 0.38 </br>
 4.00	 0.60	 0.60	 0.60	 0.60	 0.60 </br>
 6.00	 0.82	 0.82	 0.82	 0.82	 0.81 </br>
 8.00	 1.04	 1.03	 1.01	 1.00	 0.98 </br>
 10.0	 1.26	 1.23	 1.19	 1.14	 1.08 </br>
 12.0	 1.43	 1.36	 1.29	 1.20	 1.12 </br>
 14.0	 1.50	 1.42	 1.32	 1.21	 1.12 </br>
 16.0	 1.34	 1.30	 1.25	 1.18	 1.09 </br>
 18.0	 0.80	 1.05	 1.10	 1.12	 1.06 </br>
 20.0	 0.70	 0.85	 1.00	 1.05	 1.04 </br>
 25.0	 0.92	 0.95	 0.97	 0.99	 1.01 </br>
 30.0	 0.99	 1.00	 1.01	 1.02	 1.03 </br>
 40.0	 0.99	 1.00	 1.01	 1.02	 1.03 </br>
 50.0	 0.92	 0.92	 0.92	 0.92	 0.92 </br></br>
#2
double drag(35,6)   # 	thickness, alfa - lift </br>
 0.00	 12.0	  15.0	  16.0	  21.0	  25.0	   # foil thicknesses </br>
-4.00	0.0080	0.0080	0.0080	0.0080	0.0080	 </br>
-2.00	0.0060	0.0060	0.0060	0.0060	0.0060	 </br>
 0.00	0.0048	0.0052	0.0058	0.0064	0.0073	 </br>
 2.00	0.0048	0.0052	0.0058	0.0063	0.0072	 </br>
 4.00	0.0056	0.0058	0.0061	0.0065	0.0073	 </br>
 6.00	0.0080	0.0080	0.0080	0.0079	0.0078	 </br>
 8.00	0.0110	0.0110	0.0108	0.0105	0.0102	 </br>
 10.0	0.0158	0.0156	0.0154	0.0152	0.0150	 </br>
 12.0	0.0240	0.0230	0.0225	0.0218	0.0210	 </br>
 14.0	0.0400	0.0380	0.0360	0.0340	0.0320	 </br>
 16.0	0.0700	0.0700	0.0700	0.0700	0.0700	 </br>
 18.0	0.1500	0.1500	0.1500	0.1500	0.1500	 </br>
 20.0	0.2150	0.2200	0.2250	0.2300	0.2350	 </br>
 25.0	0.3700	0.3600	0.3500	0.3400	0.3300	 </br>
 30.0	0.4700	0.4700	0.4600	0.4500	0.4500	 </br>
 40.0	0.6600	0.6600	0.6600	0.6600	0.6600	 </br>
 50.0	0.8500	0.8500	0.8500	0.8500	0.8500	 </br>

---

## Veryfication with QBlade v0.963
<p align="center">
<img src="https://github.com/user-attachments/assets/d49d89ab-ddb5-4194-a8d0-610d5709bb59" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/51dd760c-fb22-446e-86d5-b2b89dca7b95" width="600"
</p>

## Validation
Validation based on final report
of IEA AnnexXVIII: ’Enhanced Field Rotor Aerodynamics Database’, Netherlands,
Energy research Centre of the Netherlands ECN, 2002. </br>
Chosen turbines - RISO and NREL. Airfoil characteristics taken from the exprimental data provided in the report. </br> </br>
Designations:
* $P$ - power
* $\alpha$ - angle of attack at section
* $\alpha_{in}$ - inflow angle of attack at section
* $\theta$ - blade tip pitch angle
* $\beta$ - tilt angle
* $\gamma$ - azimuthal angle
* $\alpha_H$ - Shear coefficient
* $v_w$ - wind speed at hub (measured at different points in report)
* $t$ - time

<p align="center">
<img src="https://github.com/user-attachments/assets/7534387e-78f3-4ae9-8ddb-679fdb34ce98" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/0b1f1079-74df-44d8-927e-9e8df0f9a767" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/646e8586-a97f-4971-945b-a9c1df3ffeef" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/2ea9c070-02c0-4528-86d0-411964ef5fe3" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/bee85129-453a-4a0e-b461-3a0fd061766c" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/f48999af-615f-4ca2-92ac-ffedc29ab9bf" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/9552367a-9ecb-4e78-855c-bf1eabbda233" width="600"
</p>
<p align="center">
<img src="https://github.com/user-attachments/assets/f06cdbd4-0d03-4c24-920f-a76af98a336b" width="600"
</p>


