function a = simFraunhofer(d,L,Bwidth,N)
    %constant definitions
    fluxQuantum = 2.06783383E-15;
    lambda = 90E-9; %London penetration depth of Niobium

    B = linspace(-Bwidth,Bwidth,N);
    I0 = 200E-6; %peak current of 200uA

    Ic = @(x)I0*abs(sinc(x*L*(2*lambda+d)/fluxQuantum)); %sample fraunhofer pattern

    Ic_max = Ic(B);

    [I_even, minX,minCount] = flipFn(Ic_max,B);
    if I_even(floor(N/2))<0
        for i=1:N
            I_even(i) = - I_even(i);
        end
    end

    I_odd = interp1(B,Ic_max,minX);

    Ix = I_even + 1j*I_odd;

    Jx = ifft(Ix);
    Jx = ifftshift(abs(Jx));
    
    %find ends of pulse = pth index of Jx
    [p1,p2] = getBoundary(Jx);
    
    %get X(p) as X(p) = avg(abs(X(p1)+X(p2)))
    lim = (abs(B(p1)) + abs(B(p2)))/2;
    
    %L/X(p) is the factor by which the scale should be expanded
    %L-->L*L/X(p) => X(p)-->X(p)*L/X(p)=L. Hence we get the pulse in our margins
    %return a=L/X(p)
    a = L/lim; 
    
    spac_vect = linspace(-(L/2)*1E9,(L/2)*1E9,N);
    plot(a*spac_vect,Jx);
