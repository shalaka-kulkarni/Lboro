function [F,zeroX,zeroCount] = flipFn_zerocrossing(Y, X)

    n_arr = size(X);
    n = n_arr(2);
    zeroX  = zeros(size(X));
    zeroCount = 0;
    
    for i=1:n
        if Y(i) == 0
            zeroCount = zeroCount+1;
            zeroX(zeroCount) = X(i);
        end
    end
    
    if zeroCount>0
    
        initVal = zeroX(zeroCount);

        for i=zeroCount+1:n
            zeroX(i) = initVal;
        end

        multiplier = 1;    
        index = 1;
        F = zeros(size(Y));
        for i=1:n
            if X(i) == zeroX(index)
                multiplier = -multiplier;
                index = index+1;
            end
            F(i) = Y(i)*multiplier; 
        end
        
    else 
        F = Y;
    end
    
