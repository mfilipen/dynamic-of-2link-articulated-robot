function plotLine(X1,X2,i)
    if i==1
        line([0 0],[-2 2],'Color','green','LineStyle','-');
        line([2 -2],[0 0],'Color','green','LineStyle','-');
        line(X1,X2,'Color','red','LineStyle','-', 'Marker', 'o', 'LineWidth', 2);
    else
        line(X1,X2,'Color','blue','LineStyle','-', 'Marker', '.', 'MarkerSize', 2);
    end
    
end