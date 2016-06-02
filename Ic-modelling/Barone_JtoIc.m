%current density predefined/known

a = 1; b = 1; N = 500;

J0 = @(x,y)(heaviside(x+a) - heaviside(x-a));

xvec = linspace(-2*a,2*a,N);
yvec = linspace(-2*b,2*b,N); 

%Ix = @(x)integral(@(y)arrayfun(@(x,y)J0(x,y),x,y),-b,b); %,'ArrayValued',true);
Ix = zeros(size(xvec));
for i=1:N
    Ix(i) = integral(@(y)J0(xvec(i),y),-b,b,'ArrayValued',true);
end

plot(xvec,Ix);

kvec = linspace (-4,4,N);
Ic = @(k)abs(fft(Ix));

P2 = abs(Ic(kvec)/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = kvec(1:N/2+1);
plot(f,P1);

%plot(kvec,fft(sinc(kvec)));

%plot(kvec,Ic(kvec));

%%%%%%%%%%%%%%%%Trials%%%%%%%%%%%%%%%%%
f1 = @(x)fft(heaviside(x+1) - heaviside(x-1));
x11 = linspace(0,3,N);
plot((f1(x11)));
%plot(linspace(-4,4,500),ifft(heaviside(x+1) - heaviside(x-1)));







