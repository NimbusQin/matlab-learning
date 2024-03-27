clear all;
close all;


ts = 0.001;
sys = tf(400, [1, 50, 0]);
dsys = c2d(sys, ts, 'zoh');
[num, den] = tfdata(dsys, 'v');

u1 = 0.0; u2 = 0.0;
y1 = 0;   y2 = 0;
x  = [0, 0, 0]';
error1 = 0;
error2 = 0;

for k = 1:1:1000
    time(k) = k*ts;

    yd(k) = 1.0;
    kp = 8;
    ki = 0.1;
    kd = 10;

    du(k) = kp * x(1) + kd * x(2) + ki * x(3);
    u(k) = u1 + du(k);

    if u(k) > 10
        u(k) = 10;
    end
    if u(k) < -10
        u(k) = -10;
    end

    y(k) = - den(2) * y1 - den(3) * y2 + num(2) * u1 + num(3) * u2;

    error = yd(k) - y(k);
    u2 = u1; u1 = u(k);
    y2 = y1; y1 = y(k);

    x(1) = error - error1;
    x(2) = error - 2 * error1 + error2;
    x(3) = error;

    error2 = error1;
    error1 = error;
end
figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
