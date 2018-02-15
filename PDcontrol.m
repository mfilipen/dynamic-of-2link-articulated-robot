function [T,X,TAU]=PDcontrol(t, theta,Kp1,Kd1,Kp2,Kd2)

    
    x0=[theta(1,1); theta(2,1); 0; 0];
    tau=zeros(2,1);
    TAU=zeros(2,1);
    deltaTheta=zeros(2,1);
    T=zeros(1, 1);
    X=zeros(1, 4);
    
    Kp=zeros(1,2);
    Kd=zeros(1,2);
    
    Kp(1)=Kp1;
  
    
    delthaThetaBefor=zeros(2,1);
    for i=(1:length(t)-1)
        dt=[t(i) t(i+1)];
        deltaT=t(i+1)-t(i);
        
        [t_, X_]=dynamic(tau,x0,dt);
        
        n=length(X_);
        x0=X_(n,:)';
        
        deltaTheta(1)=X_(n,1)' - theta(1,i);
        deltaTheta(2)=X_(n,2)' - theta(2,i);
        
        tau(1)=Kp1*deltaTheta(1) + (Kd1/deltaT)*(deltaTheta(1)-delthaThetaBefor(1));
        tau(2)=Kp2*deltaTheta(2) + (Kd2/deltaT)*(deltaTheta(2)-delthaThetaBefor(2));
        
        delthaThetaBefor=deltaTheta;
        if i==1
            T=t_;
            X=X_;
            TAU=tau;
        else
            T=[T; t_];
            X=[X; X_];
            TAU=[TAU tau];
        end
        
    end    
   
end