function [sys, x0, str, ts] = s_function(t, x, u, flag)
switch flag
    case 0  % Initialization
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 3  % Outputs
        sys = mdlOutputs(t,x,u);
    case {2, 4, 9}  % Unhandled flags
        sys = [];
    otherwise
        error(['Unhandled flag = ', num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates = 0;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 1;
sizes.NumInputs = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);

x0 = [];
str = [];
ts = [];

function sys = mdlOutputs(t,x,u)
error=u(1);
derror=u(2);
errori=u(3);

kp = 60;
ki = 1;
kd = 3;
ut = kp * error + kd * derror + ki * errori;
sys(1) = ut;  % 下标是什么意思，对外的输出序号？