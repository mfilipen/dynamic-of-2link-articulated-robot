function y=dynamic_model(t,x,tau)
    
    theta(1) = x(1);
    theta(2) = x(2);
  
    l1 = 1;
    m1 = 5;
    m2 = 4;
    lg1 = 0.3;
    lg2 = 0.2;
    Ig1 = 0.87;
    Ig2 = 0.65;
    g_const=9.81;
   
    D(1,1) = m1*lg1^2 + m2*(l1^2 + lg2^2 + 2 * l1 * lg2 *cos(theta(2))) +...
        Ig1 + Ig2;
    D(1,2) = m2 * (lg2^2 + l1 * lg2 * cos(theta(2))) + Ig2;
    D(2,1) = D(1,2);
    D(2,2) = m2*lg2^2 +Ig2;
    
    C(1, 1) = x(4);
    C(1, 2) = x(3) + x(4);
    C(2, 1) = -1 * x(3);
    C(2, 2) = 0;
    C = -1 * m2 * l1 * lg2 * sin (theta(2)) * C;
    
 
    
    g(1) = m1 * g_const * lg1 * cos(theta(1)) +... 
           m2 * g_const * (l1 * cos(theta(1)) + lg2 * cos(theta(1) + theta(2))) ;
       
    g(2) = m2 * g_const * lg2 * cos(theta(1) + theta(2));
        
    A=inv(D) * (-1 * C * [x(3); x(4)] - g' + tau );

    y(1)=x(3);
    y(2)=x(4);
    y(3)=A(1);
    y(4)=A(2);
    
    y=y';
end

