%current density predefined/known
fluxQuantum = 2.06783383E-15;
L = 600E-9; w = 600E-9; d = 10E-9; N = 100;
k = 2*pi*d/fluxQuantum;

pulse = @(t,a)(heaviside(t+a) - heaviside(t-a));
J1 = @(x,y) pulse(x,L/2)*pulse(y,w/2);
% J1 = @(x,y) (pulse(x,L/2)-pulse(x,L/4))*pulse(y,w/2);

xvec = linspace(-L,L,N);
yvec = linspace(-w,w,N); 
Bwidth = 1;
theta = 0;
c = cosd(theta);
s = sind(theta);

B = linspace(-Bwidth,Bwidth,N);
By = c*B;
Bx = s*B; 
kx = k*By; ky = k*Bx;

Ix = zeros(size(xvec)); Ic_max2 = zeros(size(B));
% Ic_max = zeros(size(B));
for i=1:N
%     Ix(i) = integral(@(y)(J1(xvec(i),y)*exp(-1j*ky(i)*y)),-w/2,w/2,'ArrayValued',true);
    f = @(x)integral(@(y)(J1(x,y).*exp(-1j*ky(i)*y)),-w/2,w/2,'ArrayValued',true);
    Ic_max2(i) = abs(integral(@(x)f(x).*exp(1j*kx(i)*x),-L/2,L/2));%,'ArrayValued',true);
end
% plot(ky,Ix);
% Ic = @(k)fftshift(abs(fft(Ix)));
% Ic_max = Ic(kx);

plot(B, Ic_max2,'-o');
% plot(B,spline(B,Ic_max,B/3),'-o');
title('Peak critical current')
xlabel('B')
ylabel('I_c')
