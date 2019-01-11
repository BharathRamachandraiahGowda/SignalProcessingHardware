
clear all
close all
clc

Amplitude = 5;
offset = 2;
yScale = (Amplitude + offset);

Fm_I = 8000;
Fm_Q = 8000;

t = linspace(0,10,max(Fm_I, Fm_Q)); 
mt_I = cos(2 * pi * Fm_I * t);
mt_Q = sin(2 * pi * Fm_Q * t);

figure;
subplot(4,1,1);
plot(t, mt_I);
title('Input signal 1');
axis([0 10 -yScale yScale]);
subplot(4,1,2);
plot(t, mt_Q);
title('Input signal 2');
axis([0 10 -yScale yScale]);

Input_I = mt_I;
Input_Q = mt_Q;

% Test_I = sawtooth(2*pi*Fm_I*t);
% Input_I = mt_I;
% Input_Q = 0;

% Carrier Signal
Amplitude = 5;
Fc = 10 * max(Fm_I, Fm_Q);
t = linspace(0,10,max(Fm_I, Fm_Q));

phase = 0;
ct_I = Amplitude * cos(2*pi*Fc*t - phase);
phase = (2*pi)/4;
ct_Q = Amplitude * cos(2*pi*Fc*t - phase);

subplot(4,1,3);
plot(ct_I);
title('Carrier signal 1');
axis([0 8000 -yScale yScale]);
subplot(4,1,4);
plot(ct_Q);
title('Carrier signal 2');
axis([0 8000 -yScale yScale]);

% Modulate the signals
yt_I = Input_I .* ct_I;
yt_Q = Input_Q .* ct_Q;
yt = yt_I + yt_Q;

figure;

subplot(3,1,1);
plot(yt_I);
title('Modulated signal(Input Signal 1 and Carrier Signal 1)');
axis([0 8000 -yScale yScale]);

subplot(3,1,2);
plot(yt_Q);
title('Modulated signal(Input Signal 2 and Carrier Signal 2)');
axis([0 8000 -yScale yScale]);

subplot(3,1,3);
plot(yt);
title('Modulated signal');
axis([0 8000 -yScale yScale]);

% Demodulate the signals
rt_I = yt .* ct_I;
rt_Q = yt .* ct_Q;

figure;
subplot(2,1,1);
plot(rt_I);
subplot(2,1,2);
plot(rt_Q);

[b, a] = butter(5, 2*pi*(2 * max(Fm_I, Fm_Q))/(Fc * 100));
rt_I = filter(b, a, rt_I)/(Amplitude * 2);
rt_Q = filter(b, a, rt_Q)/(Amplitude * 2);

figure;
subplot(4,1,1);
plot(t, rt_I);
title('De-modulated signal 1');
axis([0 10 -yScale yScale]);

subplot(4,1,2);
plot(t, rt_Q);
title('De-modulated signal 2');
axis([0 10 -yScale yScale]);

subplot(4,1,3);
plot(t, Input_I, 'c', t, rt_I, 'b--');
title('Compare Input signal 1 and De-modulated signal 1');
axis([0 10 -yScale yScale]);

subplot(4,1,4);
plot(t, Input_Q, 'c', t, rt_Q, 'b--');
title('Compare Input signal 2 and De-modulated signal 2');
axis([0 10 -yScale yScale]);

figure;
subplot(2,2,1);
plot(abs((fft(mt_I))));
title('Frequency Spectrum of signal 1');
axis([-10000 10000 0 inf]);

subplot(2,2,2);
plot(abs((fft(mt_Q))));
title('Frequency Spectrum of signal 2');
axis([-10000 10000 0 inf]);

subplot(2,2,3);
plot(abs((fft(rt_I))));
title('Frequency Spectrum of received signal 1');
axis([-10000 10000 0 inf]);

subplot(2,2,4);
plot(abs((fft(rt_Q))));
title('Frequency Spectrum of received signal 2');
axis([-10000 10000 0 inf]);