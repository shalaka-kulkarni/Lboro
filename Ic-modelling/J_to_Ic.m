%current density predefined/known

L = 500E-9; w = 100E-9; N = 100;

%J1 = @(x,y)((heaviside(x+L) - heaviside(x-L))*(heaviside(y+w) - heaviside(y-w)));
%J1 = @(x,y)(sin(x));
J1 = @(x,y)(x*x/L + 2)*(y*y/w + 2);

xvec = linspace(-L/2,L/2,N);
yvec = linspace(-w/2,w/2,N); 

%Ix = @(x)integral(@(y)arrayfun(@(x,y)J0(x,y),x,y),-b,b); %,'ArrayValued',true);
Ix = zeros(size(xvec));
for i=1:N
    Ix(i) = integral(@(y)J1(xvec(i),y),-w/2,w/2,'ArrayValued',true);
end

plot(xvec,Ix);

kvec = linspace (-1,1,N);
Ic = @(k)fftshift(abs(fft(Ix)));

plot(kvec,Ic(kvec),'-o');

%%% try plotting a fraction of the spectrum, doing away with the delta 


%%%%%%%%%%%%%%%%Trials%%%%%%%%%%%%%%%%%

%plot(kvec,fft(sinc(kvec)));

f1 = @(x)fftshift(fft(heaviside(x+1) - heaviside(x-1)));
%x11 = linspace(0,3,3*N);
x11 = 0:N;
%plot(kvec,f1(kvec));
%plot(linspace(-4,4,500),ifft(heaviside(x+1) - heaviside(x-1)));







