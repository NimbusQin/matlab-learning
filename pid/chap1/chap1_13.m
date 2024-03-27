clear all;
close all;

ts = 20;
sys = tf(1, [60, 1], 'inputdelay', 80);
dsys = c2d(sys, ts, 'zoh');
[num, den] = tfdata(dsys, 'v');

% u延迟5
u1 = 0; u2 = 0; u3 = 0; u4 = 0; u5 = 0;
y1 = 0;
error1 = 0;
errori = 0;

for k = 1:1:200
    time(k) = k * ts;

    y(k) = - den(2) * y1 + num(2) * u5;

    yd(k) = 40;
    error(k) = yd(k) - y(k);
    errori = errori + error(k) * ts;

    if abs(error(k)) >= 30
        beta = 0.0;
    elseif abs(error(k)) >= 20
        beta = 0.6;
    elseif abs(error(k)) >= 10
        beta = 0.9;
    else
        beta = 1.0;
    end

    kp = 0.80; ki = 0.005; kd = 3.0;
    u(k) = kp * error(k) + kd * (error(k) - error1) / ts + beta * ki * errori;
    if u(k) > 110
        u(k) = 110;
    end
    if u(k) < -110
        u(k) = -110;
    end

    u5 = u4; u4 =u3; u3 = u2; u2 = u1; u1 = u(k);
    y1 = y(k);
    error1 =error(k);
end

figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
figure(2);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');