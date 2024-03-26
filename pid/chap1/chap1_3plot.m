close all;

plot(t, y(:,1),'r', t, y(:,2), 'k:', 'LineWidth',2);
xlabel('time(s)'); ylabel('yd,y');
legend('Ideal position signal','Position tracking');