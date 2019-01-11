clear all
close all
clc

fs=1000;
fm=100;
t=(0:1/fs:fs)';
x=sin(2*pi*fm*t);
f=dsp.SpectrumAnalyzer('SampleRate',fs);
step(f,x);