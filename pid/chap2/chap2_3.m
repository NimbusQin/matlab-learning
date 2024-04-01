clear all;
close all;

ts = 20;
K = 1;
tp = 60;
tol = 80;
sys = tf(K, [tp, 1], 'inputdelay', tol);
dsys = c2d(sys, ts, 'zoh');
[num, den] = tfdata(dsys, 'v');

u1 = 0.0; u2 = 0.0; u3 = 0.0; u4 = 0.0; u5 =0.0;
e1 = 0; ei = 0;
y1 = 0.0;

for k = 1:1:300
    time(k) = k * ts;
    yd(k) = 1.0;
    y(k) = -den(2) * y1 + num(2) * u5;

    e(k) = yd(k) - y(k);
    de(k) = (e(k) - e1)/ts;
    ei = ei + ts * e(k);

    delta = 0.885;
    TI = 160;
    TD = 40;
    u(k) = delta * (e(k) + 1/TI*ei + TD*de(k));

    e1 = e(k);
    u5 = u4; u4 = u3; u3 = u2; u2 = u1; u1 = u(k);
    y1 = y(k);
end

figure(1);
plot(time,yd,'r',time,y,'k:','linewidth',2);
xlabel('time(s)');ylabel('yd and y');
legend('ideal position signal','position tracking');