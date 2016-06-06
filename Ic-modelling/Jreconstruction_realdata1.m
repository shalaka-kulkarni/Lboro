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
Ic_max = zeros(1,n);
B = zeros(1,n);
for i=1:n
    B(i) = A(i,1); %in mT
    Ic_max(i) = A(i,3); %in mA
end

plot(B, Ic_max*1E3)
title('Peak critical current vs Magnetic field')
xlabel('B (mT)')
ylabel('I_c (uA)')

[I_even, minX] = flipFn(Ic_max,B);

%I_odd = interp1(B, I_even, minX);% - Ic_max(floor(n/2));
I_odd = zeros(size(I_even)); %debugging

Ix = I_even + 1j*I_odd;

Jx = ifft(Ix);

Jx = ifftshift(abs(Jx));

plot(B, I_even*1E3, 'm', B, I_odd*1E3, 'b')
title('Even and odd components of peak critical current')
xlabel('B (mT)')
ylabel('I_c (uA)')
legend('I_e', 'I_o')

spac_vect = linspace(-d,d,n);
%plot(B, Jx);
plot(spac_vect*1E9, Jx*1E3, '-o');
title('Current density')
xlabel('x (nm)')
ylabel('J (uA/m^2)')


