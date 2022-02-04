## Repository:

PRED_PREY_SIM_FD1D is a collection of MATLAB codes for simulating Predator-Prey interactions in 1D.

[![DOI](https://zenodo.org/badge/139026916.svg)](https://zenodo.org/badge/latestdoi/139026916)

## Cite as:

Marcus R. Garvie. (2022). mgarvie/PRED_PREY_SIM_FD1D: Initial release (v1.0.0). Zenodo. https://doi.org/10.5281/zenodo.5963689

## General Decsription:

PRED_PREY_SIM_FD1D is a collection of simple MATLAB routines using finite element / difference methods for simulating the dynamics of predator-prey interactions in one spatial dimension and time modelled by nonlinear reaction-diffusion systems. 

The MATLAB code is mostly self explanatory, with the names of variables and parameters corresponding to the symbols used in the finite element / difference methods described in the paper referenced below. 

The code employs the sparse matrix facilities of MATLAB when solving the linear systems, which provides advantages in both matrix storage and computation time. The code is vectorized to minimize the number of "for-loops" and conditional "if-then-else" statements, which again helps speed up the computations. There is just one "for-loop" and no "if-then-else" statements in the code.

The linear systems are solved using MATLAB's built in function lu.m. We remark that a pure C or FORTRAN code is likely to be faster than our codes, but with the disadvantage of much greater complexity and length.

The user is prompted for all the necessary parameters, time and space-steps, and initial data. Due to a limitation in MATLAB, vector indices cannot be equal to zero; thus the nodal indices 0, . . .,J are shifted up one unit to give i=1, . . . ,(J + 1) so xi=(i - 1)*h + a. See Line 28 in the code.

## Format of initial data

The initial data functions are entered by the user as a string, which can take several different formats. Functions are evaluated on an element by element basis, where x=(x1, . . .,xJ+1) is a vector of grid points, and so a "." must precede each arithmetic operation between vectors. The exception to this rule is when applying MATLAB's intrinsic functions where there is no ambiguity. Some arbitrary examples with an acceptable format include the following:

        >> Enter initial prey function u0(x)  0.2*exp(-(x-100).^2)
        >> Enter initial predator function v0(x)  0.4*x./(1+x)
      
or,
        >> Enter initial prey function u0(x)  0.3+(x-1200).*(x-2800)
        >> Enter initial predator function v0(x)  0.4
      
This last example shows that for a constant solution vector we need only enter a single number. It is also possible to enter functions that are piecewise defined by utilizing MATLAB's logical operators &, ('AND'), |, ('OR'), and ~ (`NOT'), applied to matrices. For example, on a domain Omega=[0,200], to choose an initial prey density that is equal to 0.4 for 90<=xi<=110, and equal to 0.1 otherwise, the user inputs:

        >> Enter initial prey function u0(x)  0.4*((x>90)&(x<110))+0.1*((x<=90)|(x>=110))
      
## Some practical issues

Firstly, bear in mind that if you run a simulation with a large domain size and large final time T, coupled with small temporal and spatial discretization parameters, then the run-time in MATLAB can be prohibative.

Another point concerns the choice of parameters alpha, beta, and gamma used to run the code. In order for the local kinetics of the systems (Kinetics (i) or Kinetics (ii)) to be biologically meaningful, there are restrictions on the parameters that need to be satisfied (for further details see the reference below).

## Reference

Garvie M.R. , "Finite difference schemes for reaction-diffusion equations modeling predator-prey interactions in MATLAB," Bulletin of Mathematical Biology (2007) 69:931-956. 

## Download codes for FD1D

Files you may copy include:

    fd1d.m    MATLAB code for Scheme 2 applied to Kinetics (i) in 1D.
    fd1dKin2.m    MATLAB code for Scheme 2 applied to Kinetics (ii) in 1D.
    fd1dx.m    MATLAB code for Scheme 1 applied to Kinetics (i) in 1D.
    fd1dxKin2.m    MATLAB code for Scheme 1 applied to Kinetics (ii) in 1D.
    fd1d.inp    a text file containing the input that a user might enter to define a simple problem.
    fd1d.out    printed output from a run of the program with the sample input.
    fd1d.jpg    a JPEG file containing an image of the u and v components of the solution generated from fd1d.m.
    copyright.txt    PRED_PREY_SIM copyright details.

PRED_PREY_SIM_FD2D is distributed under the GNU GPL; see the mycopyright.txt file for more information.
