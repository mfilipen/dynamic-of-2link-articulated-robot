function [T, X]=dynamicTime(t, tau, x0)
    x0_=zeros(4,1);
    tau_=zeros(2,1);
    x0_=x0;
    tau_=tau(:,1);
    T=zeros(1, 1);
    X=zeros(1, 4);
    
    for i=(1:length(t)-1)
        dt=[t(i) t(i+1)];
        [t_, X_]=dynamic(tau_,x0_,dt);
        n=length(X_);
        x0_=X_(n,:)';
        tau_=tau(:,i);
        if i==1
            T=t_;
            X=X_;
        else
            T=[T; t_];
            X=[X; X_];
        end
    end      
end