%--------------------------------------------------------------------
%This version of the code contains use of the inbuilt hilbert function as
%well as the inbuilt ifft function
%The variable x is used to construct functions consistently (local to each
%function) and finally beta is substituted
%Gives a graph of an impulse of height ~ 2E-11 at the origin
%--------------------------------------------------------------------

%constant definitions
u0 = 1.25663706E-6;
ur = 150; %relative permeability of the material
fluxQuantum = 2.06783383E-15;
lambda = 39E-9; %London penetration depth of Niobium

%geometry
d = 10E-9; L = 100E-9;

%physical quantities
width = 1; N=500;
B = linspace(-width,width,N);  %magnetic field vector
flux = B*L*(2*lambda + d);
I0 = 200E-6; %peak

dim = linspace(-d,d,N); %arbitrary length dimension vector

Ic = @(x)I0*abs(sinc(x*L*(2*lambda+d)/fluxQuantum));
beta = 2*pi*(2*lambda+d)*B/fluxQuantum;

%implementing eqn(5) from the paper
theta = @(x)imag(hilbert(log(Ic(x))));

plot(beta,Ic(B))
plot(beta,theta(beta));

for k=1:N
   %constructing a function of beta called transform which is essentially
   %the fourier transform of Ix, to be inverse-transformed later
   transform = @(x)Ic(x).*exp(1j*theta(x)); 
end

%inverse transform
%Ix is the current density integrated along one dimension (expected to be a
%square pulse from -d to +d)
Ix = ifft(transform(beta));

plot(dim,transform(beta));
