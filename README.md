# Wind turbine modeling in Modelica language

## Physical model
<p align="center">
<img src="https://github.com/user-attachments/assets/57209a9d-1b9c-4e7b-9e3f-02a5b7e08ad4" width="800"
</p>

<p align="center">
<img src="https://github.com/user-attachments/assets/32259229-234b-489a-8e41-ee4f845ff3d1" width="600"
</p>

## Modeloca scheme
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


