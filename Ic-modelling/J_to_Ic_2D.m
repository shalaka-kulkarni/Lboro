%current density predefined/known
fluxQuantum = 2.06783383E-15;
L = 500E-9; w = 100E-9; d = 10E-9; N = 100;
c = 2*pi*d/fluxQuantum;

pulse = @(t,a)(heaviside(t+a) - heaviside(t-a));
J1 = @(x,y) pulse(x,L/2)*pulse(y,w/2);
% J1 = @(x,y) (pulse(x,L/2)-pulse(x,L/4))*pulse(y,w/2);

xvec = linspace(-L,L,N);
yvec = linspace(-w,w,N); 
Bwidth = 0.15;
tth = 1000; %tan theta, theta being the angle betn By and Beff

By = linspace(-Bwidth,Bwidth,N);
Bx = tth*By; 
kx = c*By; ky = c*Bx;

Ix = zeros(size(xvec));
for i=1:N
    Ix(i) = integral(@(y)(J1(xvec(i),y)*exp(-1j*ky(i)*y)),-w/2,w/2,'ArrayValued',true);
end

Ic = @(k)fftshift(abs(fft(Ix)));
Ic_max = Ic(kx);

plot(kvec, Ic_max, '-o');
% plot(kvec,spline(kvec,Ic_max,kvec/3),'-o');
title('Peak critical current')
xlabel('B')
ylabel('I_c')
