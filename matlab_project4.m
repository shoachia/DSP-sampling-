close all;
clc;
L=3;%Upsampling the sample frequaency of the signal from 16k to 48k(i.e 3 times )
M=4;%Downsampling the sample frequaency of the signal from 16k to 48k(i.e 4 times )
[x,fs]=wavread('C:\Users\cheming\Desktop\e64021274-dsp-hw2-v1\Audio file for Chapter 4 project');
T=1/fs;
len=124907;
t=(0:len-1)*T;
p=-L:1:L;
hlin(p+L+1)=1-abs(p)/L;%Creat an impulse response for interpolation
%because of the matrix limitation ,hlin is the ideal  hlin shifting by 3
%samples
xe=zeros(L*len,1);
for l=1:1:124907
    xe(l*L)=x(l);
end
%   xe is the signal of upsampling that doesn't interpolate yet 
xlin=conv(hlin,xe);%the convolution of hlin & xe
for n=4:374727
    xlincorr(n)=xlin(n-3);
    %shift the signal back to the original point
end
for a=1:1:374727/M
    xfinal(a)=xlincorr(a*M);
end
%downsampling 
i=1:1:124907;
m=1:1:374727;
w=1:1:374727/M;
subplot(311),plot(m,xlincorr)
axis tight;
xlabel('value');
ylabel('48k amp');

subplot(312),plot(i,x)
axis tight;
xlabel('value');
ylabel('16k amp');

subplot(313),plot(w,xfinal)
axis tight;
xlabel('value');
ylabel('12k amp');
%plot the figure