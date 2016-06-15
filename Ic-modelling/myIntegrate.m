function intg2 = myIntegrate(fxn, xvect, yvect, n)

    intg2 = 0;
    del = xvect(2)-xvect(1);
    for i=1:n
        intg1 = integral(@(y)fxn(xvect(i),y),-yvect(i),yvect(i));
        intg2 = intg2 + intg1*del;
    end
    
    
