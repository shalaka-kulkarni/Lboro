%constant definitions
u0 = 1.25663706E-6;
ur = 150; %relative permeability of the material
fluxQuantum = 2.06783383E-15;
lambda = 39E-9; %London penetration depth of Niobium

%geometry
d = 10E-9; L = 100E-9;

%physical quantities
width = 1; N=500;
B = linspace(-width,width,N);
flux = B*L*(2*lambda + d);
I0 = 200E-6; %peak

dim = linspace(-1E-9,1E-9,N);

Ic = @(x)I0*abs(sinc(x*L*(2*lambda+d)/fluxQuantum));
beta = 2*pi*(2*lambda+d)*B/fluxQuantum;

%theta = @(x)imag(hilbert(log(Ic(x))));
f = @(x,y)(x/(2*pi))*(log(Ic(y)) - log(Ic(x)))/(x^2 - y^2);
for k=1:N
    theta
end
plot(beta,Ic(B))
plot(beta,theta(beta));
    
%transform = zeros(size(B));
Ix = zeros(size(B));
for k=1:N
   %transform = @(x)Ic(x).*exp(1j*theta(x)); 
   exp_part = @(x)exp(1i*(theta(beta(k))-beta(k)*x));
   ft = @(x)(0.5/pi)*integral(@(beta)Ic(beta(k))*exp_part(x),beta(1),beta(N));
   Ix(k) = ft(dim(k));
end

%Ix = ifft(transform(beta));

%plot(beta,Ix,'r',beta,Ic(B),'g');
%plot(beta,Ix);
%plot(beta,log(Ic(beta)));
%plot(dim,transform(beta));
%plot(beta,fft(Ix));
plot(dim,ft(dim));
