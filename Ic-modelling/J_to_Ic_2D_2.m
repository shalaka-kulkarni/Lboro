function Ic_max = J_to_Ic_2D_2(theta)

    fluxQuantum = 2.06783383E-15;
    lambda = 90E-9; 
    L = 500E-9; w = 500E-9; d = 10E-9; N = 500;
    Bwidth = 0.15;
    k = 2*pi*(2*lambda+d)/fluxQuantum;

%     f = @(x)(w/2); %rectangular
    % f = @(x) (w/2)*sqrt(1-4*(x*x)/(L*L)); %elliptical
    % f = @(x)(w/2)*cos(pi*x/L); %sinusoid
    f = @(x)(w/2)*(1-(2/L)*abs(x)); %diamond

    pulse = @(t,a)(heaviside(t+a) - heaviside(t-a));
    J1 = @(x,y) 1E7*pulse(x,L/2)*pulse(y,w/2);
    % J1 = @(x,y) (pulse(x,L/2)-pulse(x,L/4))*pulse(y,w/2);
    
    c = cosd(theta);
    s = sind(theta);

    B = linspace(-Bwidth,Bwidth,N);
    By = c*B;
    Bx = s*B;
    kx = k*By; ky = k*Bx;

    n = 100;
    xvect = linspace(-L/2,L/2,n); yvect = zeros(size(xvect));
    for i=1:n
        yvect(i) = f(xvect(i));
    end
    
    
    Ic_max = zeros(size(B));
    for i=1:N
        fxn = @(x,y)J1(x,y).*cos(kx(i)*x-ky(i)*y);
        Ic_max(i) = abs(myIntegrate(fxn, xvect, yvect, n));
%         Ic_max(i) = 2*abs(integral(@(x)(J1(x)*f(x)*cos(k*B(i)*x)),-L/2,L/2,'ArrayValued',true));
    end
    I0 = Ic_max(N/2);
    flux = B*L*(2*lambda+d);
    n = flux/fluxQuantum;

    % plot(n, Ic_max/I0) 
    % title('Peak critical current')
    % xlabel('\phi/\phi_0')
    % ylabel('I_c/I_0')

%     plot(B*1E3, Ic_max/I0) 
%     title('Peak critical current')
%     xlabel('B (mT)')
%     ylabel('I_c/I_0')
