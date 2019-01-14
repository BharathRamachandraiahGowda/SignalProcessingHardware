% Matlab script to generate the low-pass filter test signal

clear all; close all; clc;

t = linspace(0,1,1025);
f = fi(((0.25*sin(2*pi*1*(t)))+0.5)+0.24*sin(2*pi*500*(t)),1,16,15);

set(gcf,'color','w');
plot(t,f);
box off; axis tight;

fileID = fopen('D:\HDA\1_sem\SignalProcessingHardware\Lab\sph_2018_lab_1\sine16bit1024.txt','w');
for i=1:length(f)-1
	fprintf(fileID,'%s\n',hex(f(i)));
end
fclose(fileID);