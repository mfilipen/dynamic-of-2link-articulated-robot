function [a,b]=f(X1, X2)
    x1 = X1(1);
    y1 = X1(2);
    x2 = X2(1);
    y2 = X2(2);

    a = (y2-y1)/(x2-x1);
    b = y1-a*x1;
end