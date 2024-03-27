clear all;
close all;

ts = 0.001;
xk = zeros(2, 1);
e_1 = 0;
u_1 = 0;

for k = 1:1:2000
    time(k) = k * ts;
    yd(k) = 0.5 * sin(1*2*pi*time(k));

    para = u_1;
    tspan = [0 ts];
    [tt, xx] = ode45('chap1_6plant', tspan, xk, [], para);
    len = length(xx);
    xk = xx(len, :);

    y(k) = xk(1);
    e(k) = yd(k) - y(k);
    de(k) = (e(k) - e_1)/ts;

    u(k) = 20*e(k) + 0.5*de(k);
    if u(k) > 10
        u(k) = 10;
    end
    if u(k) < -10
        u(k) = -10;
    end

    u_1 = u(k);
    e_1 = e(k);
end

figure(1);
plot(time, yd, 'r', time, y, 'k:', 'LineWidth', 2);
xlabel('times(s)'); ylabel('yd,y');
legend('Ideal position signal','Position tracking');
figure(2);
plot(time,yd-y,'r','linewidth',2);
xlabel('time(s)'),ylabel('error');