[t, X]=dynamic([10; 10],[0; 0; 0; 0;],[0 2]);  

figure;
plot(t, X);
grid; 
hold on;
legend('theta1','theta2','(d/dt)theta1','(d/dt)theta2');

xlabel('time(s)'); 
ylabel('');
grid on; 
animate(t,X(:,1),X(:,2)); 