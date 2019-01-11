clear all
close all
clc

%Modulation and Demdoulation of a signal

t = linspace(0, 0.02, 10000);

%Characteristics of input signal
A_i = 5;
f_i = 1000;
T_i = 1/f_i;
w_i = 2 * pi * f_i * t;

%Compute the I and Q component of Input signal
Input_i = A_i * sin(w_i);
Input_q = A_i * cos(w_i);

%Characteristics of carrier signal 
A_c = 15;
f_c = 20000;
Fs = f_c * 100;
T_c = 1/f_c;
w_c = 2 * pi * f_c * t;
Freq = -Fs/2:1:Fs/2;

%Compute the I and Q component of carrier signal
I = A_c * sin(w_c);
Q = A_c * cos(w_c);

%Compute the modulated signal
st = (I .* Input_i) + (Q .* Input_i);
sf = fft(st);

plot_figure(1, t, st, (f_c/f_i)*5, 'time', 'amp', 'title');
plot_figure(2, Freq, abs(sf), 10000, 'time', 'amp', 'title');

function plot_figure(sub, X, Y, Samples, X_Label, Y_Label, Title)
    X_plot = 2;
    Y_plot = 1;
    
    subplot(X_plot,Y_plot,sub);
    plot(X(1,1:Samples), Y(1,1:Samples));
    
    xlabel(X_Label);
    ylabel(Y_Label);
    title(Title);
end