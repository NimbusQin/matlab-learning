function [u] = pidsimf(u1, u2)
persistent errori error_1
t = u1;
if t == 0
    errori = 0;
    error_1 = 0;
end

kp = 2.5;
ki = 0.02;
kd = 0.5;

error = u2;
errord = error - error_1;
errori = errori + error;

u = kp*error + ki*errori + kd* errord;
error_1 = error;