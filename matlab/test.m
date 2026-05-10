clear; clc; close all;

%% 参数：高电流线 Hochstrom
Rk = 12e-3;      % 12 mOhm
Lk = 120e-9;     % 120 nH

%% 频率范围
f = logspace(0, 7, 2000);   % 1 Hz 到 10 MHz
w = 2*pi*f;

%% 计算阻抗
Zk = Rk + 1j*w*Lk;
Zabs = abs(Zk);

%% 截止频率
fg = Rk / (2*pi*Lk);

%% dBOhm
Zabs_dBOhm = 20*log10(Zabs/1);

%% 输出结果
fprintf('fg = %.2f kHz\n', fg/1e3);
fprintf('|Zk(fg)| = %.2f mOhm\n', abs(Rk + 1j*2*pi*fg*Lk)*1e3);

%% 画线性阻抗
figure;
semilogx(f, Zabs*1e3, 'LineWidth', 1.5);
grid on;
xlabel('f / Hz');
ylabel('|Z_K| / mOhm');
title('Betrag der Leitungsimpedanz |Z_K|');
xline(fg, '--', sprintf('f_g = %.2f kHz', fg/1e3));

%% 画 dBOhm
figure;
semilogx(f, Zabs_dBOhm, 'LineWidth', 1.5);
grid on;
xlabel('f / Hz');
ylabel('|Z_K| / dB\Omega');
title('Leitungsimpedanz in dB\Omega');
xline(fg, '--', sprintf('f_g = %.2f kHz', fg/1e3));
yline(20*log10(Rk), '--', 'DC-Wert');
yline(20*log10(Rk)+3, '--', '+3 dB');