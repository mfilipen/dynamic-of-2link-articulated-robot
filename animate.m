function animate(t,th1,th2)
l1 = 1;
l2 = 0.8;

n=fix(max(t)-t(1,1))*25;

if n==0
n=25;
end

h = figure;
filename = 'animation.gif';
k = fix(length(t)/n);
j=1;

while j*k < (length(t)-k-1) 

    i= j*k;
    x1 = 0;
    x2 = l1 * cos(th1(i));
    x3 = l1 * cos(th1(i)) + l2 * cos(th1(i)+th2(i));

    y1 = 0;
    y2 = l1 * sin(th1(i));
    y3 = l1 * sin(th1(i)) + l2 * sin(th1(i)+th2(i));
    clf();
    plotLine([x1 x2], [y1 y2],1);
    plotLine([x2 x3], [y2 y3],1);
    
    tr=fix(length(t)/30);
    
    for index=1:tr:(length(t)-1) 
        x3 = l1 * cos(th1(index)) + l2 * cos(th1(index)+th2(index));
        y3 = l1 * sin(th1(index)) + l2 * sin(th1(index)+th2(index));
        plotLine([x3 x3], [y3 y3],2);
    end

    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 

    if i == k
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime', 0); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime', 0); 
    end
    
    pause(0.01);
    j=j+1;
end
    
  
    

end