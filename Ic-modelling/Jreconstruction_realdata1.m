%constant definitions
fluxQuantum = 2.06783383E-15;
lambda = 39E-9; %London penetration depth of Niobium

%geometry
d = 10E-9; L = 300E-9;

%file i/o
filename = 'data.csv';
A = csvread(filename);

%physical quantities
N = size(A); n = N(1);
Ic_max = zeros(n,1);
B = zeros(n,1);
for i=1:n
    B(i) = A(i,1);
    Ic_max(i) = A(i,3);
end
beta = 2*pi*(2*lambda+d)*B/fluxQuantum;

% I0 = 200E-6; %peak
% 
% Ic = @(x)I0*abs(sinc(x*L*(2*lambda+d)/fluxQuantum));
% 
% Ic_max = Ic(beta);

plot(B, Ic_max);
% Ic_prime = spline(B,Ic_max,B);
% plot(B,Ic_max,'b',B,Ic_prime,'m');

[I_even, minX] = flipFn(Ic_max,beta);
%plot(beta,I_even);

%I_odd = interp1(beta, I_even, minX);
I_odd = zeros(size(I_even)); %debugging

Ix = I_even + 1j*I_odd;

Jx = ifft(Ix);

Jx = ifftshift(abs(Jx));

plot(beta, Ic_max, 'r', beta, I_even, 'g', beta, I_odd, 'b');

spac_vect = linspace(-10E-9,10E-9,n);
%plot(beta, Jx);
plot(spac_vect, Jx*1000);


