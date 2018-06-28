% fd1dx.m   1D finite-difference method for Scheme 1 applied to the predator-prey system with Kinetics 1.
% (C) 2005 Marcus R. Garvie. See COPYRIGHT.TXT for details.
% User inputs of parameters
alpha = input('Enter parameter alpha   ');
beta = input('Enter parameter beta   ');
gamma = input('Enter parameter gamma   ');
delta = input('Enter parameter delta   ');
a = input('Enter a in [a,b]   ');
b = input('Enter b in [a,b]  ');
h = input('Enter space-step h   ');
T = input('Enter maximum time T   ');
delt = input('Enter time-step Delta t   ');
% User inputs of initial data
u0 = input('Enter initial data function u0(x)   ','s'); % see notes
v0 = input('Enter initial data function v0(x)   ','s'); %   in text
% Calculate some constants
mu=delt/(h^2);
J=round((b-a)/h);
n = J+1;   % no. of nodes (d.f.) for each dependent variable                        
N=round(T/delt);
% Initialization
u=zeros(n,1); v=zeros(n,1); diag=zeros(n,1); diag_entries=zeros(n,1);
indexI=zeros(n,1); x=zeros(n,1); L=sparse(n,n); A0=sparse(n,n); 
C0=sparse(n,n); A=sparse(n,n); B=sparse(n,n); C=sparse(n,n);
% Assign initial data
indexI=[1:n]'; 
x=(indexI-1)*h+a;   % vector of x values on grid
u = eval(u0).*ones(n,1); v = eval(v0).*ones(n,1);
% Construct matrix L (without 1/h^2 factor)
L=sparse(1,2,-2,n,n);
L=L+sparse(n,n-1,-2,n,n);
L=L+sparse(2:n-1,3:n,-1,n,n);
L=L+sparse(2:n-1,1:n-2,-1,n,n);
L=L+sparse(1:n,1:n,2,n,n);
% Construct fixed parts of matrices A_{n-1} and C_{n-1}
L=mu*L;
A0=L+sparse(1:n,1:n,1-delt,n,n);
C0=delta*L+sparse(1:n,1:n,1+delt*gamma,n,n);
% Time-stepping procedure
for nt=1:N
    % Update coefficient matrices of linear system
    diag = abs(u);
    diag_entries= u./(alpha + abs(u));
    A = A0 + delt*sparse(1:n,1:n,diag,n,n);
    B = delt*sparse(1:n,1:n,diag_entries,n,n);
    C = C0 - delt*beta*sparse(1:n,1:n,diag_entries,n,n);
    v = C\v;
    u = A\(u - B*v);    
end
% Plot solution at time level T=N*delt
plot(x,u,'k'); hold on; plot(x,v,'k-.')
