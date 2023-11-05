sig=load('./data/7.txt');% change to load other files 
len = length(sig);
fs = 200;
tm=(1:length(sig))/fs;
figure();
plot(tm(1:1800),sig(1:1800));ylabel('Amplitude');
xlabel('time');title('Raw Signal');
figure();
% lowpass
B=[1 0 0 0 0 0 -2 0 0 0 0 0 1];
A=[1 -2 1];
sig_L=lowpass(sig,15,fs);
plot(tm(1:1800),sig_L(1:1800));ylabel('Amplitude');
xlabel('time');title('After Low pass');
figure();
% highpass
B=[-1/32 zeros(1,15) 1 -1 zeros(1,14) 1/32];
A=[1 -1];
sig_h=highpass(sig_L,5,fs);
plot(tm(1:1800),sig_h(1:1800));ylabel('Amplitude');
xlabel('time');title('After High Pass');
figure();
% difference
B=1/8*[2 1 0 -1 -2];
A=[1];
sig_d=filter(B,A,sig_h);
plot(tm(1:1800),sig_d(1:1800));ylabel('Amplitude');
xlabel('time');title('Derivative');
figure();
% square
sig_s=sig_d.^2;
plot(tm(1:1800),sig_s(1:1800));ylabel('Amplitude');
xlabel('time');title('Squaring');
figure();
% window average
N=round(0.15*fs);
B=1/N*ones(1,N);
A=[1];
sig_w=filter(B,A,sig_s);
plot(tm(1:1800),sig_w(1:1800));ylabel('Amplitude');
xlabel('time');title('Window Integration');
