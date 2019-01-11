
clear all
close all
clc

mt = audioread('speech_dft_8kHz.wav');
Fm = 8000;
SampleFactor = size(mt)/Fm;
[Samples_m Samples_n] = size(mt);

% Hilbert Transform
% Obtain real and imaginary part of the signal
h = hilbert(mt);
h = transpose(h);
Input_I = real(h);
Input_Q = imag(h);

% Carrier Signal
Fc = 10 * Fm;
Fs = Fc * SampleFactor;
Tc = 1/Fc;
t = linspace(0,100,Samples_m);
%t = (0:1/Fs:Samples_m);
%f = dsp.SpectrumAnalyzer('SampleRate', Fs);

Ac = 5;
Wc = 2*pi*Fc;
phase = 0;
ct_I = Ac * cos(Wc * t - phase);
phase = (2*pi)/4;
ct_Q = Ac * cos(Wc * t - phase);

% Modulate the signals
yt_I = Input_I .* ct_I;
yt_Q = Input_Q .* ct_Q;
yt = yt_I + yt_Q;

% Demodulate the signals
rt_I = yt .* ct_I;
rt_Q = yt .* ct_Q;

[b, a] = butter(10, 2*Fm/Samples_m);
rt_I = filter(b, a, rt_I)/Ac;
rt_Q = filter(b, a, rt_Q)/Ac;

figure;
subplot(4,1,1);
plot(mt);
subplot(4,1,2);
plot(ct_I);
hold;
plot(ct_Q);
subplot(4,1,3);
plot(yt_I);
hold;
plot(yt_Q);
subplot(4,1,4);
plot(yt);
%step(f,ct_I);
figure;
subplot(4,1,1);
plot(rt_I);
subplot(4,1,2);
plot(rt_Q);
subplot(4,1,3);
plot(t, Input_I, 'c', t, rt_I, 'b--');
subplot(4,1,4);
plot(t, Input_Q, 'c', t, rt_Q, 'b--');
