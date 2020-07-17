# Plasma Frequency and Permittivity

Plasma is one of the four fundamental states of matter and it consists of a gas of ions (atoms which have some of their orbital electrons removed) and free electrons. Plasma and ionized gases have properties and behaviours unlike those of the other states. 

Surface plasmons are coherent delocalized electron oscillations that exist at the interface between any two materials where the real part of the dielectric function changes sign across the interface (e.g. a metal-dielectric interface, such as a metal sheet in air). SPs have lower energy than bulk (or volume) plasmons which quantise the longitudinal electron oscillations about positive ion cores within the bulk of an electron gas (or plasma). 

In general, a material cannot polarize instantaneously in response to an applied field. The polarization is a convolution of the electric field at previous times with time-dependent susceptibility. As opposed to the response of a vacuum, the response of normal materials to external fields generally depends on the frequency of the field.

This repository contains a [MATLAB code](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/plasma_frequency_and_permittivity.m) used to calculate plasma frequency, plot the relation ω(β) and plot how permittivity changes as a function of frequency. 

# MATLAB Application

The code "plasma_frequency_and_permittivity.m" displays three plots as shown below. These charts are 
* Dispersion relation for a plasma propagating in air and dispersion relation for a surface plasmon propagating in a metal (copper)
* Electronic contribution to permittivity
* Dipolar contribution to permittivity

The parameters used to plot these charts are the characteristic value of copper:
| Resistivity | Electron density | Relative permittivity medium 1 | Effective mass |
|-------------|------------------|--------------------------------|----------------|
| 1.72*10^-8  | 8.47*10^28       | 1                              | 1              |

*Dispersion relation*
![](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/Dispersion%20relation.png)

*Electronic contribution to permittivity*
![](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/Electronic%20contibution%20to%20permittivity.png)

*Dipolar contribution to permittivity*
![](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/Dipolar%20contibution%20to%20permittivity.png)

# MATLAB Graphic Application
You can download the installer for the standalone application (without Matlab) [here](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/app/for_redistribution/) using "MyAppInstaller_web.exe". 

## How to intall
1. Open "MyAppInstaller_web.exe"
2. You need to install the [MATLAB Runtime](https://it.mathworks.com/products/compiler/matlab-runtime.html) to run this app. 
3. Install the application 
4. Run the app

## The GUI
Using the [MATLAB GUI](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/plasma_frequency_and_permittivity_app.mlapp) the user can set the resistivity, the electron density, the relative permittivity of the first medium and the effective mass as shown in the figure below.

*Dispersion relation*
![](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/Dispersion%20relation%20app.png)

*Eletronic contribution to permittivity*
![](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/Electronic%20contibution%20to%20permittivity%20app.png)

*Dipolar contribution to permittivity*
![](https://github.com/MatteoOrlandini/plasma_frequency_and_permittivity/blob/master/Dipolar%20contibution%20to%20permittivity%20app.png)
