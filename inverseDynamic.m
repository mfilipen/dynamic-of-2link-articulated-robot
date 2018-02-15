function [t,  tau]=inverseDynamic(q, dq, ddq, t)
    l1 = 1;
    m1 = 5;
    m2 = 4;
    lg1 = 0.3;
    lg2 = 0.2;
    Ig1 = 0.87;
    Ig2 = 0.65;
    g_const=9.8;
  
    tau=zeros( 2, length(t));
    
    for i=1:length(t) 
        theta1=q(1,i);
        theta2=q(2,i);
        dtheta1=dq(1,i);
        dtheta2=dq(2,i);
        
        D(1,1) = m1*lg1^2 + m2*(l1^2 + lg2^2 + 2 * l1 * lg2 *cos(theta2))+...
                 Ig1 + Ig2;
        D(1,2) = m2 * (lg2^2 + l1 * lg2 * cos(theta2)) + Ig2;
        D(2,1) = D(1,2);
        D(2,2) = m2*lg2^2 +Ig2;

        C(1, 1) = dtheta2;
        C(1, 2) = dtheta1 + dtheta2;
        C(2, 1) = -1 * dtheta1;
        C(2, 2) = 0;
        C = -1 * m2 * l1 * lg2 * sin (theta2) * C;

        g(1) = m1 * g_const * lg1 * cos (theta1) + m2 * g_const * (l1 * cos (theta1) + lg2 * cos (theta1 + theta2));
        g(2) = m2 * g_const * lg2 * cos(theta1 + theta2);
        
        dq_ = dq(:,i);
        ddq_ = ddq(:,i);
        
        tau(:,i) = D * ddq_ + C * dq_ + g';
    end
end