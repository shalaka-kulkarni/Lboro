%current density predefined/known

a = 10E-9; b = 10E-9; N = 100;

J0 = @(x,y)(heaviside(x+a) - heaviside(x-a));

xvec = linspace(-2*a,2*a,N);
yvec = linspace(-2*b,2*b,N); 

%Ix = @(x)integral(@(y)arrayfun(@(x,y)J0(x,y),x,y),-b,b); %,'ArrayValued',true);
Ix = zeros(size(xvec));
for i=1:N
    Ix(i) = integral(@(y)J0(xvec(i),y),-b,b,'ArrayValued',true);
end

plot(xvec,Ix);

kvec = linspace (-1,1,N);
Ic = @(k)fftshift(abs(fft(Ix)));

plot(kvec,Ic(kvec));



%%%%%%%%%%%%%%%%Trials%%%%%%%%%%%%%%%%%

%plot(kvec,fft(sinc(kvec)));

f1 = @(x)fftshift(fft(heaviside(x+1) - heaviside(x-1)));
%x11 = linspace(0,3,3*N);
x11 = 0:N;
%plot(kvec,f1(kvec));
%plot(linspace(-4,4,500),ifft(heaviside(x+1) - heaviside(x-1)));







