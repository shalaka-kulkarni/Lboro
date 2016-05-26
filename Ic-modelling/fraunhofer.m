%--------------------------------------------------------------------
%This version of the code contains use of the inbuilt hilbert function, and
%my own integral equation
%Error @ line 36 : "Index exceeds matrix dimensions"
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
B = linspace(-width,width,N); %magnetic field vector
flux = B*L*(2*lambda + d);
I0 = 200E-6; %peak

dim = linspace(-d,d,N); %arbitrary length dimension vector

Ic = @(x)I0*abs(sinc(x*L*(2*lambda+d)/fluxQuantum));
beta = 2*pi*(2*lambda+d)*B/fluxQuantum;

%implementing eqn(5) from the paper
theta = @(x)imag(hilbert(log(Ic(x))));

plot(beta,Ic(B))
plot(beta,theta(beta));
    
ft = zeros(size(B));
for k=1:N
   %constructing the exponential part with which Ic(beta) is multiplied in
   %eqn(6) from the paper
   exp_part = @(x)exp(1i*(theta(beta(k))-beta(k)*x));
   
   %implementing eqn(6) from the paper
   ft = @(x)(0.5/pi)*integral(@(beta)Ic(beta(k))*exp_part(x),beta(1),beta(N));
end

plot(dim,ft(dim));
