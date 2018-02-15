function [theta1, theta2]=inverseKinematics(x,y)
    l1 = 1;
    l2 = 0.8;
   
    theta2(1)=acos((x^2 + y^2 - (l1^2 + l2^2))/(2 * l1 * l2));
    theta2(2)=(-1)*theta2(1);
    
    theta1(1)=atan(y/x) - atan(l2*sin(theta2(1))/(l1+l2*cos(theta2(1))));
    theta1(2)=atan(y/x) - atan(l2*sin(theta2(2))/(l1+l2*cos(theta2(2))));
end