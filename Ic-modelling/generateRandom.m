function J = generateRandom(max,min,N)
    J = zeros(1,N);
    for i=1:N
        J(i) = rand()*(max-min) + min;
    end
    v = linspace(-1,1,N);
    Jsmooth = spline(v,J,v/10);
%     plot(v,Jsmooth)
%     title('J (arbitrary units)')
    J = Jsmooth;
