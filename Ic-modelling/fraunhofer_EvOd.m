%constant definitions
fluxQuantum = 2.06783383E-15;
lambda = 39E-9; %London penetration depth of Niobium

%geometry
d = 10E-9; L = 100E-9;

%physical quantities
width = 0.16; N=500;
B = linspace(-width,width,N);
beta = 2*pi*(2*lambda+d)*B/fluxQuantum;
I0 = 200E-6; %peak

Ic = @(x)I0*abs(sinc(x*L*(2*lambda+d)/fluxQuantum));

Ic_max = Ic(beta);
plot(beta, Ic_max);

[I_even, minX] = flipFn(Ic_max,beta);
%plot(beta,I_even);

%I_odd = interp1(beta, I_even, minX);
I_odd = zeros(size(I_even)); %debugging

Ix = I_even + 1j*I_odd;

Jx = ifft(Ix);
%Jx = ifft(sinc(beta*L*(2*lambda+d)/fluxQuantum));
%Jx = ifft(sinc(beta*L*(2*lambda+d)/fluxQuantum));

Jx = ifftshift(abs(Jx));

plot(beta, Ic_max, 'r', beta, I_even, 'g', beta, I_odd, 'b');
plot(beta, Jx);

