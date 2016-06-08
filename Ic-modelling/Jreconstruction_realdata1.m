%constant definitions
fluxQuantum = 2.06783383E-15;
lambda = 90E-9; %London penetration depth of Niobium

%geometry
d = 10E-9; L = 500E-9;

%file i/o
filename = 'data3.csv';
A = csvread(filename);

%physical quantities
N = size(A); n = N(1);
Ic_max = zeros(1,n);
B = zeros(1,n);
for i=1:n
    B(i) = A(i,1); %in mT
    Ic_max(i) = A(i,2); %in mA
end

plot(B, Ic_max*1E3)
title('Peak critical current vs Magnetic field')
xlabel('B (mT)')
ylabel('I_c (uA)')

[I_even, minX] = flipFn(Ic_max,B);

%I_odd = interp1(B, I_even, minX);% - Ic_max(floor(n/2));
I_odd = zeros(size(I_even)); %debugging
%plot(minX,I_odd);

Ix = I_even + 1j*I_odd;

Jx = ifft(Ix);

Jx = ifftshift(abs(Jx));
plot(Jx);

plot(B, I_even*1E3, 'm', minX, I_odd*1E3, 'b')
title('Even and odd components of peak critical current')
xlabel('B (mT)')
ylabel('I_c (uA)')
legend('I_e', 'I_o')

spac_vect = linspace(-L/2,L/2,n);
a = simFraunhofer(d,L,abs(B(n)),n,spac_vect);
plot(a*spac_vect*1E9, Jx*1E3, '-o');
title('Current density')
xlabel('x (nm)')
ylabel('J (uA/m^2)')


