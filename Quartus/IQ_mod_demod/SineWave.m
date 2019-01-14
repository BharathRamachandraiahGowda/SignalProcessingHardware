clc;
clear all;
close all;

n = linspace(0,1,257);
y = fi((0.99*sin(2*pi*n)),1,24,23);

set(gcf,'color','w');
plot(n,y);
box off;
axis tight;

fileID = fopen('D:\IntelInstalls\Setupfiles\Lab1\sine_0_360_24bit_256.txt','w');
for i = 1:length(y)-1
    fprintf(fileID,'%s\n',hex(y(i)));
end

fclose(fileID);
