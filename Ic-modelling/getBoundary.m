function [p1,p2] = getBoundary(Y) %note that this fn returns indices p1,p2 and not values
    slope = gradient(Y);
    n_arr = size(Y); n = n_arr(2);
    plot(linspace(-1,1,n),slope);
    max = 0; min = 0;
    for i=1:n-1
        if slope(i) > max && slope(i)*slope(i+1)>0
            p1 = i;
            max = slope(i);
        end
        if slope(i) < min && slope(i)*slope(i+1)>0
            p2 = i+1;
            min = slope(i);
        end
    end
