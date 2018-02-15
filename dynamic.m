function [t, X]=dynamic(tau,x0,dt)
    [t, X] = ode45(@(t,X) dynamic_model(t,X,tau), dt, x0);
end