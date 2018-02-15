%x y
clear all;
close all;
A=[0, 1.6];
B=[1.2, 0];
[a1,b1]= getLine(A, B);
line=@(x,a,b) a*x +b;
dist=@(A,B) sqrt((A(1)-B(1))^2 + (A(2)-B(2))^2);
lenght=dist(A,B);

time=1.2;
dt=time/1000;
t=0:dt:time;

a=10;
S=zeros(size(t));
for i=1:length(t)
    if t(i)<=0.2
        S(i)=(a*(t(i))^2)/2;
    end    
    if t(i)>=0.2 && t(i)<=1
        S(i)=0.2 + 2 * (t(i)-0.2);
    end
    if t(i)>=1
        S(i)=1.8 + 2 * (t(i)-1) - (a/2)*(t(i)-1)^2;
    end
end

%{
figure;
plot(t(1,:),S(1,:));
hold on;
legend('S(t)');
xlabel('time(s)'); 
ylabel('position(m)');
grid on; 
%}

x=zeros(size(t));
y=zeros(size(t));

cAlpha=1.2/2;
sAlpha=1.6/2;

for i=1:length(t)
    x(i)=cAlpha * S(i);
    y(i)=-1 * sAlpha * S(i) + 1.6;
end

%{
figure;
plot(t,x, t,y);
hold on;
legend('x(t)','y(t)');
xlabel('time(s)'); 
ylabel('position(m)');
grid on; 
%}

theta1=zeros(size(x));
theta2=zeros(size(x));

for i=1:size(x,2)
    [a , b] = inverseKinematics(x(i), y(i));
    theta1(i)= a(1);
    theta2(i)= b(1);
end

%{
figure;
plot(t,theta1, t,theta2);
hold on;
legend('theta1(t)','theta2(t)');
xlabel('time(s)'); 
ylabel('angle(rad)');
grid on; 
%}

dTheta1=df(theta1,t);
dTheta2=df(theta2,t);
dt=slice(t,1,-1);

ddTheta1=df(dTheta1,dt);
ddTheta2=df(dTheta2,dt);
ddt=slice(dt,1,-1);

%{
plot(t,theta1, t,theta2);
hold on;
plot(dt,dTheta1, dt,dTheta2);
hold on;
plot(ddt,ddTheta1, ddt,ddTheta2);
hold on;

legend('theta1(t)','theta2(t)',...
       '(d/dt)theta1(t)','(d/dt)theta2(t)',...
       '(d^2/dt)theta1(t)','(d^2/dt)theta2(t)' );
xlabel('time(s)'); 
ylabel('angle(rad)');
grid on; 
%}

theta=[theta1; theta2];
dTheta=[dTheta1; dTheta2];
ddTheta=[ddTheta1; ddTheta2];

%animate(t,theta1,theta2)

%solve inverse dynamic problem
[t_,  tau]=inverseDynamic(theta, dTheta, ddTheta, ddt);
%solve dynamic problem

%{
figure;
plot(t_(1,:),tau(1,:),t_,tau(2,:));
hold on;
legend('tau1(t)','tau2(t)');
xlabel('time(s)'); 
ylabel('torque(N?m)');
grid on; 
%}

tau_max=[0.3*max(abs(tau(1,:))); 0.3*max(abs(tau(2,:)))];
tauLimeted=boundTourque(tau, tau_max);

%plot(t_(1,:),tauLimeted(1,:),t_,tauLimeted(2,:));
%hold on;


theta0=[theta1(1);theta2(1)];
dtheta0=[dTheta1(1);dTheta2(1)];
x0=[theta0; dtheta0];

%{
[t_1, X1]=dynamicTime(t_, tau, x0);

figure;
plot(t_1, X1(:,1), t_1, X1(:,2), t,theta1, t,theta2);
legend('theta1-calculated(t)','theta2-calculated(t)',...
       'theta1(t)','theta2(t)');
xlabel('time(s)'); 
ylabel('angle(rad)');
grid on; 

animate(t_1,X1(:,1),X1(:,2)); 


%[t_2, X2]=dynamicTime(t_, tauLimeted, x0);
%figure;
%plot(t_2, X2(:,1), t_2, X2(:,2), t,theta1, t,theta2);
%animate(t_2,X2(:,1),X2(:,2)); 
%}

[t_3, X3,TAU]=PDcontrol(t, theta,-200,-1500,-100,-450);

figure;
plot(t_3, X3(:,1), t_3, X3(:,2), t,theta1, t,theta2);
hold on;
legend('theta1-calculated(t)','theta2-calculated(t)',...
       'theta1(t)','theta2(t)');
xlabel('time(s)'); 
ylabel('angle(rad)');
grid on; 


figure;
plot(t_(1,:),tau(1,:),t_,tau(2,:));
hold on;
plot(t_(1,:),TAU(1,1:999),t_,TAU(2,1:999));
legend('tau1(t)','tau2(t)','tau1-PD-calculated(t)','tau2-PD-calculated(t)');
xlabel('time(s)'); 
ylabel('torque(N?m)');
grid on; 

animate(t_3,X3(:,1),X3(:,2)); 

