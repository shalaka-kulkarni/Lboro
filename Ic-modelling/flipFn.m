function [F,minX] = flipFn(Y, X)
    n = size(X);
    minX  = zeros(size(X));
    minCount = 0;
    buf = 5; %2*buf is the number of consecutive samples examined to determine a minimum
    for i=buf+1:(n-buf)
        if X(i) == min(X(i-buf:i+buf))
            minCount = minCount+1;
            minX(minCount) = X(i);
        end
    end
    
    multiplier = +1;    
    index = 1;
    F = zeros(size(Y));
    for i=1:n
        if X(i) == minX(index)
            multiplier = -multiplier;
            index = index+1;
        end
        F(i) = Y(i)*multiplier; 
    end
    
    
        
    
    