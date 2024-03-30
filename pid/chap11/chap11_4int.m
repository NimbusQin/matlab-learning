clear all;
close all;

% 电流环
L = 0.001;  % 电感
R = 1;  % 电阻

ki = 0.001;  % 电流反馈系数
km = 1.0;  %  电机力矩系数

% 速度环
kd = 6;  % 速度增益系数
kv = 2;  % 速度反馈系数

J = 2;  % 电机和负载的等效转动惯量和
b = 1;  % 电机和负载的等效黏性阻尼系数和

Ce = 0.001;  % 电机反电动势系数

ku = 11;  % PWM功率放大倍数

% 摩擦模型
Fc = 100.0;
bc = 30.0;

% 位置环
kpp = 150;
kii = 0.1;
kdd = 1.5;

% 根据摩擦模型设计的前馈控制
Gain = ku * kd * 1/R * km * 1.0;
Fc1 = Fc/Gain;
bc1 = bc/Gain;