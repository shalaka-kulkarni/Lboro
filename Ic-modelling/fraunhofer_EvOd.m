%constant definitions
fluxQuantum = 2.06783383E-15;
lambda = 90E-9; %London penetration depth of Niobium

%geometry
d = 10E-9; L = 500E-9;

%physical quantities
Bwidth = 0.1; %100mT
N = 200; %no. of data points
B = linspace(-Bwidth,Bwidth,N);
beta = 2*pi*(2*lambda+d)*B/fluxQuantum;
I0 = 200E-6; %peak current of 200uA

Ic = @(x)I0*abs(sinc(x*L*(2*lambda+d)/fluxQuantum)); %sample fraunhofer pattern

Ic_max = Ic(B);
plot(B*1E3, Ic_max*1E6)
title('Peak critical current vs Magnetic field')
xlabel('B (mT)')
ylabel('I_c (uA)')

[I_even, minX,minCount] = flipFn(Ic_max,B);
%plot(beta,I_even);
if I_even(N/2)<0
    for i=1:N
        I_even(i) = - I_even(i);
    end
end

I_odd = interp1(B,Ic_max,minX);%-Ic_max(N/2);
plot(minX,I_odd,'-o');
%I_odd = interp_flip(beta, Ic_max, minX, minCount);
%I_odd = zeros(size(I_even)); %debugging

Ix = I_even + 1j*I_odd;

Jx = ifft(Ix);
%Jx = ifft(sinc(beta*L*(2*lambda+d)/fluxQuantum));

Jx = ifftshift(abs(Jx));

plot(B*1E3, I_even*1E6, 'm', B*1E3, I_odd*1E6, 'b')
title('Even and odd components of peak critical current')
xlabel('B (mT)')
ylabel('I_c (uA)')
legend('I_e', 'I_o')

spac_vect = linspace(-2*d*1E9,2*d*1E9,N);
%plot(beta, Jx);
plot(spac_vect, Jx*1E6)
title('Current density')
xlabel('x (nm)')
ylabel('J (uA/m^2)')
