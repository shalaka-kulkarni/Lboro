%constant definitions
u0 = 1.25663706E-6;
ur = 150; %relative permeability of the material
fluxQuantum = 2.06783383E-15;
lambda = 39E-9; %London penetration depth of Niobium

%geometry
d = 10E-9;
L = 100E-9;

%physical quantities
width = 1; N=500;
B = linspace(-width,width,N);
flux = B*L*(2*lambda + d);
I0 = 200E-6; %peak current

Ic = @(x)I0*abs(sinc(x*L*(2*lambda+d)/fluxQuantum));

%funx = @(b,c) (c./(2*pi))*(log(Ic(b)) - log(Ic(c)))./(c.^2 - b.^2);

beta = 2*pi*(2*lambda+d)*B/fluxQuantum;

%for i=1:N
    %theta(i) = integral(@(b)funx(b,beta(i)),-Inf,Inf,'PrincipalValue',true); 
    %this is becoming an infi integral. doesnt the integral fn handle limits?
    
%     syms b1 c1;
%     f = (beta(i)/(2*pi))*(log(Ic(b1)) - log(Ic(beta(i))))/(beta(i)^2 - b1^2);
%     thetaval = int(f,b1,-2E8,2E8,'PrincipalValue',true); 
%     thetaval

theta = imag(hilbert(log(Ic(beta))));
    
%end 

plot(beta,Ic(B))
plot(beta,theta)
    
transform = Ic(beta).*exp(theta);

Ix = ifft(transform);

plot(beta,Ix,'r',beta,Ic(B),'g');
plot(beta,Ix);
