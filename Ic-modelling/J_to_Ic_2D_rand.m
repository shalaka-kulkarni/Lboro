function Ic_max = J_to_Ic_2D_1(theta)

    fluxQuantum = 2.06783383E-15;
    lambda = 90E-9; 
    L = 500E-9; w = 500E-9; d0 = 10E-9; N = 500;
    
    d = generateRandom(1.2,0.8,N)*d0;
    
    k = 2*pi*(2*lambda+d)/fluxQuantum;
    J0 = 1E7;
    
    xvec = linspace(-L,L,N);
    yvec = linspace(-w,w,N);
    
    plot(xvec,d)
    title('Barrier thickness')
    
    pulse = @(t,a)(heaviside(t+a) - heaviside(t-a));
    J1 = @(x,y) J0*pulse(x,L/2)*pulse(y,w/2);
%     J1 = @(x,y) J0*(pulse(x,L/2)-pulse(x,L/4))*pulse(y,w/2);
%     J1 = @(x,y) J0*(pulse(x,L/2)-pulse(x,L/4))*(pulse(y,w/2)-pulse(y,w/4));
%     J1 = @(x,y) J0*(pulse(x,L/2)-pulse(x,9*L/20))*pulse(y,w/2);
%     J1 = @(x,y) J0*(pulse(x,L/2)-pulse(x,9*L/20))*(pulse(y,w/2)-pulse(y,9*w/20));
% %     J11 = @(x) (J0/2)*normpdf(x,0,L/4);%*pulse(y,w/2);
%     J1 = @(x,y) J0*normpdf(x,0,L/4)*normpdf(y,0,w/4);
%     J1 = @(x,y) J0*pulse(x,L/2)*(pulse(y,w/2)-pulse(y,9*w/20));
%     J1 = @(x,y) J0*pulse(x,L/2)*(pulse(y,w/2)-pulse(y,w/4));

%     Jrand = (J0/2)*generateRandom(1.1,0.9,N);
%     J1 = size(Jrand);
%     for i=1:N
%         J1(i) = Jrand(i) + J11(xvec(i))/1E7;
%     end
%     plot(xvec/L,J1,xvec/L,Jrand)
%     title('J (arbitrary units)')
 
    Bwidth = 0.15;
    c = cosd(theta);
    s = sind(theta);

    B = linspace(-Bwidth,Bwidth,N);
    By = c*B;
    Bx = s*B; 
    kx = k.*By; ky = k.*Bx;

    Ic_max = zeros(size(B));
    for i=1:N
    %     Ix(i) = integral(@(y)(J1(xvec(i),y)*exp(-1j*ky(i)*y)),-w/2,w/2,'ArrayValued',true);
%         f = @(x)integral(@(y)(J1(x,y).*exp(-1j*ky(i)*y)),-w/2,w/2,'ArrayValued',true);
        f = @(x)integral(@(y)(J1(x,y).*exp(-1j*ky(i)*y)),-w/2,w/2,'ArrayValued',true);
        Ic_max(i) = abs(integral(@(x)f(x).*exp(1j*kx(i)*x),-L/2,L/2));%,'ArrayValued',true);
    end
    % plot(ky,Ix);
    % Ic = @(k)fftshift(abs(fft(Ix)));
    % Ic_max = Ic(kx);

%     plot(B, Ic_max*1E6) 
%     title(['Peak critical current at \theta = ',num2str(theta)])
%     xlabel('B (T)')
%     ylabel('I_c (uA)')
 d = d0;
