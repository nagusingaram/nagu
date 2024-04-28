clc; close all;
x=randi([0 1],1,4096);
b=qammod(x,16);
snr = 0:2:30;
br = [];
y=reshape(b,64,64); 
q=ifft(y,64);
s=reshape(q,1,4096);
z=zeros(1,5120);
z(1:1024)=s(3073:4096);
z(1025:5120)=s(1:4096); % 25 percent cyclic prefix
for i=snr
     n=awgn(z,i,'measured');
     p=n(1025:5120);
     r=reshape(p,64,64);
     f=fft(r);
     fr=reshape(f,1,4096);
     d=qamdemod(fr,16);
     br=[br biterr(x,d)];
end
BER=br/length(x);
figure
semilogy(snr,BER,'*-r','linewidth',2);
title({"16 QAM"},{"BER Vs SNR"});
xlabel("SNR");
ylabel("BER(dB)");