function dx=df(x,t)
    dx=zeros( 1, length(x)-1);
    for i=1:(length(x)-1)
       dx(i)=(x(i+1) - x(i))/(t(i+1) - t(i));
    end
end