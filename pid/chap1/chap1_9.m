clear all;
close all;

ts = 0.001;
sys = tf([523500], [1 87.35, 10470, 0]);
% 连续时间系统转换为离散时间系统
dsys = c2d(sys, ts, 'zoh');
% 获得分子分母系数
[num, den] = tfdata(dsys, 'v');

u_1 = 0.0; u_2 = 0.0; u_3 = 0.0;
y_1 = 0.0; y_2 = 0.0; y_3 = 0.0;
x = [0,0,0]';
error_1 = 0;

for k = 1:1:500
    time(k) = k * ts;

    mode = 3;
    if mode == 1
        % 阶跃信号
        yd(k) = 1;
        kp = 0.5;ki = 0.001; kd = 0.001;
    elseif mode == 2
        % 方波信号
        yd(k) = sign(sin(2*2*pi*time(k)));
        kp = 0.5;ki = 0.001; kd = 0.001;
    elseif mode == 3
        % 正弦信号
        yd(k) = 0.5*sin(2*2*pi*time(k));
        kp = 1.5;ki = 1.0; kd = 0.01;
    end

    %PID controller
    u(k) = kp*x(1) + kd*x(2) + ki*x(3);
    if u(k) > 10
        u(k) = 10;
    end
    if u(k) < -10
        u(k) = -10;
    end

    % Linear model
    y(k) = -den(2)*y_1 - den(3)*y_2 - den(4)*y_3 ...
        + num(2)*u_1 + num(3)*u_2 + num(4)*u_3;

    error(k) = yd(k) - y(k);
    x(1) = error(k);
    x(2) = (error(k) - error_1)/ts;
    x(3) = x(3) + error(k)*ts;
    error_1 = error(k);

    u_3 = u_2; u_2 = u_1; u_1 = u(k);
    y_3 = y_2; y_2 = y_1; y_1 = y(k);
end

figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('Ideal position signal','Position tracking');
        