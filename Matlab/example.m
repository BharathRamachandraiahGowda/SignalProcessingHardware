clear all
close all
clc

f = 5;
Fs = 150 * f;
t = 0:1/Fs:1;
x = sin(2 * pi * f * t);
X = abs(fftshift(fft(x)));

df = -Fs/2:1:Fs/2;
figure;
%plot_figure(1, t(1,1:300),x(1,1:300));
plot_figure(1, t,x);
plot_figure(2, df,X);


function plot_figure(sub, X, Y)
    subplot(2,1,sub);
    plot(X, Y);
end
