# PRED_PREY_SIM_FD1D
Simulating Predator-Prey Interactions in 1D

PRED_PREY_SIM is a collection of simple MATLAB routines using finite element / difference methods for simulating the dynamics of predator-prey interactions modelled by nonlinear reaction-diffusion systems. The collection of codes in 1D and 2D are called FD1D and FD2D respectively. 

FD1D is a collection of MATLAB routines using finite element / difference methods for the dynamics of predator-prey interactions in 1 spatial dimension and time (part of PRED_PREY_SIM).

The MATLAB code is mostly self explanatory, with the names of variables and parameters corresponding to the symbols used in the finite element / difference methods described in the paper referenced below. Copies of the MATLAB codes are freely available via the link below.

The code employs the sparse matrix facilities of MATLAB when solving the linear systems, which provides advantages in both matrix storage and computation time. The code is vectorized to minimize the number of "for-loops" and conditional "if-then-else" statements, which again helps speed up the computations. There is just one "for-loop" and no "if-then-else" statements in the code.

The linear systems are solved using MATLAB's built in function lu.m. We remark that a pure C or FORTRAN code is likely to be faster than our codes, but with the disadvantage of much greater complexity and length.

The user is prompted for all the necessary parameters, time and space-steps, and initial data. Due to a limitation in MATLAB, vector indices cannot be equal to zero; thus the nodal indices 0, . . .,J are shifted up one unit to give i=1, . . . ,(J + 1) so xi=(i - 1)*h + a. See Line 28 in the code.

## Line-by-line description of the code for Scheme 2

The code for fd1d.m and fd1dKin2.m are structured below. The codes for Scheme 1 (fd1dx.m and fd1dxKin2.m) are similar, but instead of using MATLAB's lu.m function they use the backslash ('left-division') facility.

    Lines 4-12: User prompted for model parameters.
    Lines 14-15: User prompted for initial data as a string (allowable formats discussed below).
    Lines 17-20: Calculation of some constants.
    Lines 22-25: Initialization of matrices.
    Lines 27-29: Initial data assigned numerically.
    Lines 31-38: Assembly of matrices L, B1, and B2.
    Lines 40-41: LU factorization of B1 and B2.
    Lines 43-59: Solving the linear system repeatedly up-to time level tN=T using forward and backward substitution.
    Line 61: Numerical solution plotted for u and v at time T.

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

    Garvie M.R. , "Finite difference schemes for reaction-diffusion equations modeling predator-prey interactions in MATLAB," submitted to Bulletin of Mathematical Biology.

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

PRED_PREY_SIM is distributed under the GNU GPL; see the License and Copyright notice for more information. 
