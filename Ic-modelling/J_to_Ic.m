%current density predefined/known

L = 500E-9; w = 100E-9; N = 100;

J1 = @(x,y)((heaviside(x+L/2) - heaviside(x-L/2))*(heaviside(y+w/2) - heaviside(y-w/2)));
% J1 = @(x,y)(sin(x));
% J1 = @(x,y)gaussmf(x,[1 0]);
% J1 = @(x,y)(x/L + 2)*(heaviside(x+L/2) - heaviside(x-L/2));
% J1 = @(x,y)(x/L + 2)*(heaviside(x+L/2) - heaviside(x-L/2))*(y/w + 2)*(heaviside(y+w/2) - heaviside(y-w/2));
% J1 = @(x,y) (1-abs(x))*(heaviside(x+L/2) - heaviside(x-L/2));

xvec = linspace(-L,L,N);
yvec = linspace(-w,w,N); 

%Ix = @(x)integral(@(y)arrayfun(@(x,y)J0(x,y),x,y),-b,b); %,'ArrayValued',true);
Ix = zeros(size(xvec));
for i=1:N
    Ix(i) = integral(@(y)J1(xvec(i),y),-w/2,w/2,'ArrayValued',true);
end

%plot(xvec,Ix);

kvec = linspace (-1,1,N);
Ic = @(k)fftshift(abs(fft(Ix)));

Ic_max = Ic(kvec);

%plot(kvec(N/2+3:end),Ic_max(N/2+3:end),'-o');
%plot(kvec(3*N/4:end),Ic_max(3*N/4:end),'-o');

plot(kvec, Ic_max, '-o');
%plot(kvec,spline(kvec,Ic_max,kvec/4),'-o');








