sig=load('./data/7.txt');% change to load other files 
len = length(sig);
fs = 200;
tm=(1:length(sig))/fs;
figure();
subplot(3,2,1);plot(tm(1:1800),sig(1:1800));ylabel('Raw signal')
% lowpass
B=[1 0 0 0 0 0 -2 0 0 0 0 0 1];
A=[1 -2 1];
sig_L=lowpass(sig,10,fs);
subplot(3,2,2);plot(tm(1:1800),sig_L(1:1800));ylabel('After lowpass');

syms z k
F = (1-2*(z)^(-6)+z^(-12))/(1-2*(z)^(-1)+z^(-2));
g = iztrans(F, z, k);
k = linspace(0,300,301);
gn = double( subs(g, sym('k'), k) );
plot(k, gn)
% highpass
B=[-1/32 zeros(1,15) 1 -1 zeros(1,14) 1/32];
A=[1 -1];
sig_h=highpass(sig_L,0.5);
subplot(3,2,3);plot(tm(1:1800),sig_h(1:1800));ylabel('After highpass');

syms z k
F = (-1/32+1*(z)^(-16)-1*(z)^(-17)+z^(-32))/(1-1*(z)^(-1));
g = iztrans(F, z, k);
k = linspace(0,300,301);
gn = double( subs(g, sym('k'), k) );
plot(k, gn)
