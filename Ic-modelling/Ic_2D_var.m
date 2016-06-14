
N = 500; n=5;

Ic = cell(n,N);

for i=0:n-1
    theta = i*10; %in degrees
    Ic_max = J_to_Ic_2D_1(theta);
    Ic{i+1} = Ic_max;
end
I0 = Ic{1}(N/2);
Bwidth = 0.15;
B = linspace(-Bwidth,Bwidth,N);

leg = cell(1,n);
figure
hold all
for i=1:n
    plot(B*1E3,Ic{i}/I0,'LineWidth',1);
    leg{i} = ['\theta = ',num2str((i-1)*10),'^o'];
end
title('Peak current variation with rotation of magnetic field')
xlabel('B (mT)')
ylabel('I_c/I_0)')
legend(leg)
